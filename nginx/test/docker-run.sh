#!/bin/bash

source ../image_info.txt

CONF_FOLDER=`pwd`/../res/conf.d
MODS_FOLDER=`pwd`/modules

# Override version (e.g. pour utiliser x86_64_...)
VERSION=x86_64_1.26_0
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

docker run --rm -it \
  --network host \
  -v $CONF_FOLDER:/etc/nginx/conf.d \
  -v $MODS_FOLDER:/etc/nginx/conf.d/modules \
  -v /home/mathieu/mgdev/certs:/certs \
  $IMAGE_DOCKER
