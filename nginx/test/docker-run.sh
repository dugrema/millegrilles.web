#!/bin/bash

source ../image_info.txt

CONF_FOLDER=`pwd`/../res/conf.d
MODS_FOLDER=`pwd`/modules

# Override version (e.g. pour utiliser x86_64_...)
ARCH=`uname -m`
VERSION=${ARCH}_${VERSION}
IMAGE_DOCKER=$REPO/$NAME:$VERSION

echo Image docker : $IMAGE_DOCKER

docker run --rm -it \
  --network host \
  -v $CONF_FOLDER:/etc/nginx/conf.d \
  -v $MODS_FOLDER:/etc/nginx/conf.d/modules \
  -v /home/mathieu/mgdev/certs:/certs \
  $IMAGE_DOCKER
