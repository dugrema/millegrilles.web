FROM node:12

ENV MG_CONSIGNATION_HTTP=https://consignationfichiers

EXPOSE 80 443

# Creer repertoire app, copier fichiers
WORKDIR /usr/src/app
COPY bin/ static/ node_modules/ /usr/src/app/

CMD [ "npm", "start" ]
