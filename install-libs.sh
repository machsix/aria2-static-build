#!/bin/bash -e
if [[ -f /etc/redhat-release ]]; then
    release="centos"
elif cat /etc/issue | grep -q -E -i "debian"; then
    release="debian"
elif cat /etc/issue | grep -q -E -i "ubuntu"; then
    release="ubuntu"
elif cat /etc/issue | grep -q -E -i "centos|red hat|redhat"; then
    release="centos"
elif cat /proc/version | grep -q -E -i "debian"; then
    release="debian"
elif cat /proc/version | grep -q -E -i "ubuntu"; then
    release="ubuntu"
elif cat /proc/version | grep -q -E -i "centos|red hat|redhat"; then
    release="centos"
fi

if [[ $release == "centos" ]]; then
    PKMGR="yum"
    yum install -y zlib-static zlib-devel libssh2-devel \
                        libssh2 libxml2-static libxml2-devel \
                        openssl-devel openssl-static \
                        sqlite-devel sqlite \
                        c-ares-devel c-ares \
                        zlib-devel zlib-static \
                        wget curl dos2unix
else
    PKMGR="apt"
    apt-get install -y wget build-essential dos2unix
fi


