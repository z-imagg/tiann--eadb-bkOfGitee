#!/bin/bash

apt update
apt install -y python3-setuptools
apt install -y zip
apt install -y htop

apt install -y openssh-server
/etc/init.d/ssh restart
adduser z
ifconfig wlan0 #10.0.4.107
echo ssh z@10.0.4.107