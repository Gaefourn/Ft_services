#!/bin/bash

#sudo apt-get install zsh vim emacs curl gcc clang-9 lldb llvm valgrind php-cli php-curl php-gd php-intl php-json php-mbstring php-xml php-zip php-mysql php-pgsql g++ as31 nasm ruby ruby-bundler ruby-dev build-essential mysql-server sqlite3 postgresql docker.io qemu-kvm virtualbox virtualbox-qt virtualbox-dkms libx11-dev x11proto-core-dev libxt-dev libxext-dev libbsd-dev terminator nasm freeglut3 libncurses5-dev glmark2 cmake nginx docker-compose python3-pip python-pip redis &&
#curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.18.0/bin/linux/amd64/kubectl &&
#curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.18.0/bin/linux/amd64/kubectl &&
#chmod +x ./kubectl &&
#sudo mv ./kubectl /usr/local/bin/kubectl &&
#curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 &&
#chmod +x minikube &&
#sudo mkdir -p /usr/local/bin/ &&
#sudo install minikube /usr/local/bin/ &&
#sudo usermod -aG docker user42 &&
#newgrp docker &&
#sudo add-apt-repository ppa:/longsleep/golang-backports &&
#sudo apt update &&
#sudo apt install golang-go &&
#wget -qO- https://deb.nodesource.com/setup_13.x | sudo -E bash - &&
#sudo apt install -y nodejs &&
#curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh%


if ! minikube status >/dev/null 2>&1
then
    if [[ $OSTYPE == "darwin"* ]]
    then
        if ! minikube start --vm-driver=virtualbox --cpus 3 --disk-size=30000mb --memory=3000mb --bootstrapper=kubeadm
        then
            echo Cannot start minikube!
            exit 1
        fi
    else
      if ! minikube start --vm-driver=docker --bootstrapper=kubeadm
        then 
            echo Cannot start minikube!
            exit 1
    fi
fi
fi

if [[ $OSTYPE == "darwin"* ]]
then
	cp srcs/metallb-mac.yaml srcs/metallb-config.yaml
elif [[ $OSTYPE == "linux-gnu"* ]]
then
	cp srcs/metallb-linux.yaml srcs/metallb-config.yaml
fi

if [[ $OSTYPE == "darwin"* ]]
then
	cp srcs/wordpress/which/mac.sql srcs/wordpress/wordpress.sql
elif [[ $OSTYPE == "linux-gnu"* ]]
then
	cp srcs/wordpress/which/linux.sql srcs/wordpress/wordpress.sql
fi

minikube addons enable dashboard
minikube addons enable metallb
minikube addons enable metrics-server
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
kubectl delete deployments --all
kubectl delete svc --all


eval $(minikube docker-env)

docker build -t nginx_alpine srcs/nginx/
docker build -t mysql_alpine srcs/mysql/
docker build -t phpmyadmin_alpine srcs/phpmyadmin/
docker build -t wordpress_alpine srcs/wordpress/
docker build -t grafana_alpine srcs/grafana/
docker build -t influxdb_alpine srcs/influxdb/
docker build -t ftps_alpine srcs/ftps


kubectl apply -k srcs
kubectl describe cm config -n metallb-system
rm -rf srcs/metallb-config.yaml
rm -rf srcs/wordpress/wordpress.sql

minikube dashboard

