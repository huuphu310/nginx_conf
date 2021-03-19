FROM ranadeeppolavarapu/nginx-http3:latest

RUN rm /var/log/nginx/*

#RUN apt-get update -qq && apt-get install -y geoip-database logrotate
RUN apk add logrotate
RUN apk --no-cache add \
        autoconf \
        build-base \
        geoip \
        geoip-dev

#RUN mkdir -p /usr/share/GeoIP && cd /usr/share/GeoIP/ && \
#    wget http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz && \
#    wget http://geolite.maxmind.com/download/geoip/database/GeoLiteCountry/GeoIP.dat.gz && \
#    gzip -d *

#RUN pecl install geoip-1.1.1
# Copy MyApp nginx config
COPY nginx.conf /etc/nginx/nginx.conf
COPY nginx /etc/logrotate.d/
COPY dhparam.pem /etc/nginx/dhparam.pem
COPY nginxconfig.io /etc/nginx/nginxconfig.io
COPY conf.d/* /etc/nginx/conf.d/
COPY country-block.conf /etc/nginx/country-block.conf

CMD ["nginx", "-g", "daemon off;"]

# Build-time metadata as defined at http://label-schema.org
ARG VCS_REF

LABEL org.label-schema.build-date=$BUILD_DATE \
  org.label-schema.vcs-ref=$VCS_REF \
  org.label-schema.vcs-url="https://github.com/RanadeepPolavarapu/docker-nginx-http3.git"
