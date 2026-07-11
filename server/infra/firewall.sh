#!/bin/bash
# Hetzner Cloud firewall wrapper

FIREWALL_NAME="default"

check_hcloud() {
    if ! command -v hcloud &>/dev/null; then
        echo "❌ hcloud not found. Run ./server.sh tools first"
        exit 1
    fi

    if [[ -z "$HCLOUD_TOKEN" ]]; then
        echo "❌ HCLOUD_TOKEN not set. Add to ~/.secrets"
        exit 1
    fi
}

firewall_setup() {
    check_hcloud

    # Check if firewall exists
    if hcloud firewall describe "$FIREWALL_NAME" &>/dev/null; then
        echo "✓ Firewall '$FIREWALL_NAME' already exists"
        firewall_status
        return
    fi

    echo "Creating firewall '$FIREWALL_NAME'..."

    hcloud firewall create --name "$FIREWALL_NAME"

    # SSH
    hcloud firewall add-rule "$FIREWALL_NAME" \
        --direction in \
        --protocol tcp \
        --port 22 \
        --source-ips 0.0.0.0/0 \
        --source-ips ::/0 \
        --description "SSH"

    # HTTP
    hcloud firewall add-rule "$FIREWALL_NAME" \
        --direction in \
        --protocol tcp \
        --port 80 \
        --source-ips 0.0.0.0/0 \
        --source-ips ::/0 \
        --description "HTTP"

    # HTTPS
    hcloud firewall add-rule "$FIREWALL_NAME" \
        --direction in \
        --protocol tcp \
        --port 443 \
        --source-ips 0.0.0.0/0 \
        --source-ips ::/0 \
        --description "HTTPS"

    # Mosh (UDP 60000-61000)
    hcloud firewall add-rule "$FIREWALL_NAME" \
        --direction in \
        --protocol udp \
        --port 60000-61000 \
        --source-ips 0.0.0.0/0 \
        --source-ips ::/0 \
        --description "Mosh"

    echo "✅ Firewall created"
    echo "📋 Manual steps:"
    echo "   👉 Apply to server: hcloud firewall apply-to-resource $FIREWALL_NAME --type server --server <server-name>"
}

firewall_status() {
    check_hcloud

    echo "Firewall rules for '$FIREWALL_NAME':"
    hcloud firewall describe "$FIREWALL_NAME" -o format='{{range .Rules}}{{.Direction}} {{.Protocol}} {{.Port}} {{.Description}}{{"\n"}}{{end}}'
}

firewall_open() {
    local port="$1"
    local protocol="${2:-tcp}"

    check_hcloud

    echo "Adding rule: $protocol/$port..."

    hcloud firewall add-rule "$FIREWALL_NAME" \
        --direction in \
        --protocol "$protocol" \
        --port "$port" \
        --source-ips 0.0.0.0/0 \
        --source-ips ::/0 \
        --description "Custom $protocol/$port"

    echo "✅ Rule added"
}
