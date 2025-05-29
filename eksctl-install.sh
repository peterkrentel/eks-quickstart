#!/bin/bash

set -e

echo "Installing eksctl..."

# Download and extract the latest eksctl release
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp

# Move eksctl binary to /usr/local/bin
sudo mv /tmp/eksctl /usr/local/bin

# Verify installation
echo "eksctl version:"
eksctl version

echo "✅ eksctl installation completed successfully."
