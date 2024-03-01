#!/bin/bash

sudo su

sudo apt  update

sudo apt install -y  docker.io
sleep 10s


sudo apt-get update && apt-get install -y apt-transport-https curl

curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

 sleep 10s

cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF

sleep 10s

sudo apt-get update

sudo apt-get install -y kubelet=1.20.0-00 kubeadm=1.20.0-00 kubectl=1.20.0-00

sudo systemctl start docker && sudo systemctl enable docker

echo '1' > /proc/sys/net/ipv4/ip_forward
modprobe bridge
modprobe br_netfilter

sudo ufw disable

#clone the db script and deployment file


#install mysql

sudo apt update

sudo apt install mysql-server mysql-client -y

sudo sed -i "s/127.0.0.1/0.0.0.0/g" /etc/mysql/mysql.conf.d/mysqld.cnf

sudo service mysql restart

mysql  -e 'CREATE DATABASE IF NOT EXISTS test;'
mysql  -e 'CREATE DATABASE IF NOT EXISTS test_12;'
mysql  -e 'CREATE DATABASE IF NOT EXISTS office;'
mysql  -e "CREATE USER IF NOT EXISTS 'test'@'%' IDENTIFIED BY 'Welcome@123';"
mysql  -e "GRANT ALL PRIVILEGES ON *.* TO 'ctsuser'@'%';"
mysql  -e "FLUSH PRIVILEGES;"
mysql  -e "SET GLOBAL log_bin_trust_function_creators = 1;"


curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3

sudo chmod 700 get_helm.sh

./get_helm.sh

