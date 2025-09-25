#!/bin/bash
set -e

echo "Mawari Guardian Node Setup (by AVaeris)"
echo "==========================================="

if ! command -v docker &> /dev/null; then
    echo "[*] Installing Docker..."
    sudo apt-get update -y
    sudo apt-get install -y ca-certificates curl gnupg lsb-release
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update -y
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
    echo "[OK] Docker installed."
else
    echo "[OK] Docker already installed."
fi

read -p "Enter your OWNER wallet address: " OWNER_ADDRESS

IMAGE="us-east4-docker.pkg.dev/mawarinetwork-dev/mwr-net-d-car-uses4-public-docker-registry-e62e/mawari-node:latest"
CONTAINER="mawari-guardian"
mkdir -p ~/mawari

if [ "$(docker ps -aq -f name=$CONTAINER)" ]; then
    docker rm -f $CONTAINER
fi

echo "[*] Starting Mawari Guardian Node..."
docker run -d --pull always \
  --name $CONTAINER \
  -v ~/mawari:/app/cache \
  -e OWNERS_ALLOWLIST=$OWNER_ADDRESS \
  $IMAGE

sleep 5

BURNER=$(docker logs $CONTAINER 2>&1 | grep "Using burner wallet" | tail -n 1 | sed -E 's/.*"address": "(0x[0-9a-fA-F]+)".*/\1/')

echo ""
if [ -n "$BURNER" ]; then
    echo "[INFO] Burner wallet:"
    echo ">>> $BURNER"
    echo "Delegate your Guardian NFT to this address."
else
    echo "[WARN] Burner wallet not found yet. Check manually:"
    echo "   docker logs -f $CONTAINER | grep 'Using burner wallet'"
fi

echo ""
echo "[OK] Node is running in background."
echo "   View logs : docker logs -f $CONTAINER"
echo "   Stop node : docker stop $CONTAINER"
echo "   Start     : docker start $CONTAINER"
echo ""
echo "==========================================="
echo "Setup complete. by AVaeris"
echo "==========================================="
