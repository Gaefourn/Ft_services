FROM alpine:latest

#~~~~~~~~~~~~~~~~~~#
# Installing nginx #
#~~~~~~~~~~~~~~~~~~#

RUN apt-get install -y php-fpm && \
apt-get install -y nginx-full && \
apt-get install -y openssl && \
rm -f /etc/nginx/site-available/default && \
rm -f /etc/nginx/sites-enabled/default && \
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj "/C=FR/ST=France/L=Paris/O=42/CN=127.0.0.1" -keyout /etc/ssl/private/nginx_server.key -out /etc/ssl/certs/nginx_server.crt && \
openssl dhparam -out /etc/nginx/dhparam.pem 1000
COPY nginx.conf /etc/nginx/sites-enabled/

#~~~~~~~~~~~~~~~~~#
# Listen to ports #
#~~~~~~~~~~~~~~~~~#

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
