#  Mawari Guardian Node Setup

This repository provides a single script to install Docker (if needed) and run a **Mawari Guardian Node** in detached mode.  
It will automatically display your **burner wallet address** so you can delegate your Guardian NFT.

---

###  Requirements
- Ubuntu 20.04+ (or Debian-based Linux)
- Bash
- A Guardian NFT in your **OWNER wallet**

---

###  Quick Start

Run this command in your terminal :

```bash
bash <(curl -s https://raw.githubusercontent.com/AVAERIS/Mawari-Node/main/setup.sh)
```

You will be asked to enter your **OWNER wallet address**.  
Once the node starts, the script will print your **burner wallet address**.

---

###  Claim Testnet Tokens

Before delegating, make sure you have tokens and NFTs:

- **Claim Mawari testnet tokens**  
  👉 [Faucet](https://faucet.mawari.network)

- **Mint Guardian NFTs (maximum 3 per wallet)**  
  👉 [Mint NFT](https://mint.mawari.network)

- **Fund your burner wallet (shown after running the script)**  
  Send at least **1 testnet tokens** to your burner wallet so it has gas for delegation.

---

###  Burner Wallet

Example output after running the script:

```yaml
🔥 Burner wallet:
👉 0xDc57529b066B21E6b296b9156CFc3496d8cddFDB
```

###  Delegate 
Use this burner wallet address in the Mawari Guardian [Dashboard](https://app.testnet.mawari.net) to delegate your NFT.

###  Burner Wallet Private Key

The private key of your burner wallet is stored locally on your server.
You can find it inside the mawari folder, in the file:

```
mawari/flohive-cache.json
```

⚠️ Important:

Do not share this file with anyone.

Backup the file securely if you plan to migrate or restore your node.

Anyone with access to flohive-cache.json can control your burner wallet.


