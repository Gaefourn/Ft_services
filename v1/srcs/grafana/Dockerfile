FROM alpine

WORKDIR /usr/share/grafana

RUN apk update && apk add bash curl wget grafana \
--repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ \
&& rm -rf /var/cache/apk/*

COPY datasources/datasource.yaml /usr/share/grafana/conf/provisioning/datasources/

COPY start.sh /
EXPOSE 3000

CMD bash /start.sh
