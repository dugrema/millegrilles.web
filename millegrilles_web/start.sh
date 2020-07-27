#!/usr/bin/env bash

CERT_FOLDER=/home/mathieu/mgdev/certs
# export MG_IDMG=vPXTaPjpUErFjV5d8pKrAHHqKhFUr7GSEruCL7
# export MG_CONSIGNATION_PATH=/var/opt/millegrilles/$IDMG/mounts/consignation

# Host pour cookies (idealement domaine complet)
export HOST=`hostname --fqdn`

# Host pour MQ, doit correspondre au cert (generalement nodename)
export HOSTMQ=`hostname -s`

# export COUPDOEIL_SESSION_TIMEOUT=15000
export MG_MQ_CAFILE=$CERT_FOLDER/pki.millegrille.cert
export MG_MQ_CERTFILE=$CERT_FOLDER/pki.web_protege.cert
export MG_MQ_KEYFILE=$CERT_FOLDER/pki.web_protege.key

# export WEB_CERT=~/.acme.sh/mg-dev3.maple.maceroc.com/fullchain.cer
# export WEB_KEY=~/.acme.sh/mg-dev3.maple.maceroc.com/mg-dev3.maple.maceroc.com.key
export MG_MQ_URL=amqps://$HOSTMQ:5673
export PORT=3000

export MG_HTTPPROXY_SECURE=false
export MG_CONSIGNATION_HTTP=https://$HOST:3003

# export SERVER_TYPE=spdy

# Parametre module logging debug
export DEBUG=millegrilles:*
export NODE_ENV=dev

npm start
