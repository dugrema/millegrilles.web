const debug = require('debug')('millegrilles:www');
const server = require('./server')
const {initialiserApp, coupdoeilSocketIo} = require('./app');

async function init() {
  const app = await initialiserApp()
  const serverInstance = server.initServer(app);
  coupdoeilSocketIo(serverInstance)
}

init()
