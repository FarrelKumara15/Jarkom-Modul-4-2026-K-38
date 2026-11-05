# Jarkom-Modul-4-2026-K-38

**Kelompok** : K-38

**Anggota** :

| Nama                 | NRP        | Soal  |
| -------------------- | ---------- | ----- |
| Farrel Arteya Kumara | 5027251020 | CIDR (GNS3) |
| Nayla Arsha Adyuta   | 5027251042 | VLSM (Cisco Packet Tracer)  |

<br/>

### CIDR 

![Topologi GNS3](CIDR/Assets/topologi-gns3.png)

<br/>

| Router | Adapter | eth0 menuju | eth1 menuju | eth2 menuju | eth3 menuju |
| --- | --- | --- | --- | --- | --- |
| Cyberia | 3 | NAT1 | Wired eth0 | Switch1 | — |
| Wired | 4 | Cyberia eth1 | Tachibana eth0 | Navi eth0 | Switch2 |
| Psyche | 2 | Switch2 | Switch3 | — | — |
| Copland | 3 | Switch2 | Juri eth0 | Switch4 | — |
| Schumann | 3 | Switch2 | Accela eth0 | Akashic eth0 | — |
| Accela | 2 | Schumann eth1 | Switch5 | — | — |
| Navi | 4 | Wired eth2 | Switch6 | Switch7 | Switch8 |
| Tachibana | 3 | Wired eth1 | Deus eth0 | Switch9 | — |
| Deus | 3 | Tachibana eth1 | Switch10 | Protocol7 eth0 | — |
| Protocol7 | 3 | Deus eth2 | Knights eth0 | Switch11 | — |
| Knights | 3 | Protocol7 eth1 | Eiri eth0 | Phantoma eth0 | — |
| Phantoma | 3 | Knights eth2 | Switch12 | Shibuya eth0 | — |
| Shibuya | 2 | Phantoma eth2 | Switch13 | — | — |

| Switch | Anggota |
| --- | --- |
| Switch1 | Cyberia, JJ, MyuMyu |
| Switch2 | Wired, Psyche, Copland, Schumann |
| Switch3 | Psyche, Karl, Lin |
| Switch4 | Copland, Masayuki |
| Switch5 | Accela, Omnipresence, Denpa |
| Switch6 | Navi, Alice, Reika |
| Switch7 | Navi, Taro |
| Switch8 | Navi, Yasuo, Miho, Kuma |
| Switch9 | Tachibana, Collective, Ghost |
| Switch10 | Deus, Lilith, Specter |
| Switch11 | Protocol7, Chisa, Hodgeson |
| Switch12 | Phantoma, Semi |
| Switch13 | Shibuya, Lain, Mika |

<br/>

## Kebutuhan Subnet
| ID | Segmen | Perhitungan | Kebutuhan usable | Network | Kapasitas usable |
| --- | --- | --- | --- | --- | --- |
| A1 | Cyberia–JJ–MyuMyu | 95+30+1 | 126 | 192.230.64.0/25 | 126 |
| A2 | Cyberia–Wired | 2 | 2 | 192.230.64.128/30 | 2 |
| A3 | Wired–Psyche–Copland–Schumann (Switch2) | 4 | 4 | 192.230.22.64/29 | 6 |
| A4 | Psyche–Karl–Lin | 700+180+1 | 881 | 192.230.16.0/22 | 1022 |
| A5 | Copland–Juri | 31+1 | 32 | 192.230.22.0/26 | 62 |
| A6 | Copland–Masayuki | 300+1 | 301 | 192.230.20.0/23 | 510 |
| A7 | Schumann–Akashic | 3+1 | 4 | 192.230.8.0/29 | 6 |
| A8 | Schumann–Accela | 2 | 2 | 192.230.4.0/30 | 2 |
| A9 | Accela–Omnipresence–Denpa | 510+3+1 | 514 | 192.230.0.0/22 | 1022 |
| A10 | Wired–Navi | 2 | 2 | 192.230.50.64/30 | 2 |
| A11 | Navi–Alice–Reika | 208+45+1 | 254 | 192.230.48.0/24 | 254 |
| A12 | Navi–Taro | 57+1 | 58 | 192.230.50.0/26 | 62 |
| A13 | Navi–Yasuo–Miho–Kuma | 120+18+4+1 | 143 | 192.230.49.0/24 | 254 |
| A14 | Wired–Tachibana | 2 | 2 | 192.230.42.0/30 | 2 |
| A15 | Tachibana–Collective–Ghost | 260+6+1 | 267 | 192.230.40.0/23 | 510 |
| A16 | Tachibana–Deus | 2 | 2 | 192.230.36.128/30 | 2 |
| A17 | Deus–Lilith–Specter | 77+21+1 | 99 | 192.230.36.0/25 | 126 |
| A18 | Deus–Protocol7 | 2 | 2 | 192.230.34.64/30 | 2 |
| A19 | Protocol7–Chisa–Hodgeson | 23+9+1 | 33 | 192.230.34.0/26 | 62 |
| A20 | Protocol7–Knights | 2 | 2 | 192.230.33.8/30 | 2 |
| A21 | Knights–Eiri | 2+1 | 3 | 192.230.33.0/29 | 6 |
| A22 | Knights–Phantoma | 2 | 2 | 192.230.32.160/30 | 2 |
| A23 | Phantoma–Semi | 14+1 | 15 | 192.230.32.128/27 | 30 |
| A24 | Phantoma–Shibuya | 2 | 2 | 192.230.32.64/30 | 2 |
| A25 | Shibuya–Lain–Mika | 57+4+1 | 62 | 192.230.32.0/26 | 62 |

Total kebutuhan usable: **2814** <br/>
Total blok subnet awal: **4188 alamat** <br/><br/>

## Penggabungan CIDR
Penggabungan mengikuti cabang dari bawah ke pusat. Pada metode praktikum ini, prefix induk = min(prefix anak) - 1. Terdapat 24 penggabungan dengan kedalaman maksimum sembilan tahap. Nomor C adalah identitas agregat, bukan urutan alamat. Subnet fisik tetap A1–A25.

### Tahap 1

| Agregat | Anak 1 | Anak 2 | Hasil | Rentang |
| --- | --- | --- | --- | --- |
| C1 | A25 /26 | A24 /30 | 192.230.32.0/25 | 192.230.32.0 – 192.230.32.127 |
| C2 | A23 /27 | A22 /30 | 192.230.32.128/26 | 192.230.32.128 – 192.230.32.191 |
| C4 | A21 /29 | A20 /30 | 192.230.33.0/28 | 192.230.33.0 – 192.230.33.15 |
| C6 | A19 /26 | A18 /30 | 192.230.34.0/25 | 192.230.34.0 – 192.230.34.127 |
| C8 | A17 /25 | A16 /30 | 192.230.36.0/24 | 192.230.36.0 – 192.230.36.255 |
| C10 | A15 /23 | A14 /30 | 192.230.40.0/22 | 192.230.40.0 – 192.230.43.255 |
| C12 | A11 /24 | A13 /24 | 192.230.48.0/23 | 192.230.48.0 – 192.230.49.255 |
| C13 | A12 /26 | A10 /30 | 192.230.50.0/25 | 192.230.50.0 – 192.230.50.127 |
| C15 | A9 /22 | A8 /30 | 192.230.0.0/21 | 192.230.0.0 – 192.230.7.255 |
| C17 | A5 /26 | A3 /29 | 192.230.22.0/25 | 192.230.22.0 – 192.230.22.127 |
| C23 | A1 /25 | A2 /30 | 192.230.64.0/24 | 192.230.64.0 – 192.230.64.255 |

### Tahap 2

| Agregat | Anak 1 | Anak 2 | Hasil | Rentang |
| --- | --- | --- | --- | --- |
| C3 | C1 /25 | C2 /26 | 192.230.32.0/24 | 192.230.32.0 – 192.230.32.255 |
| C14 | C12 /23 | C13 /25 | 192.230.48.0/22 | 192.230.48.0 – 192.230.51.255 |
| C16 | C15 /21 | A7 /29 | 192.230.0.0/20 | 192.230.0.0 – 192.230.15.255 |
| C18 | A6 /23 | C17 /25 | 192.230.20.0/22 | 192.230.20.0 – 192.230.23.255 |

### Tahap 3

| Agregat | Anak 1 | Anak 2 | Hasil | Rentang |
| --- | --- | --- | --- | --- |
| C5 | C3 /24 | C4 /28 | 192.230.32.0/23 | 192.230.32.0 – 192.230.33.255 |
| C19 | A4 /22 | C18 /22 | 192.230.16.0/21 | 192.230.16.0 – 192.230.23.255 |

### Tahap 4

| Agregat | Anak 1 | Anak 2 | Hasil | Rentang |
| --- | --- | --- | --- | --- |
| C7 | C5 /23 | C6 /25 | 192.230.32.0/22 | 192.230.32.0 – 192.230.35.255 |
| C20 | C16 /20 | C19 /21 | 192.230.0.0/19 | 192.230.0.0 – 192.230.31.255 |

### Tahap 5

| Agregat | Anak 1 | Anak 2 | Hasil | Rentang |
| --- | --- | --- | --- | --- |
| C9 | C7 /22 | C8 /24 | 192.230.32.0/21 | 192.230.32.0 – 192.230.39.255 |

### Tahap 6

| Agregat | Anak 1 | Anak 2 | Hasil | Rentang |
| --- | --- | --- | --- | --- |
| C11 | C9 /21 | C10 /22 | 192.230.32.0/20 | 192.230.32.0 – 192.230.47.255 |

### Tahap 7

| Agregat | Anak 1 | Anak 2 | Hasil | Rentang |
| --- | --- | --- | --- | --- |
| C21 | C11 /20 | C14 /22 | 192.230.32.0/19 | 192.230.32.0 – 192.230.63.255 |

### Tahap 8

| Agregat | Anak 1 | Anak 2 | Hasil | Rentang |
| --- | --- | --- | --- | --- |
| C22 | C20 /19 | C21 /19 | 192.230.0.0/18 | 192.230.0.0 – 192.230.63.255 |

### Tahap 9

| Agregat | Anak 1 | Anak 2 | Hasil | Rentang |
| --- | --- | --- | --- | --- |
| C24 | C22 /18 | C23 /24 | 192.230.0.0/17 | 192.230.0.0 – 192.230.127.255 |

## Pembagian Alamat IP
| ID | Network/prefix | Netmask | IP usable pertama | IP usable terakhir | Broadcast |
| --- | --- | --- | --- | --- | --- |
| A1 | 192.230.64.0/25 | 255.255.255.128 | 192.230.64.1 | 192.230.64.126 | 192.230.64.127 |
| A2 | 192.230.64.128/30 | 255.255.255.252 | 192.230.64.129 | 192.230.64.130 | 192.230.64.131 |
| A3 | 192.230.22.64/29 | 255.255.255.248 | 192.230.22.65 | 192.230.22.70 | 192.230.22.71 |
| A4 | 192.230.16.0/22 | 255.255.252.0 | 192.230.16.1 | 192.230.19.254 | 192.230.19.255 |
| A5 | 192.230.22.0/26 | 255.255.255.192 | 192.230.22.1 | 192.230.22.62 | 192.230.22.63 |
| A6 | 192.230.20.0/23 | 255.255.254.0 | 192.230.20.1 | 192.230.21.254 | 192.230.21.255 |
| A7 | 192.230.8.0/29 | 255.255.255.248 | 192.230.8.1 | 192.230.8.6 | 192.230.8.7 |
| A8 | 192.230.4.0/30 | 255.255.255.252 | 192.230.4.1 | 192.230.4.2 | 192.230.4.3 |
| A9 | 192.230.0.0/22 | 255.255.252.0 | 192.230.0.1 | 192.230.3.254 | 192.230.3.255 |
| A10 | 192.230.50.64/30 | 255.255.255.252 | 192.230.50.65 | 192.230.50.66 | 192.230.50.67 |
| A11 | 192.230.48.0/24 | 255.255.255.0 | 192.230.48.1 | 192.230.48.254 | 192.230.48.255 |
| A12 | 192.230.50.0/26 | 255.255.255.192 | 192.230.50.1 | 192.230.50.62 | 192.230.50.63 |
| A13 | 192.230.49.0/24 | 255.255.255.0 | 192.230.49.1 | 192.230.49.254 | 192.230.49.255 |
| A14 | 192.230.42.0/30 | 255.255.255.252 | 192.230.42.1 | 192.230.42.2 | 192.230.42.3 |
| A15 | 192.230.40.0/23 | 255.255.254.0 | 192.230.40.1 | 192.230.41.254 | 192.230.41.255 |
| A16 | 192.230.36.128/30 | 255.255.255.252 | 192.230.36.129 | 192.230.36.130 | 192.230.36.131 |
| A17 | 192.230.36.0/25 | 255.255.255.128 | 192.230.36.1 | 192.230.36.126 | 192.230.36.127 |
| A18 | 192.230.34.64/30 | 255.255.255.252 | 192.230.34.65 | 192.230.34.66 | 192.230.34.67 |
| A19 | 192.230.34.0/26 | 255.255.255.192 | 192.230.34.1 | 192.230.34.62 | 192.230.34.63 |
| A20 | 192.230.33.8/30 | 255.255.255.252 | 192.230.33.9 | 192.230.33.10 | 192.230.33.11 |
| A21 | 192.230.33.0/29 | 255.255.255.248 | 192.230.33.1 | 192.230.33.6 | 192.230.33.7 |
| A22 | 192.230.32.160/30 | 255.255.255.252 | 192.230.32.161 | 192.230.32.162 | 192.230.32.163 |
| A23 | 192.230.32.128/27 | 255.255.255.224 | 192.230.32.129 | 192.230.32.158 | 192.230.32.159 |
| A24 | 192.230.32.64/30 | 255.255.255.252 | 192.230.32.65 | 192.230.32.66 | 192.230.32.67 |
| A25 | 192.230.32.0/26 | 255.255.255.192 | 192.230.32.1 | 192.230.32.62 | 192.230.32.63 |

## Interface router

| Router | eth0 | eth1 | eth2 | eth3 |
| --- | --- | --- | --- | --- |
| Cyberia | DHCP NAT | 192.230.64.129/30 | 192.230.64.1/25 | — |
| Wired | 192.230.64.130/30 | 192.230.42.1/30 | 192.230.50.65/30 | 192.230.22.65/29 |
| Psyche | 192.230.22.66/29 | 192.230.16.1/22 | — | — |
| Copland | 192.230.22.67/29 | 192.230.22.1/26 | 192.230.20.1/23 | — |
| Schumann | 192.230.22.68/29 | 192.230.4.1/30 | 192.230.8.1/29 | — |
| Accela | 192.230.4.2/30 | 192.230.0.1/22 | — | — |
| Navi | 192.230.50.66/30 | 192.230.48.1/24 | 192.230.50.1/26 | 192.230.49.1/24 |
| Tachibana | 192.230.42.2/30 | 192.230.36.129/30 | 192.230.40.1/23 | — |
| Deus | 192.230.36.130/30 | 192.230.36.1/25 | 192.230.34.65/30 | — |
| Protocol7 | 192.230.34.66/30 | 192.230.33.9/30 | 192.230.34.1/26 | — |
| Knights | 192.230.33.10/30 | 192.230.33.1/29 | 192.230.32.161/30 | — |
| Phantoma | 192.230.32.162/30 | 192.230.32.129/27 | 192.230.32.65/30 | — |
| Shibuya | 192.230.32.66/30 | 192.230.32.1/26 | — | — |

## Endpoint

| Node | IP/prefix | Gateway |
| --- | --- | --- |
| JJ | 192.230.64.2/25 | 192.230.64.1 |
| MyuMyu | 192.230.64.3/25 | 192.230.64.1 |
| Karl | 192.230.16.2/22 | 192.230.16.1 |
| Lin | 192.230.16.3/22 | 192.230.16.1 |
| Juri | 192.230.22.2/26 | 192.230.22.1 |
| Masayuki | 192.230.20.2/23 | 192.230.20.1 |
| Akashic | 192.230.8.2/29 | 192.230.8.1 |
| Omnipresence | 192.230.0.2/22 | 192.230.0.1 |
| Denpa | 192.230.0.3/22 | 192.230.0.1 |
| Alice | 192.230.48.2/24 | 192.230.48.1 |
| Reika | 192.230.48.3/24 | 192.230.48.1 |
| Taro | 192.230.50.2/26 | 192.230.50.1 |
| Yasuo | 192.230.49.2/24 | 192.230.49.1 |
| Miho | 192.230.49.3/24 | 192.230.49.1 |
| Kuma | 192.230.49.4/24 | 192.230.49.1 |
| Collective | 192.230.40.2/23 | 192.230.40.1 |
| Ghost | 192.230.40.3/23 | 192.230.40.1 |
| Lilith | 192.230.36.2/25 | 192.230.36.1 |
| Specter | 192.230.36.3/25 | 192.230.36.1 |
| Chisa | 192.230.34.2/26 | 192.230.34.1 |
| Hodgeson | 192.230.34.3/26 | 192.230.34.1 |
| Eiri | 192.230.33.2/29 | 192.230.33.1 |
| Semi | 192.230.32.130/27 | 192.230.32.129 |
| Lain | 192.230.32.2/26 | 192.230.32.1 |
| Mika | 192.230.32.3/26 | 192.230.32.1 |

## Static routing

| Router | Default gateway | Tujuan → next hop | Blackhole |
| --- | --- | --- | --- |
| Cyberia | DHCP NAT | 192.230.0.0/18 → 192.230.64.130 | 192.230.0.0/17 |
| Wired | 192.230.64.129 | 192.230.16.0/22 → 192.230.22.66<br>192.230.20.0/22 → 192.230.22.67<br>192.230.0.0/20 → 192.230.22.68<br>192.230.48.0/22 → 192.230.50.66<br>192.230.32.0/20 → 192.230.42.2 | 192.230.0.0/18 |
| Psyche | 192.230.22.65 | — | — |
| Copland | 192.230.22.65 | — | 192.230.20.0/22 |
| Schumann | 192.230.22.65 | 192.230.0.0/22 → 192.230.4.2 | 192.230.0.0/20 |
| Accela | 192.230.4.1 | — | — |
| Navi | 192.230.50.65 | — | 192.230.48.0/22 |
| Tachibana | 192.230.42.1 | 192.230.32.0/21 → 192.230.36.130 | 192.230.32.0/20 |
| Deus | 192.230.36.129 | 192.230.32.0/22 → 192.230.34.66 | 192.230.32.0/21 |
| Protocol7 | 192.230.34.65 | 192.230.32.0/23 → 192.230.33.10 | 192.230.32.0/22 |
| Knights | 192.230.33.9 | 192.230.32.0/24 → 192.230.32.162 | 192.230.32.0/23 |
| Phantoma | 192.230.32.161 | 192.230.32.0/26 → 192.230.32.66 | 192.230.32.0/24 |
| Shibuya | 192.230.32.65 | — | — |

## GNS3 CIDR

| File | Penempatan |
| --- | --- |
| setup-router.sh | /root pada semua router |
| setup-client.sh | /root pada semua endpoint |
| test-all.sh | /root pada semua router dan endpoint |
| nat.sh dan enable-wan.sh | /root pada Cyberia saja |


Jalankan script setup-router.sh di semua router
```bash
sh setup-router.sh <router>
```

<br/>

| Console | Setup | Tes tetangga |
| --- | --- | --- |
| Cyberia | `sh setup-router.sh Cyberia` | Lanjut Wired |
| Wired | `sh setup-router.sh Wired` | `ping -c 4 192.230.64.129` |
| Psyche | `sh setup-router.sh Psyche` | `ping -c 4 192.230.22.65` |
| Copland | `sh setup-router.sh Copland` | `ping -c 4 192.230.22.65` |
| Schumann | `sh setup-router.sh Schumann` | `ping -c 4 192.230.22.65` |
| Accela | `sh setup-router.sh Accela` | `ping -c 4 192.230.4.1` |
| Navi | `sh setup-router.sh Navi` | `ping -c 4 192.230.50.65` |
| Tachibana | `sh setup-router.sh Tachibana` | `ping -c 4 192.230.42.1` |
| Deus | `sh setup-router.sh Deus` | `ping -c 4 192.230.36.129` |
| Protocol7 | `sh setup-router.sh Protocol7` | `ping -c 4 192.230.34.65` |
| Knights | `sh setup-router.sh Knights` | `ping -c 4 192.230.33.9` |
| Phantoma | `sh setup-router.sh Phantoma` | `ping -c 4 192.230.32.161` |
| Shibuya | `sh setup-router.sh Shibuya` | `ping -c 4 192.230.32.65` |

<br/>

#### Router Test
Di router Cyberia

```sh
ping -c 4 192.230.0.1
ping -c 4 192.230.48.1
ping -c 4 192.230.32.1
```

Di router Shibuya:

```sh
ping -c 4 192.230.64.1
ping -c 4 192.230.16.1
```

<br/>

Jalankan setup-client.sh di semua endpoint
```bash
sh setup-client.sh <endpoint>
```

| Console | Perintah |
| --- | --- |
| JJ | `sh setup-client.sh JJ` |
| MyuMyu | `sh setup-client.sh MyuMyu` |
| Karl | `sh setup-client.sh Karl` |
| Lin | `sh setup-client.sh Lin` |
| Juri | `sh setup-client.sh Juri` |
| Masayuki | `sh setup-client.sh Masayuki` |
| Akashic | `sh setup-client.sh Akashic` |
| Omnipresence | `sh setup-client.sh Omnipresence` |
| Denpa | `sh setup-client.sh Denpa` |
| Alice | `sh setup-client.sh Alice` |
| Reika | `sh setup-client.sh Reika` |
| Taro | `sh setup-client.sh Taro` |
| Yasuo | `sh setup-client.sh Yasuo` |
| Miho | `sh setup-client.sh Miho` |
| Kuma | `sh setup-client.sh Kuma` |
| Collective | `sh setup-client.sh Collective` |
| Ghost | `sh setup-client.sh Ghost` |
| Lilith | `sh setup-client.sh Lilith` |
| Specter | `sh setup-client.sh Specter` |
| Chisa | `sh setup-client.sh Chisa` |
| Hodgeson | `sh setup-client.sh Hodgeson` |
| Eiri | `sh setup-client.sh Eiri` |
| Semi | `sh setup-client.sh Semi` |
| Lain | `sh setup-client.sh Lain` |
| Mika | `sh setup-client.sh Mika` |

#### Tes gateway
Jalankan di JJ
```sh
ping -c 4 192.230.64.1
ping -c 4 192.230.16.2
ping -c 4 192.230.32.2
```

Tes koneksi Cyberia ke gateway NAT
```bash
ping -c 4 192.168.122.1
```

Tes akses internet Cyberia
```bash
ping -c 4 1.1.1.1
```

Tes DNS Cyberia
```bash
cat /etc/resolv.conf
getent ahostsv4 deb.debian.org
```

Jalankan NAT dan periksa aturan NAT di Cyberia
```bash 
sh nat.sh
cat /proc/sys/net/ipv4/ip_forward
iptables -t nat -L POSTROUTING -n -v
iptables -L FORWARD -n -v
```

Tes internet di JJ
```bash 
# Gateway JJ, yaitu Cyberia
ping -c 4 192.230.64.1

# Akses internet melalui Cyberia
ping -c 4 1.1.1.1

# Resolusi DNS
nslookup deb.debian.org
```
