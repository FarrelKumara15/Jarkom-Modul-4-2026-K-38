#!/bin/sh
# Hanya Cyberia. Prasyarat: ifupdown + udhcpc, konfigurasi eth0 DHCP.
set -eu
command -v ifup >/dev/null 2>&1 || { echo "ERROR: pasang ifupdown dan udhcpc dahulu; baca PANDUAN.md." >&2; exit 1; }
command -v udhcpc >/dev/null 2>&1 || { echo "ERROR: udhcpc belum tersedia." >&2; exit 1; }
ip link set eth0 up
if ip -4 address show dev eth0 scope global | grep -q 'inet '; then
    echo "eth0 sudah memiliki IPv4. Jika masih IP statis sementara, lakukan migrasi DHCP di PANDUAN.md."
else
    ifup eth0
fi
ip -4 address show dev eth0
ip route show default
ip -4 address show dev eth0 scope global | grep -q 'inet ' || {
    echo "ERROR: belum ada IPv4 eth0." >&2; exit 1;
}
ip -4 route show default dev eth0 | grep -q '^default ' || {
    echo "ERROR: default route eth0 belum ada." >&2; exit 1;
}
ping -c 4 -W 2 192.168.122.1
ping -c 4 -W 2 1.1.1.1
