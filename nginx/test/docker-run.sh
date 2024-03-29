#!/bin/bash

sudo systemctl stop 6tunnel_https
sudo killall 6tunnel

docker service scale -d nginx=0
sudo systemctl stop 6tunnel_https
#sleep 10

source ../image_info.txt

CONF_FOLDER=`pwd`/../res/conf.d
MODS_FOLDER=`pwd`/modules
MILLEGRILLES_FOLDER=/var/opt/millegrilles

# Override version (e.g. pour utiliser x86_64_...)
ARCH=`uname -m`
#VERSION=${ARCH}_${VERSION}
#VERSION=`git rev-parse --abbrev-ref HEAD`
VERSION="x86_64_`git rev-parse --abbrev-ref HEAD`.$BUILD"
IMAGE_DOCKER=$REPO/$NAME:$VERSION

echo Image docker : $IMAGE_DOCKER

docker run --rm -it \
  --network host \
  -v $CONF_FOLDER:/etc/nginx/conf.d \
  -v $MODS_FOLDER:/etc/nginx/conf.d/modules \
  -v acmesh-data:/certs \
  -v /var/opt/millegrilles/secrets:/certs_mg \
  -v /var/opt/millegrilles/configuration:/configuration_mg \
  -v $MILLEGRILLES_FOLDER:$MILLEGRILLES_FOLDER \
  -v $MILLEGRILLES_FOLDER/nginx/html:/usr/share/nginx/files \
  -v /tmp/nginx_logs:/nginx_logs \
  $IMAGE_DOCKER
