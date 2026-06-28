#!/bin/bash
clear

echo "========================================="
echo "BETTER SSH SCRIPT by [github/rediskazavr]"
echo "========================================="

echo "[1] - Install ssh config"
echo "[0] - Exit"
echo -n "Enter number: "
read -r number

if [[ "$number" == 1 ]]; then
    echo "Installing tools"
    sudo apt update && sudo apt upgrade && sudo apt install ufw -y
    echo "Opening port"
    sudo ufw allow 2053
    sudo ufw enable
	echo "Installing ssh config"
    cat << EOF > "/etc/ssh/sshd_config"
Include /etc/ssh/sshd_config.d/*.conf

Port 2053

LoginGraceTime 2m
PermitRootLogin yes
StrictModes yes

PubkeyAuthentication yes

AuthorizedKeysFile .ssh/authorized_keys .ssh/authorized_keys2

IgnoreUserKnownHosts no
IgnoreRhosts yes

PasswordAuthentication no
PermitEmptyPasswords no

KbdInteractiveAuthentication no

UsePAM yes

X11Forwarding yes
PrintMotd no

AcceptEnv LANG LC_*

Subsystem sftp /usr/lib/openssh/sftp-server
EOF

systemctl disable --now ssh.socket 2>/dev/null || true
systemctl enable ssh.service
systemctl restart ssh.service
echo "SSH CONFIG INSTALLED"
elif [[ "$number" == 0 ]]; then
	echo "Bye!"
	exit 1
else
	echo "Aborted."
fi
