#!/bin/sh
# host 2, same virtual lan as host 1
ip addr add 30.1.1.2/24 dev eth0
ip link set eth0 up
