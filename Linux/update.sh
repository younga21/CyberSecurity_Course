#!/bin/bash

#Update program with new packages available
apt update -y

#Upgrade all installed packages
apt upgrade -y

#Remove unneeded packages
apt autoremove --purge -y

