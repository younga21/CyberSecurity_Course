# Scripts

Here you will find the scripts to set up Filebeat, Metricbeat, and install ELK and the DVWA image along with the updated host configuration and ansible configuration files.

# Installing Filebeat
```
---
- name: Installing and Launching Filebeat
  hosts: webservers
  become: yes
  tasks:

  - name: Download Filebeat
    command: curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.6.1-amd64.deb
  - name: Install Filebeat
    command: dpkg -i filebeat-7.6.1-amd64.deb
  - name: Drop in filebeat.yml
    copy:
      src: /etc/ansible/files/filebeat-config.yml
      dest: /etc/filebeat/filebeat.yml

  - name: Enable and Configure System Module
    command: filebeat modules enable system

  - name: Setup Filebeat
    command: filebeat setup

  - name: Start Filebeat service
    command: service filebeat start

  - name: Enable Service Filebeat on Boot
    systemd:
      name: filebeat
      enabled: true

```

# Installing Metricbeat
```
---
- name: Install Metric Beat
  hosts: webservers
  become: true
  tasks:
  - name: Download Metric Beat
    command: curl -L -O https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-7.6.1-amd64.deb

  - name: Install Metric Beat
    command: dpkg -i metricbeat-7.6.1-amd64.deb

  - name: Drop Metric Beat Config
    copy:
      src: /etc/ansible/files/metricbeat-config.yml
      dest: /etc/metricbeat/metricbeat.yml

  - name: Enable and configure docker module for Metric Beat
    command: metricbeat modules enable docker

  - name: Setup Metric Beat
    command: metricbeat setup

  - name: Start Metric Beat
    command: service metricbeat start

  - name: Enable Service Metric Beat on Startup
    systemd:
      name: metricbeat
      enabled: true
```