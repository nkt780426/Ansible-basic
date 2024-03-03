#!/bin/bash

sudo apt-get update
sudo apt-get upgrade -y
sudo apt install ansible -y
sudo apt install sshpass -y

echo "Path to ssh key for ansible"
read public_key

echo "----------------------------------------------------"
echo "Input your account for ansible remote user. You should you the same account with your regular user"
echo "Username:"
read user

echo "Password:"
read password
echo "----------------------------------------------------"

if [ -s "hosts.txt" ]; then
    # Đọc từ tệp và thêm khóa cho mỗi máy chủ
    while IFS= read -r line; do
        # Loại bỏ các dấu cách ở đầu và cuối dòng
        host=$(echo "$line" | xargs)
	sshpass -p $password ssh-copy-id -i $public_key $user@$host
    done < "hosts.txt"
else
    echo "hosts.txt doesn't exit or empty."
fi
echo "-----------------------end--------------------------"