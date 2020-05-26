const debug = require('debug')('millegrilles:server');
const http = require('http');
const {initialiserApp} = require('./app');

async function init() {
  const port = 3000
  const config = {};

  const app = await initialiserApp();

  const server = http.createServer(config, app);
  server.listen(port);
}

init()
