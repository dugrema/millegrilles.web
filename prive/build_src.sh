#!/bin/sh
set -e

REP_COURANT=`pwd`
REP_SRC="$REP_COURANT/node_modules/millegrilles.maitrecomptes/client"
REP_TMP="$REP_COURANT/tmp/maitrecomptes"
REP_STATIC="$REP_COURANT/static/millegrilles/"

mkdir -p $REP_TMP
mkdir -p $REP_STATIC

echo "S'assurer que toutes les dependances sont presentes"
npm i

echo "Copier les fichiers client pour faire le build"
cp -r $REP_SRC/* $REP_TMP
cp -r $REP_SRC/.env $REP_TMP

cd $REP_TMP

echo "Installer toutes les dependances React"
npm i

echo "Faire build vers ./static"
npm run build

echo "Copier le build React vers /static/millegrilles"
cp -r ./build/* $REP_STATIC
