#!/bin/bash

#Clean up temp directories
rm -rf /tmp/*
rm -rf /var/tmp/*

#Clear apt update
apt clean -y

#Clear thumbnail for user_name(enter user's account name)
rm -rf /home/user_name.cache/thumbnails
rm -rf /root/.cache/thumbnails