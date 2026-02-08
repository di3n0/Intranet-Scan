# Intranet-Scan

A lightweight, high-performance reconnaissance container designed for internal network scanning and web asset discovery. This project packs the "Golden Quartet" of security tools into a single, portable Ubuntu-based environment.

## Overview

`Intranet-Scan` simplifies the reconnaissance phase of penetration testing. Instead of managing multiple tool dependencies on your host machine, you can run this container anywhere to perform port scanning, web probing, and directory fuzzing.

## Included Tools

| Tool | Purpose | Source |
| --- | --- | --- |
| **Nmap** | Infrastructure & Port Scanning | [nmap.org](https://nmap.org/) |
| **httpx** | Fast & Multi-purpose HTTP Toolkit | [projectdiscovery](https://github.com/projectdiscovery/httpx) |
| **ffuf** | Fast Web Fuzzer (Go-based) | [ffuf/ffuf](https://github.com/ffuf/ffuf) |
| **dirsearch** | Advanced Web Path Scanner | [maurosoria/dirsearch](https://github.com/maurosoria/dirsearch) |

---

## Getting Started

### 1. Build the Image

You can use the provided build script or run the Docker command manually:

```bash
# Using the script
chmod +x build.sh
./build.sh

# Or manual build
docker build -t ghcr.io/di3n0/intranet-scan:latest .

```

### 2. Deployment to GHCR

To push the image to GitHub Container Registry, ensure you have a **Personal Access Token (PAT)** with `write:packages` permissions.

```bash
# Login to GHCR
echo $CR_PAT | docker login ghcr.io -u di3n0 --password-stdin

# Push the image
docker push ghcr.io/di3n0/intranet-scan:latest

```

---

## 📖 Usage Examples

Run the container interactively and mount a local directory to save your scan results:

```bash
docker run --rm -it \
  -v $(pwd)/results:/scan \
  ghcr.io/di3n0/intranet-scan:latest

```

### Typical Workflow

1. **Port Scanning (Nmap)**
Find live hosts and open ports:
```bash
nmap -sV -p- --open -iL targets.txt -oG nmap_results.txt

```


2. **Web Probing (httpx)**
Filter Nmap results to find active web services:
```bash
cat nmap_results.txt | httpx -title -status-code -o web_targets.txt

```


3. **Directory Fuzzing (ffuf / dirsearch)**
Discover hidden files and directories:
```bash
# Using ffuf
ffuf -w wordlist.txt -u https://target.com/FUZZ -mc 200

# Using dirsearch
dirsearch -u https://target.com -e php,txt,zip

```



---

## Project Structure

* `Dockerfile`: Multi-stage build for a slim, efficient image.
* `build.sh`: Helper script for tagging and local builds.
* `/scan`: Default workspace inside the container.

