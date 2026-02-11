# Recon Automation by Satria

A streamlined Bash automation script designed for efficient subdomain reconnaissance and live host validation. This project is built to optimize the reconnaissance workflow for bug bounty hunters and penetration testers.

## ✨ Features
- **Automated Subdomain Enumeration**: Leveraging `subfinder` to discover subdomains from multiple sources.
- **Smart Deduplication**: Integrating `anew` to ensure clean, unique data in the final output.
- **Enhanced Live Probing**: Uses `httpx` with professional formatting:
  - Validates active HTTP/HTTPS hosts.
  - Displays **Status Codes**, and **Page Titles**.
- **Real-time Monitoring**: Uses `tee` for simultaneous terminal display and logging.
- **Precise Timestamping**: Every process is recorded with accurate timestamps for better audit trails.

## 🛠️ Environment Setup

Designed for **Kali Linux** or other Debian-based distributions. This project uses `pdtm` to manage ProjectDiscovery tools.

### 1. Install pdtm & Dependencies
```bash
# Install pdtm
go install -v [github.com/projectdiscovery/pdtm/cmd/pdtm@latest](https://github.com/projectdiscovery/pdtm/cmd/pdtm@latest)

# Install required tools via pdtm
pdtm -install subfinder
pdtm -install httpx

# Install anew
sudo apt install anew -y
```

## 🚀 Usage Guide
Run the script from the terminal using the following command:
```bash
# change directory to scripts (optional, based on your directory)
cd scripts/

# Grant execution permissions to the script
chmod +x recon-auto.sh

# Run the script
./recon-auto.sh
```

## Input dan Output Preview
```bash
# Input
google.com
yahoo.com

# Output
https://facebook.com [301] [0] [HSTS,HTTP/3]
https://0-edge-chat-latest.facebook.com [301] [0] [HSTS,HTTP/3]
https://tesla.com [403] [359] [HSTS]
```

## 📂 Directory Structure
- input/: Contains domains.txt (target list).

- scripts/: Core automation logic.

- output/: Scan results (all-subdomains.txt and live.txt).

- logs/: Detailed execution logs and history.

## ⚙️ Workflow Explained
1. Subfinder: Scans all subdomains based on the list in input/domains.txt.

2. Anew: Cleans the data by removing duplicates before saving to output/all-subdomains.txt.

3. Httpx: Probes discovered subdomains for live status, extracting page titles and status codes for better analysis.

4. Logging: All events and errors are captured in the logs/ directory for debugging.

## 📊 Execution Results
Console Process:
<p align="center">
 <img width="500" height="102" alt="image" src="https://github.com/user-attachments/assets/cf6793ac-6bcf-4d27-b3c3-87120ed93272" />
  <br>
</p>
Live Hosts Output (Final Result):
<p align="center">
 <img width="500" height="82" alt="image" src="https://github.com/user-attachments/assets/eb461299-13a6-4907-9ca3-b3be0d23d51b" />
  <br>
</p>

## ⚠️ Disclaimer
This tool is developed for educational and ethical security testing purposes only. Using this script against targets without prior formal authorization is illegal. The author holds no responsibility for any misuse, unintended consequences, or damage caused by this tool.

---
<p align="center">
  <i>Created with passion for Cybersecurity.</i>
</p>
