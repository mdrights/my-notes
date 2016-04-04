#!/bin/bash
# Monitoring 1) who connects to my ssserver; 2)what ip/websites do they visit.

if [ $UID != 0 ];then
	echo "Sorry, you must be root!"
	exit 0
fi


Filein=/tmp/SS-in.txt
Fileout=/tmp/SS-out.txt
Result=/home/linus/SS-Result.txt
CurMonth=`date +%b`
CurDay=`date +%d`


echo "Your host's listening ports."
ss -tulp | grep -o "users.*" > $Result
echo >> $Result

# Filter and writing the Incoming IPs within today.

grep 'SS-in' /var/log/messages | grep "$CurMonth $CurDay" > $Filein

echo "`date`, `hostname`." >> $Result
echo "Shadowsocks Incoming IPs:" >> $Result
echo >> $Result

/usr/bin/awk '{print $1$2; print $11}' $Filein >> $Result

echo >> $Result
echo "---------------------------------------" >> $Result

# Filter and writing the Destination IPs within today.
# Not doing it now.

#grep 'SS-out' /var/log/messages | grep "$CurMonth $CurDay" > $Fileout

#echo "Shadowsocks Outgoing IPs:" >> $Result
#echo >> $Result

#/usr/bin/awk '{print $1$2; print $10}' $Fileout >> $Result

echo >> $Result

echo "Done.
Sending email..."

cat $Result | mutt -s "SS usage at `date`, `hostname`" linusyeung@live.com

echo
exit 0
