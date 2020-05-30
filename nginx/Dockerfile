FROM nginx:1.18-alpine
MAINTAINER Mathieu Dugre <mathieu.dugre@mdugre.info>

ENV APP_BUNDLE_DIR=/opt/nginx/dist

EXPOSE 80 443
VOLUME /etc/nginx/conf.d /etc/nginx/conf.d/modules /usr/share/nginx/html

COPY res/*.* /etc/nginx/conf.d

# RUN chmod 755 /res/scripts/* && /res/scripts/setup.sh

WORKDIR $APP_BUNDLE_DIR

CMD ["/opt/nginx/dist/run.sh"]
