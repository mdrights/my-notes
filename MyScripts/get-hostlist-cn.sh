#!/bin/bash
# This is to fetch the list of malware websites collected by www.mwsl.org.cn/. Probably update once a week.
# By YCN on the first day of CNY, Feb 08 2016.


NULLIP="127.0.0.1"
TMP1="/tmp/temp1.txt"
TMP2="/tmp/get-hostlist-$(date +%Y%m%d).txt"
CONFIGFILE="/etc/dnsmasq.d/mal-hostlist-$(date +%Y%m%d).conf"
TXT="/etc/dnsmasq.d/domain-block-manual.txt"

if [ "$UID" != 0 ]; then
        echo "You must be root!"
        exit
fi


/usr/bin/wget -O $TMP1 http://dn-mwsl-hosts.qbox.me/hosts.txt

[ ! -s $TMP1 ] && echo "$TMP1 is empty. Please re-download." && exit
[ -s $CONFIGFILE ] && rm -f $CONFIGFILE

grep -a -e ^181.215.102.78 $TMP1 | \
sed -e "s/181.215.102.78 //" \
 -e "s/^[ \x09]*//;s/[ \x09]*$//" \
 -e "/^$/ d" > $TMP2 

while read line; do
        ADDRESS="/${line}/${NULLIP}"
        echo "address=${ADDRESS}" >> $CONFIGFILE 
done < $TMP2

TITLE=$(read line < $TMP1 && echo ${line})
echo "Updated successfully: $TITLE"

[ -e $TXT ] && cat $TXT >> $CONFIGFILE
echo "A manual list founded and it's been added."

tail $CONFIGFILE

rm $TMP1
# /etc/init.d/dnsmasq restart

exit
