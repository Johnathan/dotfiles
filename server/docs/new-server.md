# New Server Setup

## 1. Create Server (Manual)

Create in Hetzner Cloud console:
- Location: Choose based on latency needs
- Image: Ubuntu 24.04
- Type: CX22 or similar
- SSH key: Add your key
- Name: Something memorable

## 2. Initial SSH

```bash
ssh root@<ip>
```

## 3. Clone Dotfiles

```bash
cd ~
git clone https://github.com/yourusername/dotfiles.git
cd dotfiles
```

## 4. Run Install Scripts

```bash
# Install user configs (zsh, tmux, nvim)
./install.sh bootstrap
./install.sh

# Install server packages and tools
./server.sh bootstrap
```

## 5. Configure Secrets

Add to `~/.secrets`:

```bash
export HCLOUD_TOKEN='your-token-here'
export CF_API_TOKEN='your-token-here'
```

Then reload:

```bash
source ~/.zshrc
```

## 6. Setup Firewall

```bash
./server.sh firewall setup

# Apply to this server
hcloud firewall apply-to-resource default --type server --server <server-name>
```

## 7. Verify Tools

```bash
hcloud server list
flarectl zone list
```

## 8. Add First Site

See [new-domain.md](new-domain.md) for adding domains.

## Checklist

- [ ] Server created in Hetzner
- [ ] SSH access working
- [ ] Dotfiles cloned
- [ ] `./install.sh bootstrap && ./install.sh` completed
- [ ] `./server.sh bootstrap` completed
- [ ] Secrets configured in `~/.secrets`
- [ ] Firewall created and applied
- [ ] Tools verified working
