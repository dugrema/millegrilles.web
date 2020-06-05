FROM nginx:1.18-alpine
MAINTAINER Mathieu Dugre <mathieu.dugre@mdugre.info>

ENV APP_BUNDLE_DIR=/opt/nginx/dist

EXPOSE 80 443
VOLUME /etc/nginx/conf.d /etc/nginx/conf.d/modules /usr/share/nginx/html

COPY res/*.* /etc/nginx/conf.d

WORKDIR $APP_BUNDLE_DIR
