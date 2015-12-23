

Hi GNUsercn!

Editing

/etc/NetworkManager/NetworkManager.conf

and commenting the line (precede it with a #)

dns=dnsmasq

and then in terminal

sudo restart network-manager

should do it.

cheers
