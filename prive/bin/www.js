const debug = require('debug')('millegrilles:www');
const server = require('./server')
const {initialiserApp} = require('./appPrivee');

async function init() {
  const app = await initialiserApp()
  const serverInstance = server.initServer(app);
}

init()
