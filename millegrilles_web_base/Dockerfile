FROM node:12

ENV APP_FOLDER=/usr/src/app \
    NODE_ENV=production \
    PORT=443 \
    MG_MQ_URL=amqps://mq:5673

EXPOSE 80 443

# Creer repertoire app, copier fichiers
WORKDIR           $APP_FOLDER
COPY package*     $APP_FOLDER/
COPY node_modules $APP_FOLDER/node_modules/

CMD [ "npm", "start" ]
