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


echo
exit 0
