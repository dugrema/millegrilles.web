const debug = require('debug')('millegrilles:app')
const express = require('express')
const cookieParser = require('cookie-parser')
const { v4: uuidv4 } = require('uuid')
const logger = require('morgan')

// const routeAuthentification = require('./routes/authentification')
const {routeMillegrilles, sessionsUsager, comptesUsagers, amqpdao} = require('millegrilles.maitrecomptes')
const {initialiser: routeCoupdoeil, initSocketIo: coupdoeilSocketIo} = require('millegrilles.coupdoeil')

// Generer mot de passe temporaire pour chiffrage des cookies
const secretCookiesPassword = uuidv4()

// Creer une collection avec la connexion a MQ (format qui supporte hebergement)
var _idmg = null
const _rabbitMQParIdmg = {}
function fctRabbitMQParIdmg(idmg) {
  return _rabbitMQParIdmg[idmg]
}

async function initialiserApp() {
  const app = express()

  const {middleware: amqMiddleware, amqpdao: instAmqpdao} = await amqpdao.init()  // Connexion AMQ
  const {injecterComptesUsagers, extraireUsager} = comptesUsagers.init(instAmqpdao)

  // Conserver information IDMG et MilleGrilles
  _idmg = instAmqpdao.pki.idmg
  _rabbitMQParIdmg[_idmg] = instAmqpdao

  initLogging(app)                 // HTTP request logging

  app.use(cookieParser(secretCookiesPassword))
  app.use(injecterComptesUsagers)  // Injecte req.comptesUsagers
  app.use(amqMiddleware)           // Injecte req.amqpdao
  app.use(sessionsUsager.init())   // Extraction nom-usager, session

  // Par defaut ouvrir l'application React de MilleGrilles
  app.get('/', (req, res) => res.redirect('/millegrilles'))

  app.use('/millegrilles', routeMillegrilles.initialiser({extraireUsager}))

  app.use('/coupdoeil', routeCoupdoeil(fctRabbitMQParIdmg, {idmg: _idmg}))

  // API pour applications authentifiees (e.g. React)
  // app.use('/apps', routeApplications.initialiser({extraireUsager}))

  debug("Application MilleGrilles privee initialisee")

  return app
}

function initLogging(app) {
  const loggingType = process.env.NODE_ENV !== 'production' ? 'dev' : 'combined';
  app.use(logger(loggingType));  // logging
}


module.exports = {initialiserApp, coupdoeilSocketIo}
