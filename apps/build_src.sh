#!/bin/bash
set -e

source image_info.txt
echo "Nom build : $NAME"

docker pull node:18
npm install --production
