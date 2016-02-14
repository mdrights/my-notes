#!/bin/bash
# Auto-netstat.sh - collecting network connection status of the host.

echo "---- `date` ----" >> $HOME/ss.txt
	/bin/ss -tup >> $HOME/ss.txt
echo "" >> $HOME/ss.txt 

echo "Information saved."
exit 
