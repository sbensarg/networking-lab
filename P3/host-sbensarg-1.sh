#!/bin/sh
# host 1, all hosts share the virtual lan 20.1.1.0/24 (vni 10)
ip addr add 20.1.1.1/24 dev eth0
ip link set eth0 up
