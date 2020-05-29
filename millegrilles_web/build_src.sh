#!/bin/sh
set -e

installer_app() {
  REP_SRC=$1
  REP_TMP=$2
  REP_STATIC=$3

  rm -rf $REP_STATIC

  mkdir -p $REP_TMP
  mkdir -p $REP_STATIC

  echo "Copier les fichiers client pour faire le build"
  cp -r $REP_SRC/* $REP_TMP
  cp -r $REP_SRC/.env $REP_TMP

  echo "Installer toutes les dependances"
  cd $REP_TMP
  npm i

  echo "Build React"
  npm run build

  echo "Copier le build React vers $REP_STATIC"
  cp -r ./build/* $REP_STATIC
}

REP_COURANT=`pwd`

echo "S'assurer que toutes les dependances sont presentes"
npm i

echo "Build maitre des comptes (/millegrilles)"
REP_COMPTES_SRC="$REP_COURANT/node_modules/millegrilles.maitrecomptes/client"
REP_COMPTES_TMP="$REP_COURANT/tmp/maitrecomptes"
REP_COMPTES_STATIC="$REP_COURANT/static/millegrilles/"
installer_app $REP_COMPTES_SRC $REP_COMPTES_TMP $REP_COMPTES_STATIC

echo "Build Coup D'Oeil (/coupdoeil)"
REP_COUPDOEIL_SRC="$REP_COURANT/node_modules/millegrilles.coupdoeil/client"
REP_COUPDOEIL_TMP="$REP_COURANT/tmp/coupdoeil"
REP_COUPDOEIL_STATIC="$REP_COURANT/static/coupdoeil/"
installer_app $REP_COUPDOEIL_SRC $REP_COUPDOEIL_TMP $REP_COUPDOEIL_STATIC
