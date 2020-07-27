#!/usr/bin/env node

const debug = require('debug')('millegrilles:web:www')
const express = require('express')

const amqpdao = require('../models/amqpdao')
const {initialiser: initialiserServer} = require('millegrilles.common/lib/server')
const {initialiser: initialiserCoupdoeil} = require('millegrilles.coupdoeil')
const {initialiser: initialiserMillegrilles} = require('millegrilles.maitrecomptes')
//const {initialiser: initialiserPosteur} = require('millegrilles.posteur')
//const {initialiser: initialiserVitrine} = require('millegrilles.vitrine')
//const {initialiser: initialiserMessagerie} = require('millegrilles.messagerie')

async function init() {

  // Connexion AMQ
  const {amqpdao: instAmqpdao, middleware: injecterAmqpdao} = await amqpdao.init()

  const idmg = instAmqpdao.pki.idmg

  debug("Initialisation serveur IDMG : %s", idmg)

  // Creer une collection avec la connexion a MQ (format qui supporte hebergement)
  const rabbitMQParIdmg = {
    [idmg]: instAmqpdao
  }

  const fctRabbitMQParIdmg = (idmg) => {
    return rabbitMQParIdmg[idmg]
  }

  // Initalier les apps individuelles, mapper dans dict (cle est path relatif)
  const millegrilles = await initialiserMillegrilles(fctRabbitMQParIdmg, {idmg})
  const coupdoeil = await initialiserCoupdoeil(fctRabbitMQParIdmg, {idmg})
  //const posteur = await initialiserPosteur(fctRabbitMQParIdmg, {idmg})
  //const vitrine = await initialiserVitrine(fctRabbitMQParIdmg, {idmg})
  //const messagerie = await initialiserMessagerie(fctRabbitMQParIdmg, {idmg})

  const root = express()
  root.use(injecterAmqpdao)

  const mappingApps = {coupdoeil, millegrilles}  //, posteur, vitrine, messagerie}
  const serverInstance = initialiserServer(root, mappingApps)

}

init()
