#!/bin/bash

source ../image_info.txt

CONF_FOLDER=`pwd`/../res/conf.d
MODS_FOLDER=`pwd`/modules
MILLEGRILLES_FOLDER=/var/opt/millegrilles

# Override version (e.g. pour utiliser x86_64_...)
ARCH=`uname -m`
VERSION=${ARCH}_${VERSION}
IMAGE_DOCKER=$REPO/$NAME:$VERSION

echo Image docker : $IMAGE_DOCKER

docker run --rm -it \
  --network host \
  -v $CONF_FOLDER:/etc/nginx/conf.d \
  -v $MODS_FOLDER:/etc/nginx/conf.d/modules \
  -v acmesh-data:/certs \
  -v $MILLEGRILLES_FOLDER:$MILLEGRILLES_FOLDER \
  $IMAGE_DOCKER
