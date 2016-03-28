#!/bin/bash
# Showing system info. 2015-12-23

echo -e "\e[31;43m***** HOSTNAME INFORMATION *****\e[0m"
hostnamectl
echo

echo -e "\e[31;43m***** DISK SPACE USAGE *****\e[0m"
df -h
echo

echo -e "\e[31;43m***** FREE AND USED MEMORY *****\e[0m"
free -h
echo

echo -e "\e[31;43m***** SYSTEM UPTIME AND LOAD *****\e[0m"
uptime
echo

echo -e "\e[31;43m***** CURRENTLY LOGGED-IN USERS *****\e[0m"
who
echo

echo -e "\e[31;43m***** TOP 5 MEMORY-CONSUMING PROCESSES *****\e[0m" 

ps -e o pid,%mem,%cpu,comm --sort=%mem | head -n 6
echo
echo -e "\e[1;32mDone.\e[0m"



#Checking FILE SYSTEM USAGE

echo -e "\e[4;32mCHECKING FILE SYSTEM USAGE\e[0m"

THRESOLD=30
n=2
for n in $(echo "`df`" | wc -l) ; do
	echo $n
	FILESYSTEM=$(echo $(echo `df | awk '{print $1}'` | awk '{print $n}')) 
	PERCENTAGE=$(echo $(echo `df | awk '{print $5}'` | awk '{print $n}'))
	echo $n
	USAGE=${PERCENTAGE%?}
	echo "$FILESYSTEM; $PERCENTAGE; $USAGE."

if [ "$USAGE" -gt "$THRESOLD" ]; then
	echo "The remaining available space in $FILENAME is critically low. Used: $PERCENTAGE"
fi

done #< <(df -h --total | grep -vi filesystem)




exit 0





