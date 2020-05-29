#!/bin/bash

source image_info.txt

# Override version (e.g. pour utiliser x86_64_...)
VERSION=x86_64_1.26.2
IMAGE_DOCKER=$REPO/$NAME:$VERSION

echo Image docker : $IMAGE_DOCKER

export HOST=`hostname`
CERT_FOLDER=/home/mathieu/mgdev/certs
export MG_MQ_CAFILE=/certs/3N4iqEp3HxNN.pki.millegrille.cert.20200524123014
export MG_MQ_CERTFILE=/certs/3N4iqEp3HxNN.pki.coupdoeil.cert.20200524123020
export MG_MQ_KEYFILE=/certs/3N4iqEp3HxNN.pki.coupdoeil.key.20200524123020
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
