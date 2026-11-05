#!/bin/sh
set -eu
P=192.230
NODE="${1:-}"
case "$NODE" in
    Cyberia) COUNT=3 ;;
    Wired) COUNT=4 ;;
    Psyche) COUNT=2 ;;
    Copland) COUNT=3 ;;
    Schumann) COUNT=3 ;;
    Accela) COUNT=2 ;;
    Navi) COUNT=4 ;;
    Tachibana) COUNT=3 ;;
    Deus) COUNT=3 ;;
    Protocol7) COUNT=3 ;;
    Knights) COUNT=3 ;;
    Phantoma) COUNT=3 ;;
    Shibuya) COUNT=2 ;;
    *) echo "ERROR: nama router tidak valid." >&2; exit 1 ;;
esac
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
case "$NODE" in
    Cyberia)
        cat >> /etc/network/interfaces <<'NET'

auto eth0
iface eth0 inet dhcp
NET
        ip link set eth0 up
        a eth1 64.129/30
        a eth2 64.1/25
        r 0.0/18 64.130
        b 0.0/17
        ;;
    Wired)
        a eth0 64.130/30
        a eth1 42.1/30
        a eth2 50.65/30
        a eth3 22.65/29
        d 64.129
        r 16.0/22 22.66
        r 20.0/22 22.67
        r 0.0/20 22.68
        r 48.0/22 50.66
        r 32.0/20 42.2
        b 0.0/18
        ;;
    Psyche)
        a eth0 22.66/29
        a eth1 16.1/22
        d 22.65
        ;;
    Copland)
        a eth0 22.67/29
        a eth1 22.1/26
        a eth2 20.1/23
        d 22.65
        b 20.0/22
        ;;
    Schumann)
        a eth0 22.68/29
        a eth1 4.1/30
        a eth2 8.1/29
        d 22.65
        r 0.0/22 4.2
        b 0.0/20
        ;;
    Accela)
        a eth0 4.2/30
        a eth1 0.1/22
        d 4.1
        ;;
    Navi)
        a eth0 50.66/30
        a eth1 48.1/24
        a eth2 50.1/26
        a eth3 49.1/24
        d 50.65
        b 48.0/22
        ;;
    Tachibana)
        a eth0 42.2/30
        a eth1 36.129/30
        a eth2 40.1/23
        d 42.1
        r 32.0/21 36.130
        b 32.0/20
        ;;
    Deus)
        a eth0 36.130/30
        a eth1 36.1/25
        a eth2 34.65/30
        d 36.129
        r 32.0/22 34.66
        b 32.0/21
        ;;
    Protocol7)
        a eth0 34.66/30
        a eth1 33.9/30
        a eth2 34.1/26
        d 34.65
        r 32.0/23 33.10
        b 32.0/22
        ;;
    Knights)
        a eth0 33.10/30
        a eth1 33.1/29
        a eth2 32.161/30
        d 33.9
        r 32.0/24 32.162
        b 32.0/23
        ;;
    Phantoma)
        a eth0 32.162/30
        a eth1 32.129/27
        a eth2 32.65/30
        d 32.161
        r 32.0/26 32.66
        b 32.0/24
        ;;
    Shibuya)
        a eth0 32.66/30
        a eth1 32.1/26
        d 32.65
        ;;
esac
printf '    post-up /bin/sh /root/routes.sh\n' >> /etc/network/interfaces
chmod +x /root/routes.sh
printf '#!/bin/sh\nexec sh /root/setup-router.sh %s\n' "$NODE" > /root/start-router.sh
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
