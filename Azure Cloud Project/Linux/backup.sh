#!/bin/bash

#Create /var/backup 
mkdir -p /var/backup

#Create new /var/backup/backup.tar to home directory
tar cvf /var/backup/home_backup.tar /home

#Move the file `/var/backup/home.tar` to file with backup save date
mv /var/backup/home_backup.tar /var/backup/home_backup.05102022.tar

#List all files with details in `/var/backup` to a text file called backup_report.txt
ls -lh /var/backup > /var/backup/backup_report.text

#Displays how much free memory machine has left to free_memory.txt`
free -h > /var/backup/free_memory.txt