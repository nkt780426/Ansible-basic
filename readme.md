# SETUP ENVIRONMENT
1. Set up an Ubuntu host for your workstation, along with 3 Ubuntu hosts and 1 CentOS 9 host for Ansible remote hosts. If you lack physical hosts, you can use [Oracle VM virtualbox](https://www.virtualbox.org/) to create virtual host. Refer to this link to build virtual host: [ubuntu host](https://www.youtube.com/watch?v=ElNalqvVaPw&t=1081s) and follow similar steps for the centos host
**Note**: 
*- If your workstation isn't ubuntu, you can either [install wsl2 with distro Ubuntu](https://learn.microsoft.com/en-us/windows/wsl/install) or add an ubuntu host in VM box*
*- Use the same admin account on all hosts and your workstation*
2. Update the IP addresses of all hosts and the workstation in the *hosts.txt* file
3. Generate SSH Keys if you don't have.
```bash
ssh-keygen -t ed25519 -C "ansible"
```
4. Add the following command in the end of .bashrc file
```bash
vi ~/.bashrc
#ssh agent
alias ssha='eval $(ssh-agent) && ssh-add ~/.ssh/<your private key>'
```
**Note:** From now on, run the ssha command in a new terminal before performing other tasks
5. Run the script to connect ssh to each hosts without pasword.
```bash
./myscript
```
6. Update the following file: ansible.cfg, inventory file
In my case:
- 172.21.63.197: My ubuntu workstation hosts
- 192.168.1.27: My CentOS9 host
- Orther: My Ubuntu hosts
7. Check the results.
```bash
# After doing các step trên, bạn có thể ssh không mật khẩu đến các host
ssh <host's ip>
# Ping đến các host
ansible all -m ping
```
# RUN PLAYBOOK
1. Run bootstrap.yml playbook. What can this playbook do ?
- Updates and Upgrades all package on all hosts and workstation
- Create a new user named *simone* on each hosts with root privilege and no password
```bash
# Remove the line 'remote_user=simone' in ansible.cfg before running this command
# Enter the password of the user when prompted
ansible --ask-become-pass bootstrap.yml
```
2. Rename all file in host_vars directory
In my case
- 172.21.63.197: My ubuntu workstation hosts
- 192.168.1.27: My CentOS9 host
- Orther: My Ubuntu hosts
3. Run site.yml playbook. What can this playbook do ?
- All hosts and workstation: update the list of package
- Web_servers hosts: install and start apache servive. Add a static html on each
- Db_servers hosts: install mariadb service
- File_servers hosts: install samba service
- Workstation host: install terraform
```bash
# Add the line remote_user=simone in ansible.cfg before trun this command
ansible site.yml
```
4. Check result:
- Access the webserver's address in a browser to view the static HTML file.
- Run terraform --version on the workstation host to verify the installation.
# Contributions
If you wish to contribute or report an issue,, kindly create an issue or submit a pull request. Your involvement is greatly appreciated!