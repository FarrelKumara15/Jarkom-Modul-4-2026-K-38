# Endpoint Yasuo

IP eth0: **192.230.49.2/24**. Gateway: **192.230.49.1**.

Salin isi folder ini ke /root pada console **Yasuo** di GNS3.

- [Yasuo.sh](Yasuo.sh): setup mandiri IP, gateway dan DNS.
- [start-client.sh](start-client.sh): menjalankan kembali setup setelah restart.
- [test-all.sh](test-all.sh): menguji 62 alamat internal.

```sh
sh /root/Yasuo.sh
ping -c 4 192.230.49.1
sh /root/test-all.sh Yasuo > /root/Yasuo-internal.csv
cat /root/Yasuo-internal.csv
```

Setup membuat ulang /root/start-client.sh. Ini pemulihan manual, bukan autostart. Lihat [panduan utama](../../PANDUAN.md) untuk penyalinan file dan pengujian.
