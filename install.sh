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
curl -s http://ec2-3-85-104-167.compute-1.amazonaws.com

echo ""
echo "Verification complete: site is up and running!"
