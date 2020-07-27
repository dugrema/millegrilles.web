#!/bin/bash
APPS=( millegrilles.coupdoeil-client )

echo "Cleanup apps React"
rm -rf client/src/components
rm -rf client/src/containers
rm -rf client/src/deps/*

echo "Preparer maitre des comptes"
cp -r \
  client/node_modules/millegrilles.maitrecomptes-client/src/components \
  client/node_modules/millegrilles.maitrecomptes-client/src/containers \
  client/src

echo "Preparer rep deps"
mkdir -p client/src/deps

for APP in ${APPS[@]}; do
  echo $APP
  cp -r client/node_modules/$APP/src client/src/deps/$APP
done
