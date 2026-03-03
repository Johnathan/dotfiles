#!/bin/bash
# System package installation

install_mosh() {
    if command -v mosh &>/dev/null; then
        echo "✓ mosh already installed"
        return
    fi

    echo "Installing mosh..."
    sudo apt-get update
    sudo apt-get install -y mosh
    echo "✅ mosh installed"
}

install_caddy() {
    if command -v caddy &>/dev/null; then
        echo "✓ caddy already installed"
        return
    fi

    echo "Installing caddy..."
    sudo apt-get update
    sudo apt-get install -y debian-keyring debian-archive-keyring apt-transport-https curl
    curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
    curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list
    sudo apt-get update
    sudo apt-get install -y caddy

    # Setup sites directory
    sudo mkdir -p /etc/caddy/sites

    # Install base Caddyfile if not exists
    if [[ ! -f /etc/caddy/Caddyfile.bak ]]; then
        sudo cp /etc/caddy/Caddyfile /etc/caddy/Caddyfile.bak 2>/dev/null || true
    fi
    sudo cp "$SERVER_DIR/caddy/Caddyfile" /etc/caddy/Caddyfile

    sudo systemctl enable caddy
    sudo systemctl restart caddy
    echo "✅ caddy installed"
}

install_docker() {
    if command -v docker &>/dev/null; then
        echo "✓ docker already installed"
        return
    fi

    echo "Installing docker..."
    sudo apt-get update
    sudo apt-get install -y ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
      $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    # Add current user to docker group
    sudo usermod -aG docker "$USER"

    echo "✅ docker installed"
    echo "   👉 Log out and back in for docker group to take effect"
}

install_go() {
    if command -v go &>/dev/null; then
        echo "✓ go already installed"
        return
    fi

    echo "Installing go..."
    local GO_VERSION="1.23.4"
    local GO_ARCH="amd64"

    curl -fsSL "https://go.dev/dl/go${GO_VERSION}.linux-${GO_ARCH}.tar.gz" -o /tmp/go.tar.gz
    sudo rm -rf /usr/local/go
    sudo tar -C /usr/local -xzf /tmp/go.tar.gz
    rm /tmp/go.tar.gz

    echo "✅ go installed"
    echo "   👉 Ensure PATH includes /usr/local/go/bin and ~/go/bin"
}

caddy_add_site() {
    local domain="$1"
    local port="$2"
    local site_file="/etc/caddy/sites/${domain}.caddy"

    if [[ -f "$site_file" ]]; then
        echo "Site config already exists: $site_file"
        echo "Edit manually: sudo vim $site_file"
        return 1
    fi

    echo "Creating Caddy site config for $domain -> localhost:$port"

    sudo tee "$site_file" > /dev/null <<EOF
$domain {
    reverse_proxy localhost:$port
}
EOF

    echo "✅ Site config created: $site_file"
    echo "📋 Manual steps:"
    echo "   👉 Reload Caddy: sudo systemctl reload caddy"
}
