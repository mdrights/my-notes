#!/bin/bash
# Written at Mar 24, 2016, at Buji.
# Modified at Mar 29, 2016.
# Partly copied from https://github.com/citypw/DNFWAH/blob/master/4/d4_0x02_DNFWAH_gnu-linux_security_baseline_hardening.txt

echo "It could be run only once!"

if [ $UID != 0 ];then
	echo "You should be root, dude."
	exit
fi

#0.0 Back up first!"
echo "0.0 Back up first!"

cp /etc/ssh/sshd_config /root/sshd_config
cp /etc/ssh/ssh_config /root/ssh_config

# 0.1 Install some software.
echo "0.1 Install some software."
apt-get update
apt-get upgrade 
apt-get install wget git iftop htop python python-pip mutt w3m

echo "Install Shadowsocks."
pip install shadowsocks


# Checking security upgrade.
echo "1 Checking security upgrade."
apt-get upgrade -s | grep -i security

#2 ssh
echo "2 openSSH setting."
echo "Do the SSH setting? (y or n)"
read c
if [ "$c" == "y" ];then

echo "HashKnownHosts yes
Protocol 2
X11Forwarding no
IgnoreRhosts yes
PermitEmptyPasswords no
MaxAuthTries 5
" >> /etc/ssh/sshd_config

	echo "Have you upload your ssh key already? -If yes, press y."
	read a
	if [ "$a" == "y" ];then
	echo "
	PubkeyAuthentication yes
	PasswordAuthentication no
	" >> /etc/ssh/sshd_config
	else
	echo "Still using password Authentication."
	fi

	echo "Have you create a normal user for yourself yet (in order to forbid root login)? -If yes, press y."
	read b
	if [ "$b" == "y" ];then
	echo "Forbiding root login..."
	echo "PermitRootLogin no" >> /etc/ssh/sshd_config
	else
	echo "Still Permitting root login. Change later."
	fi
else
	continue
fi


#3 File Auditing

echo "3 File Auditing..."
echo "1. Wildcarding"
find / -path /proc -prune -name "-*"

echo "2. World-writable files. need to be changed."
n2=$(find / -path /proc -prune -o -perm -2 ! -type l -ls | awk '{print $11}')
echo "$n2"
for file in $n2;do
	chmod o-w $file
done	


echo "Log files should not be read by others: rw-r----- /var/log/"
n21=`find /var/log -perm -o=r ! -type l`
echo "$n21"
for file in $n21;do
	chmod o-r $file
done


echo "3. Files with no owner are threat."
n3=$(find / -path /proc -prune -o -nouser -o -nogroup)
echo "$n3"
for file in $n3;do
	chown root $file
done

echo "4. See which user is available?"
egrep -v '.*:\*|:\!' /etc/shadow | awk -F: '{print $1}'

echo "6. delete users without ':x:'"
n6=$(grep -v ':x:' /etc/passwd)
echo "$n6"
for name in $n6;do
	userdel $name
done

echo "7. find out the users without password."
n7=$(cat /etc/shadow | cut -d: -f 1,2 | grep '!' | awk -F : '{print $1}')
echo "$n7"
for user in $n7;do
	userdel $user
done


echo "8. find out the locked users."
cat /etc/shadow | cut -d: -f 1,2 | grep '*'

echo "9. find out the expired users."
cat /etc/shadow | cut -d: -f 1,2 | grep '!!'

echo "10. The permission of /boot should be at least 644, even 600."
n10=$(ls -l /boot)
echo "$n10"


echo "11. find out the executable files with suid/sgid."
find / -xdev -user root \( -perm -4000 -o -perm -2000 \)


echo "Check ACL status. (setfacl -m u:user:r file)"
#getfacl

# 4 Prevent *UNSET* bash history
echo "4 Prevent *UNSET* bash history."

echo "
export HISTSIZE=1500
readonly HISTFILE
readonly HISTFILESIZE
readonly HISTSIZE
" >> /etc/profile

#Set .bash_history as attr +a
echo "Set .bash_history as attr +a"
find / -maxdepth 3|grep -i bash_history|while read line; do chattr +a "$line"; done

#5 sudoers

#6 Kernel Baseline -- forked from LinuxMint hardening at Hardenedlinux.org.
echo "6 Setting Kernel Baseline..."

echo "Are you on a Desktop/laptop or on a server? (d for a desktop or s for server, or n to skip)"
read d
if [ "$d" == "d" ];then

echo "
##############################################################3
# Functions previously found in netbase
#

# Uncomment the next two lines to enable Spoof protection (reverse-path filter)
# Turn on Source Address Verification in all interfaces to
# prevent some spoofing attacks
net.ipv4.conf.default.rp_filter=1
net.ipv4.conf.all.rp_filter=1

# Uncomment the next line to enable TCP/IP SYN cookies
# See http://lwn.net/Articles/277146/
# Note: This may impact IPv6 TCP sessions too
net.ipv4.tcp_syncookies=1

# Desktop doesn't need IP forward
net.ipv4.ip_forward=0

#  Enabling this option disables Stateless Address Autoconfiguration
#  based on Router Advertisements for this host
net.ipv6.conf.all.forwarding=0


###################################################################
# Additional settings - these settings can improve the network
# security of the host and prevent against some network attacks
# including spoofing attacks and man in the middle attacks through
# redirection. Some network environments, however, require that these
# settings are disabled so review and enable them as needed.
#
# Do not accept ICMP redirects (prevent MITM attacks)
net.ipv4.conf.all.accept_redirects = 0
net.ipv6.conf.all.accept_redirects = 0

# _or_
# Accept ICMP redirects only for gateways listed in our default
# gateway list (enabled by default)
net.ipv4.conf.all.secure_redirects = 1
#
# Do not send ICMP redirects (we are not a router)
net.ipv4.conf.all.send_redirects = 0
#
# Do not accept IP source route packets (we are not a router)
net.ipv4.conf.all.accept_source_route = 0
net.ipv6.conf.all.accept_source_route = 0
#
# Log Martian Packets
net.ipv4.conf.all.log_martians = 1
net.ipv4.conf.default.log_martians = 0

#ignore broadcast imcp echo packet
net.ipv4.icmp_echo_ignore_broadcasts = 1

# Ignore all incoming ICMP echo requests
net.ipv4.icmp_echo_ignore_all = 0

# Don't log invalid responses to broadcast
net.ipv4.icmp_ignore_bogus_error_responses = 1

# Disable multicast routing
net.ipv4.conf.default.mc_forwarding=0
net.ipv4.conf.all.mc_forwarding = 0

# Disable proxy_arp
net.ipv4.conf.default.proxy_arp = 0
net.ipv4.conf.all.proxy_arp = 0

# Disable bootp_relay
net.ipv4.conf.default.bootp_relay = 0
net.ipv4.conf.all.bootp_relay = 0

##mitigation
kernel.randomize_va_space=2
kernel.kptr_restrict=2
vm.mmap_min_addr=65536

# Grsecurity
#kernel.grsecurity.chroot_restrict_nice = 0
#kernel.grsecurity.harden_ipc = 0
" > /etc/sysctl.d/99-security.conf

elif [ "$d" == "s" ];then

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
net.ipv4.tcp_max_orphans = 65536
net.ipv4.tcp_mem = 131072 196608 262144
net.core.rmem_max = 67108864
net.core.wmem_max = 67108864
kernel.randomize_va_space=2
kernel.kptr_restrict=1
" > /etc/sysctl.d/99-security.conf
fi

/sbin/sysctl --system

#7 Hardening with Apparmor/Grsecurity

#8 SSL/TLS baseline

echo "9. Browser (Firefox) privacy settings...please go there."
# Any other...

#echo "Want to exit and cope with that? (y or n)"
#read b
#if [ "$b" == "y" ];then
#	exit
#fi


echo 
exit 0

