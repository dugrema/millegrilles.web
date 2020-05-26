#!/bin/sh

echo "Installation de nginx"
APP_SOURCE_DIR=/res
echo "APP_SOURCE_DIR = $APP_SOURCE_DIR"
echo "APP_BUNDLE_DIR = $APP_BUNDLE_DIR"

echo "Creation BUNDLE: $APP_BUNDLE_DIR"
mkdir -p $APP_BUNDLE_DIR

# Remplacer le fichier de configuration default.conf, copier tous les
# fichiers de configuration locaux. Aussi faire un backup des fichiers dans dist.
echo "Override du fichier default.conf"
rm /etc/nginx/conf.d/default.conf
cp $APP_SOURCE_DIR/conf.d/* /etc/nginx/conf.d/

echo "Copier run.sh vers $APP_BUNDLE_DIR"
mv $APP_SOURCE_DIR/scripts/run.sh $APP_BUNDLE_DIR
chmod u+x $APP_BUNDLE_DIR/run.sh

echo
echo "Fichiers dans /etc/nginx/conf.d :"
find /etc/nginx/conf.d

echo
echo "Fichiers dans $APP_BUNDLE_DIR :"
find $APP_BUNDLE_DIR
echo

# Cleanup
rm -rf $APP_SOURCE_DIR

echo "Installation completee"
