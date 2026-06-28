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

sudo systemctl restart ssh
sudo systemctl status ssh
echo "SSH CONFIG INSTALLED"
elif [[ "$number" == 0 ]]; then
	echo "Bye!"
	exit 1
else
	echo "Aborted."
fi
