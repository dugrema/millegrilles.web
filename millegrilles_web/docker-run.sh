#!/bin/bash

source image_info.txt

# Override version (e.g. pour utiliser x86_64_...)
VERSION=x86_64_1.27.0
IMAGE_DOCKER=$REPO/$NAME:$VERSION

echo Image docker : $IMAGE_DOCKER

export HOST=`hostname`
CERT_FOLDER=/home/mathieu/mgdev/certs
export MG_MQ_CAFILE=/certs/2DE28fU9miAD.pki.millegrille.cert.20200531123203
export MG_MQ_CERTFILE=/certs/2DE28fU9miAD.pki.coupdoeil.cert.20200531123213
export MG_MQ_KEYFILE=/certs/2DE28fU9miAD.pki.coupdoeil.key.20200531123213
export MG_MQ_URL=amqps://$HOST:5673
export PORT=3000

export DEBUG=millegrilles:*,coupdoeil:*

docker run --rm -it \
  --network host \
  -v /home/mathieu/mgdev/certs:/certs \
  -e MG_MQ_CAFILE -e MG_MQ_CERTFILE -e MG_MQ_KEYFILE \
  -e MG_MQ_URL -e PORT \
  -e DEBUG \
  $IMAGE_DOCKER
