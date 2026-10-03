#!/bin/sh

# zebra first, the others need it
/usr/lib/frr/zebra -d -A 127.0.0.1
/usr/lib/frr/bgpd  -d -A 127.0.0.1
/usr/lib/frr/ospfd -d -A 127.0.0.1
/usr/lib/frr/isisd -d -A 127.0.0.1

# load frr.conf
sleep 1
vtysh -b

# give a shell in the gns3 console (also keeps the container running)
exec /bin/sh
