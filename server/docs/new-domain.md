# Adding a New Domain/Subdomain

## 1. Add DNS Record

```bash
# Get server IP
ip addr show eth0 | grep 'inet ' | awk '{print $2}' | cut -d/ -f1

# Add A record
./server.sh dns add example.com subdomain <ip>

# Or for apex domain
./server.sh dns add example.com @ <ip>
```

## 2. Create Caddy Site Config

```bash
# Add site configuration
./server.sh caddy add subdomain.example.com 3000
```

This creates `/etc/caddy/sites/subdomain.example.com.caddy`:

```
subdomain.example.com {
    reverse_proxy localhost:3000
}
```

## 3. Reload Caddy

```bash
sudo systemctl reload caddy
```

## 4. Verify SSL

```bash
# Check Caddy logs for certificate provisioning
sudo journalctl -u caddy -f

# Test HTTPS
curl -I https://subdomain.example.com
```

## Custom Configurations

For more complex setups, edit the site file directly:

```bash
sudo vim /etc/caddy/sites/subdomain.example.com.caddy
```

Example with additional options:

```
subdomain.example.com {
    reverse_proxy localhost:3000 {
        header_up Host {host}
        header_up X-Real-IP {remote_host}
    }

    encode gzip

    log {
        output file /var/log/caddy/subdomain.example.com.log
    }
}
```

## Checklist

- [ ] DNS record added
- [ ] Caddy site config created
- [ ] Caddy reloaded
- [ ] SSL certificate provisioned
- [ ] Site accessible via HTTPS
