#!/bin/sh
set -eu
echo 1 > /proc/sys/net/ipv4/ip_forward
ip route replace 192.230.0.0/18 via 192.230.64.130
ip route replace blackhole 192.230.0.0/17
