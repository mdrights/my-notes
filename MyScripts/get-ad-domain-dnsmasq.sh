#!/bin/bash
# To update the list of the domains of ad servers from pgl.yoyo.org/. The list will be used by Dnsmasq to block certain domains to be resolved.
# First made on Feb 07 2016, the eve of CNY.

CONFIGFILE=/etc/dnsmasq.d/ad-domain-block.conf
LISTURL="http://pgl.yoyo.org/adservers/serverlist.php?hostformat=dnsmasq&showintro=0"
TMPFILE="/tmp/ad-list.$(date +%Y%m%d).txt"
TMP2=/tmp/temp2.txt

if [ "$UID" != 0 ]; then
	echo "You must be root!"
	exit
fi

/usr/bin/wget -O $TMPFILE $LISTURL


[ ! -s $TMPFILE ] && echo "$TMPFILE doesn't exist or is empty." && exit

sed -e "s/#.*//" \
    -e "s/[ \x09]*$//" \
    -e "s/\n//" \
    -e "s/^[ \x09]*//;s/[ \x09]*$//" $1 \
    -e "s/\(.*\)<\(.*\)//" \
    -e "/^$/ d" $TMPFILE > $CONFIGFILE 

# /etc/init.d/dnsmasq restart

exit
