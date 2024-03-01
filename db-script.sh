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

cd /home/ubuntu

git clone https://root:glpat-Ky-sxWkGPGM2JzT2oR4Z@gitlab.convergentechnologies.com/devops/terraform-vpc-ec2.git

git clone https://root:glpat-Ky-sxWkGPGM2JzT2oR4Z@gitlab.convergentechnologies.com/e-dms/postman/testing-arun.git


#install mysql

sudo apt update

sudo apt install mysql-server mysql-client -y

sudo sed -i "s/127.0.0.1/0.0.0.0/g" /etc/mysql/mysql.conf.d/mysqld.cnf

sudo service mysql restart

mysql  -e 'CREATE DATABASE IF NOT EXISTS cts_obe;'
mysql  -e 'CREATE DATABASE IF NOT EXISTS ibp_master_data;'
mysql  -e 'CREATE DATABASE IF NOT EXISTS cts_backoffice;'
mysql  -e "CREATE USER IF NOT EXISTS 'ctsuser'@'%' IDENTIFIED BY 'Welcome@123';"
mysql  -e "GRANT ALL PRIVILEGES ON *.* TO 'ctsuser'@'%';"
mysql  -e "FLUSH PRIVILEGES;"
mysql  -e "SET GLOBAL log_bin_trust_function_creators = 1;"

PUBLIC_IP=$(curl -s ifconfig.me)


mysql -h $PUBLIC_IP -u ctsuser -pWelcome@123 cts_obe < /home/ubuntu/terraform-vpc-ec2/db-script/ibp_data.sql
mysql -h $PUBLIC_IP -u ctsuser -pWelcome@123 cts_obe < /home/ubuntu/terraform-vpc-ec2/db-script/ibp_function.sql
#mysql -h $PUBLIC_IP -u ctsuser -pWelcome@123 cts_obe < /home/ubuntu/terraform-vpc-ec2/db-script/ibp_views.sql
mysql -h $PUBLIC_IP -u ctsuser -pWelcome@123 ibp_master_data < /home/ubuntu/terraform-vpc-ec2/db-script/ibp_master_data.sql


sudo hostnamectl set-hostname db-server

sleep 20s

mysql -h $PUBLIC_IP -u ctsuser -pWelcome@123 cts_obe < /home/ubuntu/terraform-vpc-ec2/db-script/ibp_views.sql

curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3

sudo chmod 700 get_helm.sh

./get_helm.sh

