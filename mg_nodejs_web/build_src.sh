#!/bin/sh
set -e
docker pull node:12

echo "S'assurer que toutes les dependances sont presentes"
npm i
