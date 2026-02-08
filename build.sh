#!/bin/bash
TOKEN="Personal access tokens (classic)" 
Yourname="di3n0"
IMAGE_NAME="ghcr.io/di3n0/intranet-scan"
TAG="latest"

echo "[*] Building Docker Image: $IMAGE_NAME:$TAG"
docker build -t $IMAGE_NAME:$TAG .

if [ $? -eq 0 ]; then
    echo "[+] Build successful!"
    echo "[*] To push to GHCR, first login:"
    echo "   echo $TOKEN | docker login ghcr.io -u $Yourname --password-stdin"
    echo "[*] Then push:"
    echo "    docker push $IMAGE_NAME:$TAG"
else
    echo "[-] Build failed."
    exit 1
fi
