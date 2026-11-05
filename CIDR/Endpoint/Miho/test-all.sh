#!/bin/sh
# Jalankan dari setiap router dan klien. Internet diuji terpisah.
set -eu
SOURCE="${1:-$(hostname)}"
PASS=0
FAIL=0
printf 'source,target,ip,status\n'
while read -r TARGET ADDR; do
    if ping -c 2 -W 2 "$ADDR" >/dev/null 2>&1; then
        STATUS=PASS
        PASS=$((PASS + 1))
    else
        STATUS=FAIL
        FAIL=$((FAIL + 1))
    fi
    printf '%s,%s,%s,%s\n' "$SOURCE" "$TARGET" "$ADDR" "$STATUS"
done <<'TARGETS'
Cyberia-eth1 192.230.64.129
Cyberia-eth2 192.230.64.1
Wired-eth0 192.230.64.130
Wired-eth1 192.230.42.1
Wired-eth2 192.230.50.65
Wired-eth3 192.230.22.65
Psyche-eth0 192.230.22.66
Psyche-eth1 192.230.16.1
Copland-eth0 192.230.22.67
Copland-eth1 192.230.22.1
Copland-eth2 192.230.20.1
Schumann-eth0 192.230.22.68
Schumann-eth1 192.230.4.1
Schumann-eth2 192.230.8.1
Accela-eth0 192.230.4.2
Accela-eth1 192.230.0.1
Navi-eth0 192.230.50.66
Navi-eth1 192.230.48.1
Navi-eth2 192.230.50.1
Navi-eth3 192.230.49.1
Tachibana-eth0 192.230.42.2
Tachibana-eth1 192.230.36.129
Tachibana-eth2 192.230.40.1
Deus-eth0 192.230.36.130
Deus-eth1 192.230.36.1
Deus-eth2 192.230.34.65
Protocol7-eth0 192.230.34.66
Protocol7-eth1 192.230.33.9
Protocol7-eth2 192.230.34.1
Knights-eth0 192.230.33.10
Knights-eth1 192.230.33.1
Knights-eth2 192.230.32.161
Phantoma-eth0 192.230.32.162
Phantoma-eth1 192.230.32.129
Phantoma-eth2 192.230.32.65
Shibuya-eth0 192.230.32.66
Shibuya-eth1 192.230.32.1
JJ 192.230.64.2
MyuMyu 192.230.64.3
Karl 192.230.16.2
Lin 192.230.16.3
Juri 192.230.22.2
Masayuki 192.230.20.2
Akashic 192.230.8.2
Omnipresence 192.230.0.2
Denpa 192.230.0.3
Alice 192.230.48.2
Reika 192.230.48.3
Taro 192.230.50.2
Yasuo 192.230.49.2
Miho 192.230.49.3
Kuma 192.230.49.4
Collective 192.230.40.2
Ghost 192.230.40.3
Lilith 192.230.36.2
Specter 192.230.36.3
Chisa 192.230.34.2
Hodgeson 192.230.34.3
Eiri 192.230.33.2
Semi 192.230.32.130
Lain 192.230.32.2
Mika 192.230.32.3
TARGETS
echo "Hasil $SOURCE: PASS=$PASS FAIL=$FAIL" >&2
[ "$FAIL" -eq 0 ]
