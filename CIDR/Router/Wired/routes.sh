#!/bin/sh
set -eu
echo 1 > /proc/sys/net/ipv4/ip_forward
ip route replace default via 192.230.64.129
ip route replace 192.230.16.0/22 via 192.230.22.66
ip route replace 192.230.20.0/22 via 192.230.22.67
ip route replace 192.230.0.0/20 via 192.230.22.68
ip route replace 192.230.48.0/22 via 192.230.50.66
ip route replace 192.230.32.0/20 via 192.230.42.2
ip route replace blackhole 192.230.0.0/18
