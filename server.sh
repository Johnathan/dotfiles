#!/bin/bash
set -e

# Server provisioning - Linux only
if [[ "$(uname)" != "Linux" ]]; then
    echo "❌ This script is for Linux servers only"
    exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SERVER_DIR="$SCRIPT_DIR/server"

source "$SERVER_DIR/packages.sh"
source "$SERVER_DIR/tools.sh"
source "$SERVER_DIR/infra/firewall.sh"
source "$SERVER_DIR/infra/dns.sh"

usage() {
    echo "Usage: ./server.sh <command> [options]"
    echo ""
    echo "Commands:"
    echo "  bootstrap              Full setup: packages + tools"
    echo "  packages               Install system packages (mosh, caddy, docker)"
    echo "  tools                  Install CLI tools (hcloud, flarectl)"
    echo "  caddy add <domain> <port>  Add site to Caddy"
    echo "  firewall setup         Create firewall with default rules"
    echo "  firewall status        Show current rules"
    echo "  firewall open <port> <protocol>  Add rule"
    echo "  dns list <zone>        List DNS records"
    echo "  dns add <zone> <name> <ip>  Add A record"
    echo "  dns delete <zone> <record-id>  Remove record"
}

cmd_bootstrap() {
    echo "🚀 Server bootstrap starting..."
    cmd_packages
    cmd_tools
    echo ""
    echo "✅ Server bootstrap complete"
    echo "📋 Manual steps:"
    echo "   👉 Add tokens to ~/.secrets:"
    echo "      export HCLOUD_TOKEN='xxx'"
    echo "      export CF_API_TOKEN='xxx'"
    echo "   👉 Run: source ~/.zshrc"
}

cmd_packages() {
    install_mosh
    install_caddy
    install_docker
    install_go
}

cmd_tools() {
    install_hcloud
    install_flarectl
}

cmd_caddy() {
    local subcmd="$1"
    shift || true

    case "$subcmd" in
        add)
            local domain="$1"
            local port="$2"
            if [[ -z "$domain" || -z "$port" ]]; then
                echo "Usage: ./server.sh caddy add <domain> <port>"
                exit 1
            fi
            caddy_add_site "$domain" "$port"
            ;;
        *)
            echo "Usage: ./server.sh caddy add <domain> <port>"
            exit 1
            ;;
    esac
}

cmd_firewall() {
    local subcmd="$1"
    shift || true

    case "$subcmd" in
        setup)
            firewall_setup
            ;;
        status)
            firewall_status
            ;;
        open)
            local port="$1"
            local protocol="${2:-tcp}"
            if [[ -z "$port" ]]; then
                echo "Usage: ./server.sh firewall open <port> [protocol]"
                exit 1
            fi
            firewall_open "$port" "$protocol"
            ;;
        *)
            echo "Usage: ./server.sh firewall <setup|status|open>"
            exit 1
            ;;
    esac
}

cmd_dns() {
    local subcmd="$1"
    shift || true

    case "$subcmd" in
        list)
            local zone="$1"
            if [[ -z "$zone" ]]; then
                echo "Usage: ./server.sh dns list <zone>"
                exit 1
            fi
            dns_list "$zone"
            ;;
        add)
            local zone="$1"
            local name="$2"
            local ip="$3"
            if [[ -z "$zone" || -z "$name" || -z "$ip" ]]; then
                echo "Usage: ./server.sh dns add <zone> <name> <ip>"
                exit 1
            fi
            dns_add "$zone" "$name" "$ip"
            ;;
        delete)
            local zone="$1"
            local record_id="$2"
            if [[ -z "$zone" || -z "$record_id" ]]; then
                echo "Usage: ./server.sh dns delete <zone> <record-id>"
                exit 1
            fi
            dns_delete "$zone" "$record_id"
            ;;
        *)
            echo "Usage: ./server.sh dns <list|add|delete>"
            exit 1
            ;;
    esac
}

# Main command routing
case "${1:-}" in
    bootstrap)
        cmd_bootstrap
        ;;
    packages)
        cmd_packages
        ;;
    tools)
        cmd_tools
        ;;
    caddy)
        shift
        cmd_caddy "$@"
        ;;
    firewall)
        shift
        cmd_firewall "$@"
        ;;
    dns)
        shift
        cmd_dns "$@"
        ;;
    -h|--help|"")
        usage
        ;;
    *)
        echo "Unknown command: $1"
        usage
        exit 1
        ;;
esac
