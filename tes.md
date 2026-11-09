Prefix kelompok: `192.230.0.0/19`

## Daftar target (ping dari JJ)

| No | Subnet | Target IP | Perangkat | Jalur |
|----|--------|-----------|-----------|-------|
| 1 | A1 | `192.230.14.3` | MyuMyu (laptop) | Satu subnet dengan JJ, lewat Switch1 |
| 2 | A2 | `192.230.16.57` | Cyberia (router) | Link Cyberia - Wired |
| 3 | A3 | `192.230.16.34` | Psyche (router) | Wired - Switch2 - Psyche |
| 4 | A4 | `192.230.0.2` | Karl (server) | Lewat Switch3 - Psyche |
| 5 | A5 | `192.230.15.194` | Juri (laptop) | Langsung ke Copland |
| 6 | A6 | `192.230.8.2` | Masayuki (laptop) | Lewat Switch4 - Copland |
| 7 | A7 | `192.230.16.42` | Akashic (server) | Langsung ke Schumann |
| 8 | A8 | `192.230.16.62` | Accela (router) | Link Schumann - Accela |
| 9 | A9 | `192.230.4.2` | Omnipresence (PC) | Lewat Switch5 - Accela |
| 10 | A10 | `192.230.16.66` | Navi (router) | Link Wired - Navi |
| 11 | A11 | `192.230.12.2` | Alice (laptop) | Lewat Switch6 - Navi |
| 12 | A12 | `192.230.15.66` | Taro (PC) | Lewat Switch7 - Navi |
| 13 | A13 | `192.230.13.2` | Yasuo (PC) | Lewat Switch8 - Navi |
| 14 | A14 | `192.230.16.70` | Tachibana (router) | Link Wired - Tachibana |
| 15 | A15 | `192.230.10.2` | Collective (server) | Lewat Switch9 - Tachibana |
| 16 | A16 | `192.230.16.74` | Deus (router) | Link Tachibana - Deus |
| 17 | A17 | `192.230.14.130` | Lilith (laptop) | Lewat Switch10 - Deus |
| 18 | A18 | `192.230.16.78` | Protocol7 (router) | Link Deus - Protocol7 |
| 19 | A19 | `192.230.15.130` | Chisa (laptop) | Lewat Switch11 - Protocol7 |
| 20 | A20 | `192.230.16.82` | Knights (router) | Link Protocol7 - Knights |
| 21 | A21 | `192.230.16.50` | Eiri (server) | Langsung ke Knights |
| 22 | A22 | `192.230.16.86` | Phantoma (router) | Link Knights - Phantoma |
| 23 | A23 | `192.230.16.2` | Semi (PC) | Lewat Switch12 - Phantoma |
| 24 | A24 | `192.230.16.90` | Shibuya (router) | Link Phantoma - Shibuya |
| 25 | A25 | `192.230.15.2` | Lain (laptop) | Lewat Switch13 - Shibuya |

Cloud/NAT tidak punya IP dari prefix kelompok, jadi tidak dites.

## Cek tabel routing

Di CLI router: `show ip route`.

## Pertanyaan

1. Mengapa jumlah IP pada tiap subnet harus dihitung dari jumlah host ditambah jumlah interface router?
2. Apa perbedaan tujuan VLSM dan CIDR?
3. Dalam VLSM, kenapa alokasi dimulai dari subnet dengan kebutuhan host terbesar (A4 dan A9, /22) dan bukan dari urutan A1?
4. Pada CIDR, mengapa dua subnet yang digabung harus bersebelahan (contiguous) dan netmask gabungan menjadi prefix terkecil dikurangi 1?
5. Mengapa setiap router non-core cukup memakai default route ke router parent, dan static route hanya ditulis ke arah child?
6. Bagaimana router memilih rute ketika beberapa route cocok (misal 10.<P>.8.0/21 dan 0.0.0.0/0), dan apa kaitannya dengan summary route CIDR?
