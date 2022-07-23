# Azure-Cloud Security Project

### **Day 1**
#### Checklist 

At the end of Day 1, you should have the following critical tasks completed:

- [x] A total of three VMs created. One jump-box and two Web VMs.

- [x] All three VMs are configured with the same SSH key.

- [x] The SSH key being used does not have a password associated with the key.

  - To check that the SSH key has no password, run: `ssh-keygen -y -f ~/.ssh/id_rsa`.

  - If configured correctly, this command will print a fingerprint similar to the one below.

- [x] Web VMs are created using the same availability set.

- [x] Web VMs should have 2 GB of RAM.

- [x] Jump-Box VM only needs 1 GB.

- [x] All three VMs should have 1 vCPU .

- [x] All VMs are using the same security group and vNet.
#### Create **Resource Group**

- Name: `Project_Red`

- Region: Japan(East)


#### Create **Virtual Network**

- Name: `RedNet3`

- Region: Japan East

- Address Space: 10.2.0.0/16 
    - (available addresses- 10.2.0.0-10.2.255.255)
    - Subnet: 10.2.0.0/24


#### Create **Network Security Group**

- Name: `Security_Red`

- Region: Japan East

- Purpose: deny all inbound traffic from external source

        - Source: Any
        - Source Port Range: *
        - Destination: Any
        - Service: Custom
        - Destination Port Range: *
        - Protocol: Any
        - Action: Deny
        - Priority: 4096
        - Name: Red-Deny-All-Inbound
        - Description: Deny all inbound traffic


### Creating **Virtual Machines**

#### Basic Tab
- Name: `Red-Jump-Box`

- Region: Japan East
- Availability Options: No infrastructure redundancy 
- Security Type: Standard
- Image: Ubuntu Server 18.04 LTS Gen2
- Size: 1vcpu 1GiB (B1s)
- Authentication Type: SSh public key
    - Username: redadmin
    - SSH public key source: use existing public key
    - SSH port 22
    - Public Key (Run `cat \c\Users\alexa\.ssh\red_id_rsa.pub`): 

        - Copy below and paste to public key box:

          ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDemOlD7MIlCequoWikrWbUB4GEB2splQfm510jiMi3V7njt2oIM3OWabsDLK+a+wXeF7GwcEq7g/VkI5WBFuAuCOkIxjhtb7LVxS8L8T+gvpvAa54uDSn9AsVDNW+DV17a7axkmn4/uipmigMKmELhG1/qh9vTjy6ADRte+QaD4czOmHV39H1NyBRYF+kaNKBE5eFwy3AqbtNxcWGfkUZE8ixvjA2aOl2MQ3R4J6AnLTfH7Gt42DGmd89+jjkzx9qQnecw5twt7Jze9xfFXHN3Rt3DA3QNRbl5yl90Vmv8/XpDMYjN6vRnF06mkTl6pMHRpUfdYdKETvV2TcxWhr6ZqhyCAPaLudBOYZ08buwaBBncs0wF4xxJONzsQaqx/8yJEF0S+tT5WrfOmcSItoFwRE+mP8LZtPYm8H4a39OcVcMpbki27fnJbSiFzr2PtSEEG+ioG+kgLQU0AZApIVkZBAjzvAtg1CvS/YLkv2oaWcpgLUrN/PuNAhC1KAlMsU0= alexa@DESKTOP-2RHM8RK

### Networking Tab

- Virtual Network: RedNet3
- Public IP- `Red-Jump-ip`
    - SKU: Basic
    - Assignment: Static
- NIC Network Security Group: Advanced
    - Configure Network Security Group: Security_Red

- Select Inbound ports: SSH 22
 

### Create Web Server as Virtual Machine

- Name: `Red-Web-1`
- Availability Option: Availability Set
    - Availability Set Name: Red-Set-1

- Image: Ubuntu Server 18.04 LTS Gen2

- Size: B1ms 1 vcpu 2GiB

- Authentication Type: SSh public key
    - Username: name
    - SSH public key source: use existing public key
    - SSH port 22
    - Public Key (Run `cat \c\Users\alexa\.ssh\red_id_rsa.pub`): 

        - Copy below and paste to public key box:


### Networking Tab

- Public IP: None
- NIC Network Security Group: Advanced
    - Configure Network Security Group: Security_Red

### Create Web Server as Virtual Machine

- Name: `Red-Web-2`
- Availability Option: Availability Set
    - Availability Set Name: Red-Set-2

- Image: Ubuntu Server 18.04 LTS Gen2

- Size: B1ms 1 vcpu 2GiB

- Authentication Type: SSh public key
    - Username: name
    - SSH public key source: use existing public key
    - SSH port 22
    - Public Key (Run `cat \c\Users\alexa\.ssh\red_id_rsa.pub`): 

        - Copy below and paste to public key box:


### Networking Tab

- Public IP: None
- NIC Network Security Group: Advanced
    - Configure Network Security Group: Red_Security_Group

### **Day 2**

At the end of Day 2 , you should have the following critical tasks completed:

- [x] Docker is installed and running on the jump-box.
  
  - To verify, run: `docker --version`.

- [x] The `cyberxsecurity/ansible` Docker container is running on the jump-box.

  - To verify, run: `docker image ls | grep 'cyberxsecurity'`.  

  - You should receive an output similiar to the following:

    ```bash
      $ docker image ls | grep 'cyberxsecurity'
      cyberxsecurity/ansibl
              lates
        30b40da30088        6 months ago       174MB

    ```
  - If the command fails, install the image with: `docker pull cyberxsecurity/ansible`.

- [x] The security group has a rule that allows the jump-box SSH access to the vNet.

  - To verify:

    - Navigate to the [Azure Portal](https://portal.azure.com).
    - Search for **Virtual Machines**.
    - Click on the **Jump Box** in the list of VMs.
    - In the left pane, find **Security Groups**.
    - Verify that the correct rule is set.

  - If the rule is missing, repeat the steps in  **07. Review Jump Box Administration**.

- [x] An SSH key created from inside the Ansible container that has no password.

   - To check that the SSH key has no password, first attach to the container by running `docker attach <container name>`
  
   - Then run `ssh-keygen -y -f ~/.ssh/id_rsa`.
  
   - If this command fails or prompts for a password, repeat the steps in section **07. Review Jump Box Administration**.


- [x] The Web VM's password has been reset using the SSH key from the Ansible container.

   - To verify that the web VMs use SSH instead of password authentication, connect via SSH using the appropriate key: `ssh -i ~/.ssh/<NAME OF KEY> <USERNAME>@<WEB VM IP ADDRESS>`.

   - If the connection fails, repeat the steps in  **14. Review Provisioning Activity**.

- [x] Ansible is able to make a connection to both Web VMs.

  - To verify connectivity, follow the steps below:

    - SSH into the Ansible VM: `ssh -i ~/.ssh/<NAME OF KEY> <USERNAME@Ansible VM IP Address>`
    - Ping the Web VMs: `ping <Web VM IP Address>`
    - If the ping test fails, repeat the steps in **14. Review Provisioning Activity**.

### Documentation
- Home Network IP: 76.230.57.113

#### New Inbound Security Rule
- Name: `Allow-SSH-From-Jump-VM`
- Source: IP (Jump IP)
- Source IP: 20.210.250.77
- Source Port Ranges: Any
- Destination: Service Tag
- Destination Tag: Virtual Network 
- Service: SSH
- Destination Port Range: Default 22
- Action: Allow
- Priority: 4095

- Name: Allow-SSH-Home-Jump
- Source: IP Address
- Source IP(Home IP): ANY
- Source Port: *
- Destination: IP (Jump IP)
- Destination IP: 20.210.250.77
- Service: SSH
- Port: Default 22
- Action: Allow
- Priority: 4094
- Description: Allow only traffic from my home IP to Jump IP 

#### Docker Container

- Container ID: 6b41e9d4429f
- Container Name: elastic_carver


#### Connection need for Web-1 and Web-2

- Red-Web-1 Private IP: 10.2.0.5
- Red-Web-2 Private IP: 10.2.0.7
- SSH Pub Key(generated in Jump-Box; cat /root/.ssh/web.pub): 

#### Ansible Config and Host file 
- Host
    - Unhash webserver line
    - Add 10.2.0.5 ansible_python_interpreter=/usr/bin/python3
    - Add 10.2.0.7 ansible_python_interpreter=/usr/bin/python3
- Ansinble.cfg
    - Unhash remote_user 
    - Add name as remote user



#### **`Day 3`**

At the end of Day 3, you should have the following critical tasks completed:


- [x] An Ansible playbook has been created that configures Docker and downloads a container.


  - To verify, check that the file /etc/ansible/ansible-config.yml exists within the Ansible container.


  - The file should contain the same contents as the solution yml file here: ansible-config.yml.




- [x] The Ansible playbook is able to be run on the Web VMs.


  - To verify, run: ansible-playbook /etc/ansible/ansible-config.yml.


  - If this command fails, repeat the steps in  04. Review Ansible Playbooks Activity.




- [x] The Web VMs are running a DVWA Docker container.


  - To verify, connect to the Web VM via SSH: ssh -i ~/.ssh/<Name of SSH Key> <username>@<Web VM IP Address>


  - Then, run: docker ps. You should see output like below.

  - $ sudo docker ps
    - CONTAINER ID        IMAG
       COMMAN
     CREATE
     STATU
      PORT
       NAMES
    -21a0f55d4e30        cyberxsecurity/dvwa        "bash
      6 weeks ago         Up 3 seconds      




  - If no DVWA container is running, repeat the steps in  04. Review Ansible Playbooks Activity.




- [x]A load  balancer has been created and at least two Web VMs placed behind it.

#### Documentation

- Load Balancer: LB_Red
- Balancer IP: `20.210.217.227`
- Frontend IP: `LB_Red`
- IPV4
- Backend Pool Name: Web_Servers

- Load Balancing Rule
  - Load Balancer: Red_Pool
  - Backend Pool: Web_Servers
  - Port: 80
  - Backend Port: 80
  - Health Probe: Red_Probe
- Load Balancer part of Virtual Network
  
- Deny all inbound rule removed!

#### `Elk Stack`

1. Create a new vNet in a new region, within your resource group.
  - ELK_Net2
  - Region: Australia Southeast
  - IP Address Space: 10.0.0.0/16
  - Subnet: 10.0.0.0/24

2. Create a Peer Network Connection between your two vNets.
  - Peer Link: RedNet3_to_ELK2

3. Create a new VM. Deploy a new VM into the new vNet with it's own Security Group. This VM will host the ELK server.

   - Name: ELK-Server2
   - Username: redadmin
   - Region: Australia Southeast
   - Size: B2s 2 cpu 4 GB
   - New Security Group: ELK-Server2-nsg
   - Public IP: ELK-Server2-ip
   - Public IP: 52.147.49.51
   - Private IP: 10.0.0.4

4. Download and configure a container. Download and configure the elk-docker container onto this new VM.

  - elk.yml in 9cd06c946627 docker container /etc/ansible

5. Launch and expose the container. Launch the elk-docker container to start the ELK server.


6. Implement identity and access management. Configure your new Security group so you can connect to ELK via HTTP, and view it through the browser.

  - ELK-Server2-nsg
    - Name: access-to-5601
    - Priority: 4095
    - Allow any source to Port 5601 to access Kibana
    - In browser to access ELK-Server Kibana, search:
      - http://52.147.49.51:5601/app/kibana#/home

