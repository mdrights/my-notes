#!/bin/bash
# Showing system info. 2015-12-23
# And email them. 2016-03-29

Result=/home/linus/system-info.txt

echo -e "\e[31;43m***** HOSTNAME INFORMATION *****\e[0m" > $Result
hostnamectl >> $Result
echo >> $Result

echo -e "\e[31;43m***** DISK SPACE USAGE *****\e[0m" >> $Result
df -h >> $Result
echo >> $Result

echo -e "\e[31;43m***** FREE AND USED MEMORY *****\e[0m" >> $Result
free -h >> $Result
echo >> $Result

echo -e "\e[31;43m***** SYSTEM UPTIME AND LOAD *****\e[0m" >> $Result
uptime >> $Result
echo >> $Result

echo -e "\e[31;43m***** CURRENTLY LOGGED-IN USERS *****\e[0m" >> $Result
who >> $Result
echo >> $Result

#echo -e "\e[31;43m***** TOP 5 MEMORY-CONSUMING PROCESSES *****\e[0m" 
#ps -e o pid,-%mem,%cpu,comm --sort=%mem | head -n 6
#echo



#Checking FILE SYSTEM USAGE

echo >> $Result
echo -e "\e[4;32mCHECKING FILE SYSTEM USAGE....\e[0m" >> $Result

THRESOLD=80
n=2
while [ $n -le $(echo "`df`" | wc -l) ]
do
	NUM=$n
	FILESYSTEM=$(echo "`df`" | awk 'NR=='$NUM' {print $1}') 
	PERCENTAGE=$(echo "`df`" | awk 'NR=='$NUM' {print $5}')
	USAGE=${PERCENTAGE%?}
	# echo "$FILESYSTEM; $PERCENTAGE; $USAGE." >> $Result
	n=$[ $n + 1 ]

if [ $USAGE -gt $THRESOLD ]; then
	echo >> $Result
	echo "The remaining available space in $FILESYSTEM is critically low. Used: $PERCENTAGE" >> $Result
fi

done
#< <(df -h --total | grep -vi filesystem)

echo "Sending email..." >> $Result

cat $Result | mutt -s "VPS info at `date`, `hostname`" linusyeung@live.com

echo

echo -e "\e[1;32mDone.\e[0m" >> $Result

echo
exit 0





