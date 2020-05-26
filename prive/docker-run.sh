#!/bin/bash

source image_info.txt

# Override version (e.g. pour utiliser x86_64_...)
VERSION=x86_64_1.26.0
IMAGE_DOCKER=$REPO/$NAME:$VERSION

echo Image docker : $IMAGE_DOCKER

# docker run -d --rm \
#   -p 80:80 \
#   -p 443:443 \
#   $REPO/$NAME:$VERSION

# docker run --rm -it \
#   -p 80:80 \
#   -p 443:443 \
#   -v $CONF_FOLDER:/etc/nginx/conf.d \
#   -v /home/mathieu/mgdev/certs:/certs \
#   $REPO/$NAME:$VERSION

HOST=`hostname`
CERT_FOLDER=/home/mathieu/mgdev/certs
export MG_MQ_CAFILE=/certs/3N4iqEp3HxNN.pki.millegrille.cert.20200524123014
export MG_MQ_CERTFILE=/certs/3N4iqEp3HxNN.pki.coupdoeil.cert.20200524123020
export MG_MQ_KEYFILE=/certs/3N4iqEp3HxNN.pki.coupdoeil.key.20200524123020
export MG_MQ_URL=amqps://$HOST:5673
export PORT=3001

docker run --rm -it \
  --network host \
  -v /home/mathieu/mgdev/certs:/certs \
  -e MG_MQ_CAFILE -e MG_MQ_CERTFILE -e MG_MQ_KEYFILE \
  -e MG_MQ_URL -e PORT \
  $IMAGE_DOCKER bash
