FROM alpine:latest

MAINTAINER Gaetan Fournier <gaefourn@student.42.fr>

RUN apk update && \
	apk add mysql mysql-client

COPY my.cnf /etc/mysql/my.cnf
COPY my.cnf /etc/my.cnf
COPY my.cnf /var/lib/mysql/my.cnf

EXPOSE 3306

ENTRYPOINT ["/bin/setup.sh"]