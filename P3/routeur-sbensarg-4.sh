#!/bin/sh
# router 4 = leaf (VTEP), eth0 goes to the RR, eth1 goes to the host

# bridge br0 links the host port with the vxlan tunnel
ip link add br0 type bridge
ip link set br0 up

# vxlan 10 from our loopback, no remote: bgp tells us where the others are
ip link add vxlan10 type vxlan id 10 dstport 4789 local 1.1.1.4 nolearning
ip link set vxlan10 master br0
ip link set vxlan10 up

ip link set eth1 master br0
ip link set eth1 up

vtysh <<'END'
conf t
! loopback = router identity, also the vtep ip
interface lo
 ip address 1.1.1.4/32
 ip ospf area 0
! link to the RR
interface eth0
 ip address 10.1.1.10/30
 ip ospf area 0
router ospf
! bgp in AS 1, only one neighbor: the RR
router bgp 1
 neighbor 1.1.1.1 remote-as 1
 neighbor 1.1.1.1 update-source lo
 ! evpn: announce our vni and our hosts' macs
 address-family l2vpn evpn
  neighbor 1.1.1.1 activate
  advertise-all-vni
 exit-address-family
end
END
