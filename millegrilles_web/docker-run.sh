#!/bin/bash

source image_info.txt
ARCH=`uname -m`

# Override version (e.g. pour utiliser x86_64_...)
# VERSION=x86_64_1.29.3
IMAGE_DOCKER=$REPO/${NAME}:${ARCH}_${VERSION}

echo Image docker : $IMAGE_DOCKER

export HOST=`hostname`
CERT_FOLDER=/home/mathieu/mgdev/certs
export MG_MQ_CAFILE=/certs/pki.millegrille.cert
export MG_MQ_CERTFILE=/certs/pki.web_protege.cert
export MG_MQ_KEYFILE=/certs/pki.web_protege.key
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
