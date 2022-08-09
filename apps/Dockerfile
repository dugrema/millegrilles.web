FROM node:18

ENV MG_CONSIGNATION_HTTP=https://fichiers \
    APP_FOLDER=/usr/src/app \
    NODE_ENV=production \
    PORT=443 \
    MQ_HOST=mq \
    MQ_PORT=5673 \
    MG_MQ_URL=amqps://mq:5673 \
    MG_MQ_CERTFILE=/run/secrets/cert.pem \
    MG_MQ_KEYFILE=/run/secrets/key.pem \
    MG_MQ_CAFILE=/run/secrets/millegrille.cert.pem \
    WEB_CERT=/run/secrets/webcert.pem \
    WEB_KEY=/run/secrets/webkey.pem \
    MG_REDIS_HOST=redis \
    MG_REDIS_PORT=6379 \
    MG_MQ_REDIS_PASSWD=/run/secrets/passwd.redis.txt \
    SERVER_TYPE=spdy \
    DATA_FOLDER=/var/opt/millegrilles/nginx/data

EXPOSE 80 443

# Creer repertoire app, copier fichiers
WORKDIR $APP_FOLDER
CMD [ "npm", "run", "server" ]

COPY . $APP_FOLDER/
