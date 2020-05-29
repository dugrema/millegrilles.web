const debug = require('debug')('millegrilles:server')
const fs = require('fs')

function initServer(app) {

  // Serveurs supportes : https, spdy, (http2)
  const serverType = process.env.SERVER_TYPE || 'spdy'
  const serverTypeLib = require(serverType)
  debug("server: Type de serveur web : %s", serverType)

  const certPem = fs.readFileSync(process.env.MG_MQ_CERTFILE).toString('utf-8');
  const keyPem = fs.readFileSync(process.env.MG_MQ_KEYFILE).toString('utf-8');
  const certMillegrillePem = fs.readFileSync(process.env.MG_MQ_CAFILE).toString('utf-8');

  const hostIp = process.env.HOST;
  const port = process.env.PORT || '443'
  const config = {
      hostIp: hostIp,
      cert: certPem,
      key: keyPem,
  };
  debug('Demarrage server %s:%s', hostIp, port)

  const server = serverType === 'http2'?
    serverTypeLib.createSecureServer(config, app):
    serverTypeLib.createServer(config, app)

  server.listen(port)

  return server
}

module.exports = {initServer}
