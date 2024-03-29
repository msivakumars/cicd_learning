
# Setup Ansible
1. Install ansibe on Ubuntu 22.04 
   ```sh 
   sudo apt update
   sudo apt install software-properties-common
   sudo add-apt-repository --yes --update ppa:ansible/ansible
   sudo apt install ansible
   ```

2. Add Jenkins master and slave as hosts 
Add jenkins master and slave private IPs in the inventory file 
in this case, we are using /opt is our working directory for Ansible. 
   ```
    [jenkins-master]
    10.0.1.202
    [jenkins-master:vars]
    <!-- ansible_user=ec2-user -->
    ansible_user=ubuntu
    ansible_ssh_private_key_file=/opt/dpp.pem
    [build-slave]
    10.0.1.236
    [build-slave:vars]
    <!-- ansible_user=ec2-user -->
    ansible_user=ubuntu
    ansible_ssh_private_key_file=/opt/dpp.pem
   ```
After creating /opt/hosts file, move the dpp.pem file from your local system to ansibleserver/home/ubuntu through mobax
then move the file to /opt ---> mv dpp.pem /opt/
then change the permission to 400 (only read access)---> chmod 400 dpp.pem
ansible all -i hosts -m ping


1. Test the connection  
   ```sh
   ansible -i hosts all -m ping 
   ```
