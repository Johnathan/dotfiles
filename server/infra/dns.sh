#!/bin/bash
# Cloudflare DNS wrapper using flarectl

check_flarectl() {
    if ! command -v flarectl &>/dev/null; then
        echo "❌ flarectl not found. Run ./server.sh tools first"
        exit 1
    fi

    if [[ -z "$CF_API_TOKEN" ]]; then
        echo "❌ CF_API_TOKEN not set. Add to ~/.secrets"
        exit 1
    fi
}

dns_list() {
    local zone="$1"

    check_flarectl

    echo "DNS records for $zone:"
    flarectl dns list --zone "$zone"
}

dns_add() {
    local zone="$1"
    local name="$2"
    local ip="$3"

    check_flarectl

    echo "Adding A record: $name.$zone -> $ip"

    flarectl dns create \
        --zone "$zone" \
        --name "$name" \
        --type A \
        --content "$ip" \
        --proxy=false

    echo "✅ DNS record added"
    echo "   👉 DNS propagation may take a few minutes"
}

dns_delete() {
    local zone="$1"
    local record_id="$2"

    check_flarectl

    echo "Deleting record $record_id from $zone..."

    flarectl dns delete --zone "$zone" --id "$record_id"

    echo "✅ DNS record deleted"
}
