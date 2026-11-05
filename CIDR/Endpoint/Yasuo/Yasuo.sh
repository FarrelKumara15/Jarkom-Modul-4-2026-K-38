#!/bin/sh
set -eu
# Khusus console Yasuo; simpan sebagai /root/Yasuo.sh.
NODE=Yasuo
ADDR=192.230.49.2/24
GW=192.230.49.1
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
printf '#!/bin/sh\nexec sh /root/Yasuo.sh %s\n' "$NODE" > /root/start-client.sh
echo "Setup $NODE selesai."
ip -4 address show dev eth0
ip route
