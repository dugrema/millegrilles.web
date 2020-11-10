#!/usr/bin/env node

const debug = require('debug')('millegrilles:web:www')
const express = require('express')

const amqpdao = require('../models/amqpdao')
const {initialiser: initialiserServer} = require('millegrilles.common/lib/server3')
const {initialiser: initialiserCoupdoeil} = require('millegrilles.coupdoeil')
const {initialiser: initialiserMillegrilles} = require('millegrilles.maitrecomptes')
const {initialiser: initialiserSenseurspassifs} = require('millegrilles.senseurspassifs')
const {initialiser: initialiserGrosFichiers} = require('millegrilles.grosfichiers')
const {initialiser: initialiserPublication} = require('millegrilles.publication')

async function init() {

  // Connexion AMQ
  const {amqpdao: instAmqpdao, middleware: injecterAmqpdao} = await amqpdao.init()

  const idmg = instAmqpdao.pki.idmg

  debug("Initialisation serveur IDMG : %s", idmg)

  // Creer une collection avec la connexion a MQ (format qui supporte hebergement)
  const rabbitMQParIdmg = {
    [idmg]: instAmqpdao
  }
  const mqList = [instAmqpdao]
  const fctRabbitMQParIdmg = (idmg) => {
    return rabbitMQParIdmg[idmg]
  }

  // Initalier les apps individuelles, mapper dans dict (cle est path relatif)
  const millegrilles = await initialiserMillegrilles(fctRabbitMQParIdmg, {idmg})
  const coupdoeil = await initialiserCoupdoeil(fctRabbitMQParIdmg, {idmg})
  const senseurspassifs = await initialiserSenseurspassifs(fctRabbitMQParIdmg, {idmg})
  const grosfichiers = await initialiserGrosFichiers(fctRabbitMQParIdmg, {idmg})
  const publication = await initialiserPublication(fctRabbitMQParIdmg, {idmg})

  // Extraire gestionnaire de session
  const sessionMiddleware = millegrilles.session

  const root = express()
  root.use(injecterAmqpdao)

  const mappingApps = [
    {path: 'millegrilles', ...millegrilles},
    {path: 'coupdoeil', ...coupdoeil},
    {path: 'senseurspassifs', ...senseurspassifs},
    {path: 'grosfichiers', ...grosfichiers},
    {path: 'publication', ...publication},
  ]

  const serverInstance = initialiserServer(
    root, mappingApps,
    {
      pathSocketio: 'millegrilles',
      sessionMiddleware,
      fctRabbitMQParIdmg,
      mqList
    },
  )

}

init()
