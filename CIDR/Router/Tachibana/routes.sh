#!/bin/sh
set -eu
echo 1 > /proc/sys/net/ipv4/ip_forward
ip route replace default via 192.230.42.1
ip route replace 192.230.32.0/21 via 192.230.36.130
ip route replace blackhole 192.230.32.0/20
