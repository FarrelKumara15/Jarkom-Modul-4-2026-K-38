#!/bin/sh
set -eu
NODE="${1:-}"
case "$NODE" in
    JJ) ADDR=192.230.64.2/25; GW=192.230.64.1 ;;
    MyuMyu) ADDR=192.230.64.3/25; GW=192.230.64.1 ;;
    Karl) ADDR=192.230.16.2/22; GW=192.230.16.1 ;;
    Lin) ADDR=192.230.16.3/22; GW=192.230.16.1 ;;
    Juri) ADDR=192.230.22.2/26; GW=192.230.22.1 ;;
    Masayuki) ADDR=192.230.20.2/23; GW=192.230.20.1 ;;
    Akashic) ADDR=192.230.8.2/29; GW=192.230.8.1 ;;
    Omnipresence) ADDR=192.230.0.2/22; GW=192.230.0.1 ;;
    Denpa) ADDR=192.230.0.3/22; GW=192.230.0.1 ;;
    Alice) ADDR=192.230.48.2/24; GW=192.230.48.1 ;;
    Reika) ADDR=192.230.48.3/24; GW=192.230.48.1 ;;
    Taro) ADDR=192.230.50.2/26; GW=192.230.50.1 ;;
    Yasuo) ADDR=192.230.49.2/24; GW=192.230.49.1 ;;
    Miho) ADDR=192.230.49.3/24; GW=192.230.49.1 ;;
    Kuma) ADDR=192.230.49.4/24; GW=192.230.49.1 ;;
    Collective) ADDR=192.230.40.2/23; GW=192.230.40.1 ;;
    Ghost) ADDR=192.230.40.3/23; GW=192.230.40.1 ;;
    Lilith) ADDR=192.230.36.2/25; GW=192.230.36.1 ;;
    Specter) ADDR=192.230.36.3/25; GW=192.230.36.1 ;;
    Chisa) ADDR=192.230.34.2/26; GW=192.230.34.1 ;;
    Hodgeson) ADDR=192.230.34.3/26; GW=192.230.34.1 ;;
    Eiri) ADDR=192.230.33.2/29; GW=192.230.33.1 ;;
    Semi) ADDR=192.230.32.130/27; GW=192.230.32.129 ;;
    Lain) ADDR=192.230.32.2/26; GW=192.230.32.1 ;;
    Mika) ADDR=192.230.32.3/26; GW=192.230.32.1 ;;
    *) echo "ERROR: nama klien tidak valid; contoh: sh /root/setup-client.sh JJ" >&2; exit 1 ;;
esac
ip link show eth0 >/dev/null
ip link set eth0 up
ip -4 address flush dev eth0 scope global
ip address add "$ADDR" dev eth0
ip route replace default via "$GW"
printf 'nameserver 192.168.122.1\n' > /etc/resolv.conf
PREFIX="${ADDR#*/}"
MASK="$(case "$PREFIX" in
        22) echo 255.255.252.0 ;;
        23) echo 255.255.254.0 ;;
        24) echo 255.255.255.0 ;;
        25) echo 255.255.255.128 ;;
        26) echo 255.255.255.192 ;;
        27) echo 255.255.255.224 ;;
        29) echo 255.255.255.248 ;;
        30) echo 255.255.255.252 ;;
esac)"
mkdir -p /etc/network
cat > /etc/network/interfaces <<NET
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address ${ADDR%/*}
    netmask $MASK
    gateway $GW
NET
printf '#!/bin/sh\nexec sh /root/setup-client.sh %s\n' "$NODE" > /root/start-client.sh
echo "Setup $NODE selesai."
ip -4 address show dev eth0
ip route
