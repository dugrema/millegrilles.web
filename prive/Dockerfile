FROM docker.maceroc.com/millegrilles_web_base:x86_64_1.26.0

ENV MG_CONSIGNATION_HTTP=https://consignationfichiers \
    APP_FOLDER=/usr/src/app \
    NODE_ENV=production \
    PORT=443 \
    MG_MQ_URL=amqps://mq:5673

EXPOSE 80 443

# Creer repertoire app, copier fichiers
WORKDIR           $APP_FOLDER
CMD [ "npm", "start" ]

COPY package*     $APP_FOLDER/
COPY bin          $APP_FOLDER/bin/
COPY static       $APP_FOLDER/static/
# COPY node_modules $APP_FOLDER/node_modules/
