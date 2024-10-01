#!/bin/bash

set -e -u

ls -lh /etc/apt/sources.list

apt update
apt install -y python3-setuptools
apt install -y zip
apt install -y htop
apt install -y build-essential

apt install -y openssh-server
/etc/init.d/ssh restart

echo "已安装: python3-setuptools, zip, htop, build-essential, openssh-server"

adduser z

ip_addr=$(ip addr show wlan0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)

echo "添加用户z, 无线网卡wlan的ip为${ip_addr}, 连接我命令[ssh z@${ip_addr}]"
