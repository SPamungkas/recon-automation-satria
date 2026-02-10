#!/bin/bash

# 1. Definisi Path (Relatif terhadap posisi script)
INPUT="../input/domains.txt"
ALL_SUBS="../output/all-subdomains.txt"
LIVE_HOSTS="../output/live.txt"
PROGRESS_LOG="../logs/progress.log"
ERROR_LOG="../logs/errors.log"

# Membuat folder jika belum ada
mkdir -p ../output ../logs

# 2. Fungsi untuk Timestamp
get_time() {
    date +"%Y-%m-%d %H:%M:%S"
}

echo -e "\n--- Memulai Sesi Recon: $(get_time) ---" | tee -a "$PROGRESS_LOG"

# 3. Validasi File Input
if [ ! -f "$INPUT" ]; then
    echo "[$(get_time)] CRITICAL: File $INPUT tidak ditemukan!" | tee -a "$ERROR_LOG"
    exit 1
fi

# 4. Proses Enumerasi & Deduplikasi
log_msg="[$(get_time)] INFO: Memulai Subdomain Enumeration..."
echo "$log_msg" | tee -a "$PROGRESS_LOG"

while IFS= read -r domain || [ -n "$domain" ]; do
    [[ -z "$domain" ]] && continue
    
    echo "[$(get_time)] Scanning: $domain" | tee -a "$PROGRESS_LOG"
    
    # Menjalankan subfinder -> deduplikasi dengan anew -> catat stderr ke error.log
    subfinder -d "$domain" -silent 2>>"$ERROR_LOG" | anew "$ALL_SUBS" >> "$PROGRESS_LOG"

done < "$INPUT"

# 5. Cek Host yang Live
log_msg="[$(get_time)] INFO: Memfilter host yang hidup dengan httpx (High Speed)..."
echo "$log_msg" | tee -a "$PROGRESS_LOG"

if [ -f "$ALL_SUBS" ]; then
    # -threads 200: Melakukan 200 koneksi sekaligus
    # -rl 500: Rate limit 500 request per detik (biar gak dianggap serangan DDoS)
    # -timeout 2: Gak usah nunggu lama kalau webnya lemot
    # -o: Menulis langsung ke file output
    cat "$ALL_SUBS" | httpx -silent -threads 200 -rl 500 -timeout 2 -o "$LIVE_HOSTS" 2>>"$ERROR_LOG"
else
    echo "[$(get_time)] WARNING: Tidak ada subdomain ditemukan." | tee -a "$ERROR_LOG"
fi

# 6. Output Akhir (Summary)
TOTAL_SUB=$(wc -l < "$ALL_SUBS" 2>/dev/null || echo 0)
TOTAL_LIVE=$(wc -l < "$LIVE_HOSTS" 2>/dev/null || echo 0)

echo -e "\n================ RECON SUMMARY ================" | tee -a "$PROGRESS_LOG"
echo "Waktu Selesai      : $(get_time)" | tee -a "$PROGRESS_LOG"
echo "Total Subdomain Unik: $TOTAL_SUB" | tee -a "$PROGRESS_LOG"
echo "Total Live Hosts    : $TOTAL_LIVE" | tee -a "$PROGRESS_LOG"
echo "Log Error tersimpan di: $ERROR_LOG" | tee -a "$PROGRESS_LOG"
echo "===============================================" | tee -a "$PROGRESS_LOG"
