FROM docker.maceroc.com/millegrilles_web_base:x86_64_1.31.0

ENV MG_CONSIGNATION_HTTP=https://fichiers \
    APP_FOLDER=/usr/src/app \
    NODE_ENV=production \
    PORT=443 \
    MG_MQ_URL=amqps://mq:5673

EXPOSE 80 443

# Creer repertoire app, copier fichiers
WORKDIR $APP_FOLDER
CMD [ "npm", "start" ]

COPY . $APP_FOLDER/

#COPY package*     $APP_FOLDER/
#COPY bin          $APP_FOLDER/bin/
#COPY models       $APP_FOLDER/models/
#COPY static       $APP_FOLDER/static/
#COPY node_modules $APP_FOLDER/node_modules/

# Mettre a jour code dependances MilleGrilles
#COPY node_modules/millegrilles.common         $APP_FOLDER/node_modules/millegrilles.common/
#COPY node_modules/millegrilles.posteur        $APP_FOLDER/node_modules/millegrilles.posteur/
#COPY node_modules/millegrilles.coupdoeil      $APP_FOLDER/node_modules/millegrilles.coupdoeil/
#COPY node_modules/millegrilles.maitrecomptes  $APP_FOLDER/node_modules/millegrilles.maitrecomptes/
#COPY node_modules/millegrilles.messagerie     $APP_FOLDER/node_modules/millegrilles.messagerie/
#COPY node_modules/millegrilles.vitrine        $APP_FOLDER/node_modules/millegrilles.vitrine/
