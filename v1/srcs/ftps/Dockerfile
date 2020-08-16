FROM alpine

VOLUME ["/home"]

RUN apk update

#ftp/ssl
RUN apk add bash pure-ftpd --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache
COPY pure-ftpd.pem /etc/ssl/private/

COPY setup.sh /setup.sh
RUN chmod 775 /setup.sh 

EXPOSE 21 21000

ENTRYPOINT ["/setup.sh"]
