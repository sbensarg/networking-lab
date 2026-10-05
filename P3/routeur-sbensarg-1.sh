#!/bin/sh
# router 1 = route reflector (RR), the center of the network
# no vxlan here, it only does ospf + bgp

vtysh <<'END'
conf t
! loopback = router identity, always up
interface lo
 ip address 1.1.1.1/32
 ip ospf area 0
! one /30 link to each leaf
interface eth0
 ip address 10.1.1.1/30
 ip ospf area 0
interface eth1
 ip address 10.1.1.5/30
 ip ospf area 0
interface eth2
 ip address 10.1.1.9/30
 ip ospf area 0
! ospf gives everyone a route to all loopbacks
router ospf
! bgp in AS 1, leaves connect dynamically from 1.1.1.0/29
router bgp 1
 neighbor ibgp peer-group
 neighbor ibgp remote-as 1
 neighbor ibgp update-source lo
 bgp listen range 1.1.1.0/29 peer-group ibgp
 ! evpn: share mac addresses, reflect them to all leaves
 address-family l2vpn evpn
  neighbor ibgp activate
  neighbor ibgp route-reflector-client
 exit-address-family
end
END
