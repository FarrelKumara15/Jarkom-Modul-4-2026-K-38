#!/bin/sh
# Hanya Cyberia, eth0 menuju NAT1.
set -eu
command -v iptables >/dev/null 2>&1 || { echo "ERROR: iptables belum tersedia." >&2; exit 1; }
echo 1 > /proc/sys/net/ipv4/ip_forward
iptables -t nat -C POSTROUTING -s 192.230.0.0/17 -o eth0 -j MASQUERADE 2>/dev/null ||
iptables -t nat -A POSTROUTING -s 192.230.0.0/17 -o eth0 -j MASQUERADE
iptables -C FORWARD -s 192.230.0.0/17 -o eth0 -j ACCEPT 2>/dev/null ||
iptables -I FORWARD 1 -s 192.230.0.0/17 -o eth0 -j ACCEPT
iptables -C FORWARD -i eth0 -d 192.230.0.0/17 -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT 2>/dev/null ||
iptables -I FORWARD 1 -i eth0 -d 192.230.0.0/17 -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
echo "Aturan NAT diterapkan; uji internet dari Wired."
