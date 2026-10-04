#!/bin/sh
# host 1, lives in the virtual lan 30.1.1.0/24
ip addr add 30.1.1.1/24 dev eth0
ip link set eth0 up
