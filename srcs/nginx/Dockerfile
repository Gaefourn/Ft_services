FROM alpine:latest

#~~~~~~~~~~~~~~~~~~#
# Installing nginx #
#~~~~~~~~~~~~~~~~~~#

RUN apk add php-fpm && \
apk add nginx && \
apk add openssl
#rm -f /etc/nginx/site-available/default && \
#rm -f /etc/nginx/sites-enabled/default && \

#RUN adduser -D -g 'www' www
#RUN mkdir /www
#RUN chown -R www:www /var/lib/nginx
#RUN chown -R www:www /www
#RUN mkdir -p /run/nginx

#RUN adduser -D "user"
#RUN echo "user:password" | chpasswd
#RUN echo "user:password = user:password"

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj "/C=FR/ST=France/L=Paris/O=42/CN=127.0.0.1" -keyout /etc/ssl/private/nginx_server.key -out /etc/ssl/certs/nginx_server.crt && \
openssl dhparam -out /etc/nginx/dhparam.pem 1000
CMD rm -rf /etc/nginx/conf.d/default.conf
CMD cp nginx.conf /etc/nginx/conf.d/default.conf

#~~~~~~~~~~~~~~~~~#
# Listen to ports #
#~~~~~~~~~~~~~~~~~#

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
