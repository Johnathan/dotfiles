#!/bin/bash
# CLI tools installation via go install

GO_BIN="/usr/local/go/bin/go"

install_hcloud() {
    if command -v hcloud &>/dev/null; then
        echo "✓ hcloud already installed"
        return
    fi

    echo "Installing hcloud..."

    if [[ ! -x "$GO_BIN" ]]; then
        echo "❌ Go not found. Run ./server.sh packages first"
        exit 1
    fi

    $GO_BIN install github.com/hetznercloud/cli/cmd/hcloud@latest

    # Symlink to /usr/local/bin
    sudo ln -sf "$HOME/go/bin/hcloud" /usr/local/bin/hcloud

    echo "✅ hcloud installed"
}

install_flarectl() {
    if command -v flarectl &>/dev/null; then
        echo "✓ flarectl already installed"
        return
    fi

    echo "Installing flarectl..."

    if [[ ! -x "$GO_BIN" ]]; then
        echo "❌ Go not found. Run ./server.sh packages first"
        exit 1
    fi

    $GO_BIN install github.com/cloudflare/cloudflare-go/cmd/flarectl@latest

    # Symlink to /usr/local/bin
    sudo ln -sf "$HOME/go/bin/flarectl" /usr/local/bin/flarectl

    echo "✅ flarectl installed"
}
