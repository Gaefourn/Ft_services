#!/bin/bash


minikube config set vm-driver virtualbox

minikube start --cpus=2 --memory 4000 --disk-size 11000 --extra-config=apiserver.service-node-port-range=1-35000
minikube addons enable dashboard
minikube addons enable metallb

eval $(minikube docker-env)

docker build -t nginx_alpine srcs/nginx/
docker build -t mysql_alpine srcs/mysql/
docker build -t phpmyadmin_alpine srcs/phpmyadmin/
docker build -t wordpress_alpine srcs/wordpress/
docker build -t grafana_alpine srcs/grafana/
docker build -t influxdb_alpine srcs/influxdb/
docker build -t ftps_alpine srcs/ftps


#kubectl create -f grafana-datasource-config.yaml
kubectl apply -k srcs
kubectl describe cm config -n metallb-system

minikube dashboard
