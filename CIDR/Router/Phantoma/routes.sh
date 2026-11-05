#!/bin/sh
set -eu
echo 1 > /proc/sys/net/ipv4/ip_forward
ip route replace default via 192.230.32.161
ip route replace 192.230.32.0/26 via 192.230.32.66
ip route replace blackhole 192.230.32.0/24
