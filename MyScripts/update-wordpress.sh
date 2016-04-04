#!/bin/bash 
# A lazy script helping update my wordpress manually :) on 2016.01.20

if [ "$PWD" != "$HOME" ]; then
	echo "Please go to your home:)"
	exit
fi

echo "Checking whether the zip file is in your home..."
if [ -f $HOME/latest.tar.gz ]; then
	echo "It exist!"
else
	echo "Fetching it from Wordpress.org/..."
	wget -c http://wordpress.org/latest.tar.gz
fi

FILESIZE=$(echo "$(ls -l mbox)") | awk '{print $5}'
if [ -f $HOME/latest.tar.gz ]; then
	echo "It exists now!"
	echo "Its filesize is $FILESIZE. Continue? (y/n)"
	read b
	if [ $b != "y" ]; then
		exit
	fi
fi

echo "Do you want to update now?"
read i
if [ "$i" != "y" ]; then
	exit
fi


# Backing-up.
cp -R /usr/share/wordpress/wp-includes/ $HOME/wp-backup/
cp -R /usr/share/wordpress/wp-admin/ $HOME/wp-backup/

# Copying new files to current ones.
tar -zxvf latest.tar.gz -C /usr/share/wordpress/wp-admin/
tar -zxvf latest.tar.gz -C /usr/share/wordpress/wp-includes/
tar -zxvf latest.tar.gz -C /usr/share/wordpress/wp-content/
tar --wildcards -zxvf latest.tar.gz -C /usr/share/ 'wordpress/*.php'

echo "OK. Now go to your wp page to click \'update\' button."
echo
exit 0
