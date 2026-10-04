#!/bin/sh
# router 2 - vxlan in STATIC mode

# eth0 goes to the switch (underlay)
ip addr add 10.1.1.2/24 dev eth0
ip link set eth0 up

# vxlan 10, we tell it where the other router is
ip link add vxlan10 type vxlan id 10 dev eth0 local 10.1.1.2 remote 10.1.1.1 dstport 4789
ip link set vxlan10 up

# bridge br0 links the host port (eth1) with the tunnel
ip link add br0 type bridge
ip link set br0 up
ip link set eth1 master br0
ip link set vxlan10 master br0
ip link set eth1 uv
