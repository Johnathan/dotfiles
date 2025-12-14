# dotfiles

## Fresh Mac Setup

```bash
xcode-select --install
git clone git@github.com:Johnathan/dotfiles.git ~/dotfiles
cd ~/dotfiles
make bootstrap
make install
```

## Existing Mac

```bash
cd ~/dotfiles
make install
```

## What it does

### bootstrap
- Installs Homebrew (if missing)
- Installs Prezto (if missing)
- Installs VS Code and tmux via Homebrew

### install
- **tmux**: Symlinks `.tmux.conf`, installs TPM and plugins
- **zsh**: Symlinks `.zshrc`
- **vim**: Symlinks `.vimrc`
- **vscode**: Symlinks settings/keybindings, installs extensions

## Individual targets

```bash
make bootstrap  # fresh mac prerequisites
make install    # all configs
make tmux       # just tmux
make zsh        # just zsh
make vim        # just vim
make vscode     # just vscode
```

## Secrets

API keys and machine-specific config go in `~/.secrets` (not in repo):

```bash
echo 'export OPENAI_API_KEY="your-key"' > ~/.secrets
chmod 600 ~/.secrets
```
