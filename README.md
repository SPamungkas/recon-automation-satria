# Recon Automation by Satria

Script otomatisasi untuk melakukan recon subdomain dan validasi host yang aktif (live). Project ini dirancang untuk mempermudah workflow bug bounty atau penetration testing.

## Setup Environment

Pastikan Anda menggunakan Kali Linux atau distro Linux lainnya. Project ini menggunakan `pdtm` untuk mengelola tools dari ProjectDiscovery.

### 1. Install pdtm & Tools
```bash
# Install pdtm
go install -v [github.com/projectdiscovery/pdtm/cmd/pdtm@latest](https://github.com/projectdiscovery/pdtm/cmd/pdtm@latest)

# Install tools yang dibutuhkan
pdtm -install subfinder
pdtm -install httpx
sudo apt install anew -y
```
# Cara Menjalankan Script
Jalankan script pada terminal, menggunakan command:
```bash
./recon-auto.sh
```
# Contoh Input dan Output
```bash
# Contoh Input
google.com
yahoo.com

# Contoh Output
mail.google.com
dev.google.com
api.yahoo.com
```

# Struktur Folder
input/: Berisi file domains.txt (list target). <br>
scripts/: Berisi logic script otomatisasi. <br>
output/: Berisi hasil scan (all-subdomains.txt dan live.txt). <br>
log/: Berisi detail hasil scan yang didapat.

# Summary Script yang Dibuat (Detail ada pada comment tiap bagian syntax)
Script recon-auto.sh bekerja dengan alur: <br>
Subfinder: Mencari semua subdomain dari list di input/domains.txt.<br>
Anew: Memastikan tidak ada duplikasi data di output/all-subdomains.txt.<br>
Httpx: Melakukan probing untuk mengecek subdomain mana yang aktif (HTTP/HTTPS) dan menyimpannya di live.txt.<br>
tee: Menggunakan tee untuk memantau proses di terminal sekaligus menyimpannya ke file log.<br>
Timestamping: Memberikan penanda waktu pada setiap proses agar riwayat scan terdokumentasi dengan akurat.<br>

# Contoh Hasil
Berikut merupkan hasil yang didapat dari proses eksekusi:
<p align="center">
 <img width="500" height="108" alt="image" src="https://github.com/user-attachments/assets/9cc87396-9d3e-4e8f-9763-0ce66335c602" />
  <br>
</p>
Berikut merupakan hasil dari live.txt:
<p align="center">
 <img width="500" height="98" alt="image" src="https://github.com/user-attachments/assets/5e249785-0d42-4139-b32b-d79f9fcfb6b2" />
  <br>
</p>
