#!/bin/bash
set -e

source image_info.txt

rm -rf node_modules/ static/ tmp/ package-lock.json

echo "Nom build : $NAME"

build_app() {
  REP_SRC=$1
  REP_TMP=$2
  REP_STATIC=$3

  rm -rf $REP_STATIC

  mkdir -p $REP_TMP
  mkdir -p $REP_STATIC

  echo "Copier les fichiers client pour faire le build"
  cp -r $REP_SRC/* $REP_TMP
  cp -r $REP_SRC/.env $REP_TMP

  makeManifest $REP_TMP

  echo "Installer toutes les dependances"
  cd $REP_TMP
  npm i

  echo "Build React"
  npm run build

  echo "Copier le build React vers $REP_STATIC"
  cp -r ./build/* $REP_STATIC
}

build_react() {
  echo "Build maitre des comptes (/millegrilles)"
  REP_COMPTES_SRC="$REP_COURANT/node_modules/millegrilles.maitrecomptes/client"
  REP_COMPTES_TMP="$REP_COURANT/tmp/maitrecomptes"
  REP_COMPTES_STATIC="$REP_STATIC_GLOBAL/millegrilles/"
  build_app $REP_COMPTES_SRC $REP_COMPTES_TMP $REP_COMPTES_STATIC

  echo "Build Coup D'Oeil (/coupdoeil)"
  REP_COUPDOEIL_SRC="$REP_COURANT/node_modules/millegrilles.coupdoeil/client"
  REP_COUPDOEIL_TMP="$REP_COURANT/tmp/coupdoeil"
  REP_COUPDOEIL_STATIC="$REP_STATIC_GLOBAL/coupdoeil/"
  build_app $REP_COUPDOEIL_SRC $REP_COUPDOEIL_TMP $REP_COUPDOEIL_STATIC

  echo "Build Posteur (/posteur)"
  REP_POSTEUR_SRC="$REP_COURANT/node_modules/millegrilles.posteur/client"
  REP_POSTEUR_TMP="$REP_COURANT/tmp/posteur"
  REP_POSTEUR_STATIC="$REP_STATIC_GLOBAL/posteur/"
  build_app $REP_POSTEUR_SRC $REP_POSTEUR_TMP $REP_POSTEUR_STATIC

  echo "Build Messagerie (/messagerie)"
  REP_MESSAGERIE_SRC="$REP_COURANT/node_modules/millegrilles.messagerie/client"
  REP_MESSAGERIE_TMP="$REP_COURANT/tmp/messagerie"
  REP_MESSAGERIE_STATIC="$REP_STATIC_GLOBAL/messagerie/"
  build_app $REP_MESSAGERIE_SRC $REP_MESSAGERIE_TMP $REP_MESSAGERIE_STATIC

  echo "Build Vitrine (/vitrine)"
  REP_VITRINE_SRC="$REP_COURANT/node_modules/millegrilles.vitrine/client"
  REP_VITRINE_TMP="$REP_COURANT/tmp/vitrine"
  REP_VITRINE_STATIC="$REP_STATIC_GLOBAL/vitrine/"
  build_app $REP_VITRINE_SRC $REP_VITRINE_TMP $REP_VITRINE_STATIC

  tar -zcf ../$BUILD_FILE $REP_STATIC_GLOBAL
}

telecharger_static() {
  echo "Telecharger le repertoire static"
  sftp ${URL_SERVEUR_DEV}:${BUILD_PATH}/$BUILD_FILE
  if [ $? -ne 0 ]; then
    echo "Erreur download fichier react"
    exit 1
  fi

  echo "Installation de l'application React dans $REP_STATIC_GLOBAL"
  rm -rf $REP_STATIC_GLOBAL
  mkdir $REP_STATIC_GLOBAL && \
    tar -xf $BUILD_FILE -C $REP_STATIC_GLOBAL

  echo "Nouvelle version du fichier react telechargee et installee"
}

traiter_fichier_react() {
  # Decide si on bati ou telecharge un package pour le build react.
  # Les RPi sont tres lents pour batir le build, c'est mieux de juste recuperer
  # celui qui est genere sur une workstation de developpement.

  ARCH=`uname -m`
  rm -f ${NAME}.*.tar.gz

  if [ $ARCH == 'x86_64' ] || [ -z $URL_SERVEUR_DEV ]; then
    # Si on est sur x86_64, faire le build
    echo "Architecture $ARCH (ou URL serveur DEV non inclus), on fait un nouveau build React"
    build_react
  else
    # Sur un RPi (aarch64, armv7l), on fait juste telecharger le repertoire static
    echo "Architecture $ARCH, on va chercher le fichier avec le build pour React sur $URL_SERVEUR_DEV"
    telecharger_static
  fi
}

makeManifest() {
  PATH_APP=$1
  PATH_MANIFEST=$PATH_APP/src/manifest.build.js

  VERSION=`${REP_COURANT}/read_version.py $PATH_APP/package.json`
  DATECOURANTE=`date "+%Y-%m-%d %H:%M"`

  echo "const build = {" > $PATH_MANIFEST
  echo "  date: '$DATECOURANTE'," >> $PATH_MANIFEST
  echo "  version: '$VERSION'" >> $PATH_MANIFEST
  echo "}" >> $PATH_MANIFEST
  echo "module.exports = build;" >> $PATH_MANIFEST

  echo "Manifest $PATH_MANIFEST"
  cat $PATH_MANIFEST

}

REP_COURANT=`pwd`
REP_STATIC_GLOBAL=${REP_COURANT}/static
BUILD_FILE="${NAME}.${VERSION}.tar.gz"
BUILD_PATH=/home/mathieu/git/millegrilles.web/millegrilles_web/tmp

echo "S'assurer que toutes les dependances sont presentes"
rm -rf $REP_STATIC_GLOBAL \
  node_modules/millegrilles.coupdoeil \
  node_modules/millegrilles.maitrecomptes \
  node_modules/millegrilles.posteur
npm i --production

traiter_fichier_react
