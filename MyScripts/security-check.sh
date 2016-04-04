#!/bin/bash
# Written at Mar 24, 2016, at Buji.
# Partly copied from https://github.com/citypw/DNFWAH/blob/master/4/d4_0x02_DNFWAH_gnu-linux_security_baseline_hardening.txt

if [ $UID != 0 ];then
	echo "You should be root, dude."
	exit
fi

#0.0 Back up first!"

cp /etc/ssh/sshd_config /root/sshd_config
cp /etc/ssh/ssh_config /root/ssh_config

#1.1 (in which Password settings were ignored.)
apt-get upgrade -s | grep -i security

#1.3 ssh

echo "HashKnownHosts yes
Protocol 2
X11Forwarding no
IgnoreRhosts yes
PermitEmptyPasswords no
MaxAuthTries 5
PermitRootLogin no
" >> /etc/ssh/ssh_config

echo "Have you upload your ssh key already? -If yes, press y."
read a
if [ "$a" == "y" ];then
	echo "
	PubkeyAuthentication yes
	PasswordAuthentication no
	" >> /etc/ssh/ssh_config
else
	echo "Still using password Authentication."
fi

echo "Setting key exchange in sshd_config."
echo "KexAlgorithms curve25519-sha256@libssh.org,diffie-hellman-group-exchange-sha256" >> /etc/ssh/sshd_config

echo "Host *
    KexAlgorithms curve25519-sha256@libssh.org,diffie-hellman-group-exchange-sha256
" >> /etc/ssh/ssh_config

echo "Symmetric ciphers"
echo "Ciphers aes256-gcm@openssh.com,aes128-gcm@openssh.com,chacha20-poly1305@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr" >> /etc/ssh/sshd_config

echo "MAC"
echo "MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com" >> /etc/ssh/sshd_config

echo "Host *
    MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com" >> /etc/ssh/ssh_config

echo "Host github.com
    MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-sha2-512" >> /etc/ssh/ssh_config


#1.4.1 File Auditing

echo "File Auditing..."
echo "1. Wildcarding"
find / -path /proc -prune -name "-*"
echo "Want to exit and cope with that? (y or n)"
read b
if [ "$b" == "y" ];then
	exit
fi

echo "2. WOrld-writable files"
find / -path /proc -prune -o -perm -2 ! -type l -ls

echo "Correct ones should be like this:\n
rw-r----- /var/log/"
find /var/log -perm -o=r ! -type l

echo "3. Files with no owner are threat."
find / -path /proc -prune -o -nouser -o -nogroup

echo "4. See which user is available?"
egrep -v '.*:\*|:\!' /etc/shadow | awk -F: '{print $1}'

echo "6. delete users without \':x:\'"
grep -v ':x:' /etc/passwd

echo "7. find out the users without password."
cat /etc/shadow | cut -d: -f 1,2 | grep '!'

echo "8. find out the locked users."
cat /etc/shadow | cut -d: -f 1,2 | grep '*'

echo "9. find out the expired users."
cat /etc/shadow | cut -d: -f 1,2 | grep '!!'

echo "10. The permission of \/boot should be at least 644, even 600."
ls -l /boot

echo "11. find out the executable files with suid/sgid."
find / -xdev -user root \( -perm -4000 -o -perm -2000 \)

echo "Check ACL status. (setfacl -m u:user:r file)"
getfacl

#1.4.2 Prevent *UNSET* bash history

echo "
export HISTSIZE=1500
readonly HISTFILE
readonly HISTFILESIZE
readonly HISTSIZE
" >> /etc/profile

#Set .bash_history as attr +a
find / -maxdepth 3|grep -i bash_history|while read line; do chattr +a "$line"; done

#1.5 sudoers

#2 Kernel Baseline

echo "net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_fin_timeout = 15
net.ipv4.tcp_max_syn_backlog = 8192
net.core.netdev_max_backlog = 16384
net.core.somaxconn = 4096
net.ipv4.tcp_keepalive_time = 300
net.ipv4.tcp_keepalive_probes = 3
net.ipv4.tcp_syn_retries = 3
net.ipv4.tcp_synack_retries = 3 
net.ipv4.conf.all.accept_source_route = 0
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.all.send_redirects = 0
net.ipv4.conf.default.send_redirects = 0
net.ipv4.conf.all.rp_filter = 1
net.ipv4.icmp_echo_ignore_broadcasts = 1
net.ipv4.icmp_ignore_bogus_error_responses = 1
net.ipv4.conf.all.log_martians = 1
kernel.randomize_va_space=2
kernel.kptr_restrict=1
" > /etc/sysctl.d/99-security.conf

#3 Hardening

#4. SSL/TLS baseline

# Any other...

echo 
exit 0

