# dotfiles

Cross-platform dotfiles for macOS and Ubuntu.

## Fresh macOS Setup

```bash
xcode-select --install
git clone git@github.com:Johnathan/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh bootstrap
./install.sh
```

## Fresh Ubuntu Setup

```bash
sudo apt install -y git
git clone git@github.com:Johnathan/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh bootstrap
./install.sh
```

## Existing Machine

```bash
cd ~/dotfiles
./install.sh
```

## What it does

### bootstrap
- **macOS**: Installs Homebrew, Prezto, tmux, neovim, fzf, Powerlevel10k, Nerd Font
- **Ubuntu**: Installs packages via apt, clones Prezto and Powerlevel10k, downloads Nerd Font
- Outputs manual steps (e.g. set font, change shell)

### install
- **tmux**: Symlinks `.tmux.conf`, installs TPM and plugins
- **zsh**: Symlinks `.zshrc` and `.p10k.zsh`
- **nvim**: Symlinks `nvim/` to `~/.config/nvim`

## Individual commands

```bash
./install.sh bootstrap  # fresh machine prerequisites
./install.sh            # all configs
./install.sh tmux       # just tmux
./install.sh zsh        # just zsh
./install.sh nvim       # just neovim
```

## Secrets

API keys and machine-specific config go in `~/.secrets` (not in repo):

```bash
echo 'export OPENAI_API_KEY="your-key"' > ~/.secrets
chmod 600 ~/.secrets
```
