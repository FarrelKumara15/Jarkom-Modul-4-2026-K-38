#!/bin/sh
set -eu
P=192.230
# Khusus console Copland; simpan sebagai /root/Copland.sh.
NODE=Copland
COUNT=3
command -v ip >/dev/null 2>&1 || { echo "ERROR: ip tidak tersedia." >&2; exit 1; }
i=0
while [ "$i" -lt "$COUNT" ]; do
    ip link show "eth$i" >/dev/null 2>&1 || {
        echo "ERROR: eth$i tidak tersedia pada $NODE. Periksa adapter." >&2
        exit 1
    }
    i=$((i + 1))
done
if [ -f /etc/network/interfaces ] && [ ! -f /root/interfaces.before-cidr ]; then
    cp /etc/network/interfaces /root/interfaces.before-cidr
fi
mkdir -p /etc/network
cat > /etc/network/interfaces <<'NET'
auto lo
iface lo inet loopback
NET
cat > /root/routes.sh <<'ROUTES'
#!/bin/sh
set -eu
echo 1 > /proc/sys/net/ipv4/ip_forward
ROUTES
echo 1 > /proc/sys/net/ipv4/ip_forward
mask() {
    case "$1" in
        22) echo 255.255.252.0 ;;
        23) echo 255.255.254.0 ;;
        24) echo 255.255.255.0 ;;
        25) echo 255.255.255.128 ;;
        26) echo 255.255.255.192 ;;
        27) echo 255.255.255.224 ;;
        29) echo 255.255.255.248 ;;
        30) echo 255.255.255.252 ;;
        *) echo "ERROR: prefix tidak didukung." >&2; exit 1 ;;
    esac
}
a() {
    DEV="$1"
    CIDR="$2"
    ADDR="$P.${CIDR%/*}"
    PREFIX="${CIDR#*/}"
    MASK="$(mask "$PREFIX")"
    cat >> /etc/network/interfaces <<NET

auto $DEV
iface $DEV inet static
    address $ADDR
    netmask $MASK
NET
    echo "[IP] $DEV $ADDR/$PREFIX"
    ip link set "$DEV" up
    ip -4 address flush dev "$DEV" scope global
    ip address add "$ADDR/$PREFIX" dev "$DEV"
}
d() {
    ip route replace default via "$P.$1"
    printf 'ip route replace default via %s\n' "$P.$1" >> /root/routes.sh
}
r() {
    ip route replace "$P.$1" via "$P.$2"
    printf 'ip route replace %s via %s\n' "$P.$1" "$P.$2" >> /root/routes.sh
}
b() {
    ip route replace blackhole "$P.$1"
    printf 'ip route replace blackhole %s\n' "$P.$1" >> /root/routes.sh
}
        a eth0 22.67/29
        a eth1 22.1/26
        a eth2 20.1/23
        d 22.65
        b 20.0/22
printf '    post-up /bin/sh /root/routes.sh\n' >> /etc/network/interfaces
chmod +x /root/routes.sh
printf '#!/bin/sh\nexec sh /root/Copland.sh %s\n' "$NODE" > /root/start-router.sh
chmod +x /root/start-router.sh
echo "=== IPv4 ==="
ip -4 address show
echo "=== Routing ==="
ip -4 route show
echo "=== Forwarding ==="
cat /proc/sys/net/ipv4/ip_forward
echo "Setup internal $NODE selesai. Verifikasi dengan ping."
if [ "$NODE" = Cyberia ]; then
    echo "=== WAN Cyberia (dikelola terpisah) ==="
    ip -4 address show dev eth0
    ip -4 route show default
    echo "DHCP: sh /root/enable-wan.sh; NAT: sh /root/nat.sh"
fi
