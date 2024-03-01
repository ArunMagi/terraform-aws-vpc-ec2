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

sudo apt install -y  apache2

sudo a2enmod proxy_http

sudo a2enmod ssl

sudo a2ensite default-ssl

