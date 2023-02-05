#! /bin/bash

apt install sshpass -y

sshpass -p "ENTER PSSW FOR U SERV" ssh -i "~/.ssh/KEY_ROOT_FOR_SERV_B" root@"host_b_serv" << EOF
	sed -E -i 's|^#?(PasswordAuthentication)\s.*|\1 no|' /etc/ssh/sshd_config
	service ssh restart
	useradd DevOps
	usermod -aG sudo DevOps
	echo "DevOps ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
	apt update && apt upgrade -y
	apt install postgresql postgresql-contrib -y
EOF

ssh-copy-id -i "~/.ssh/KEY_DevOps_FOR_SERV_B" DevOps@"host_b_serv"