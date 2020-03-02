FROM nginx:stable
RUN apt-get update -qq && apt-get install -y geoip-database wget
