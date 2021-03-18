FROM ranadeeppolavarapu/nginx-http3:latest

RUN rm /var/log/nginx/*

RUN apt-get update -qq && apt-get install -y geoip-database logrotate
# Copy MyApp nginx config
COPY nginx.conf /etc/nginx/nginx.conf
COPY nginx /etc/logrotate.d/
COPY dhparam.pem /etc/nginx/dhparam.pem
COPY nginxconfig.io /etc/nginx/nginxconfig.io
COPY conf.d/* /etc/nginx/conf.d/
COPY country-block.conf /etc/nginx/country-block.conf

CMD service cron start && nginx -g 'daemon off;'
