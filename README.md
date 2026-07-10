
# Project 2: AWS Infrastructure and Nginx Deployment Playbook

This repository contains the automation scripts and configuration steps to set up a cloud server and deploy an Nginx web application.

---

## Repository Structure

```text
├── Evidence/          # Deployment screenshots and verifications
├── README.md          # Project documentation and playbook
├── install.sh         # Automated bash script for Nginx setup
└── logs.txt           # Output logs from system package updates and installations

```
<img width="1536" height="1024" alt="ChatGPT Image Jul 9, 2026, 03_09_10 PM" src="https://github.com/user-attachments/assets/d2193f9d-d2a6-4331-bb34-1a22cf162eac" />

---

## 1. Cloud Provisioning (AWS EC2)

Follow these exact settings to launch the remote server:

* **Instance Name:** server-commander-01
* **Operating System:** Amazon Linux (Select Amazon Linux 2023 AMI from Quick Starts)
* **Instance Type:** t2.micro
* **Storage:** 8 GiB root volume

### Network and Security Rules

Create a new security group with these exact inbound firewall settings:

* **SSH (Port 22):** Source set to **My IP** (Restricts system access to your IP only)
* **HTTP (Port 80):** Source set to **Anywhere-IPv4** (0.0.0.0/0)
* **HTTPS (Port 443):** Source set to **Anywhere-IPv4** (0.0.0.0/0)

### Key Pair Generation

1. Create a new key pair during launch named `server-commander-key`.
2. Select **RSA** type and **.pem** format.
3. Save the downloaded private key file safely on your local computer.

---

## 2. Secure Remote Access

1. Go to your AWS console, select **server-commander-01**, and click **Connect** at the top.
2. Under the **SSH client** tab, copy your unique instance connection string.
3. Open your local terminal, go to your `.pem` key folder, and run:

```bash
# Secure your private key permissions
chmod 400 server-commander-key.pem

# Connect to the remote server
ssh -i "server-commander-key.pem" ec2-user@your-instance-public-dns

```

---

## 3. Automated Configuration Script

Once inside the server, the deployment is managed via `install.sh`.

### Script Implementation

If you clone this repository, the script is already present. If you create it manually on a new server, open a text editor like `vim install.sh` or `nano install.sh` and add this exact configuration feel free to modify:

```bash
#!/bin/bash

set -eo pipefail

echo "Updating Packages"
echo "================="
sudo dnf update -y >> logs.txt

echo "Update completed. Installing and Starting Nginx..."
echo "=================================================="
sudo dnf install nginx -y >> logs.txt
sudo systemctl enable --now nginx >> logs.txt

echo "Nginx installed. Creating the web Page..."
echo "========================================"
sudo tee /usr/share/nginx/html/index.html > /dev/null << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>Project:2 with DecodeLabs</title>
</head>
<body>
    <h1>Welcome to DecodeLabs: Mission Accomplished</h1>
    <h2>Kingsley and DecodeLabs to Everyone.</h2>
</body>
</html>
EOF

echo "Nginx Edit completed. Checking the site..."
echo "=========================================="
curl -s http://localhost

echo ""
echo "Verification complete: site is up and running!"

```

### Execution

Run these commands to make the script executable and run it:

```bash
chmod +x install.sh
./install.sh

```

---

## 4. Verification

* **Log Verification:** The script sends installation text directly into `logs.txt` to keep a clean history in your repository.
* **Browser Test:** Open your browser and go to the public address of your server:

```text
[http://ec2-3-85-104-167.compute-1.amazonaws.com](http://Your Public DNS)

```

The browser will display the landing message confirming that your infrastructure is successfully live.
