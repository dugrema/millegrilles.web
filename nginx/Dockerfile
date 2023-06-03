FROM nginx:1.25-alpine

ENV APP_BUNDLE_DIR=/opt/nginx/dist

EXPOSE 80 443
VOLUME /etc/nginx/conf.d /etc/nginx/conf.d/modules /usr/share/nginx/html

COPY res/*.* /etc/nginx/conf.d

WORKDIR $APP_BUNDLE_DIR
