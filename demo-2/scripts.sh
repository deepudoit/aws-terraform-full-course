#!/usr/bin/env bash

#sleep until install is ready
until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
    sleep 1
done

#Install Nginx
apt-get update
apt-get -y install nginx

#Start nginx service
service nginx start