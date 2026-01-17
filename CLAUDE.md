# Dotfiles Project Context

## Platform
- macOS (Apple Silicon) and Ubuntu Linux
- Homebrew on macOS, apt on Ubuntu

## Tools
- **Shell**: zsh with [Prezto](https://github.com/sorin-ionescu/prezto) and [Powerlevel10k](https://github.com/romkatv/powerlevel10k) prompt
- **Terminal multiplexer**: tmux with [TPM](https://github.com/tmux-plugins/tpm)
- **Editor**: neovim
- **Font**: MesloLGS Nerd Font (for prompt icons)

## Philosophy
- Keep configs modern and minimal - remove outdated cruft
- Prefer current best practices over legacy compatibility
- Use plugin managers (TPM for tmux, Prezto for zsh)
- Secrets go in `~/.secrets` (not in repo)
- `install.sh` handles installation and symlinking

## Structure
```
dotfiles/
├── tmux/.tmux.conf # tmux config
├── nvim/           # neovim config
├── .zshrc          # zsh config (uses Prezto + Powerlevel10k)
├── .p10k.zsh       # Powerlevel10k prompt config
├── install.sh      # installation automation
└── README.md
```

## install.sh commands
- `./install.sh bootstrap` - fresh machine setup (brew/apt, prezto, tmux, nvim)
- `./install.sh` - symlink all configs
- Individual: `./install.sh tmux`, `./install.sh zsh`, `./install.sh nvim`

## When updating configs
- Test changes work before committing
- Keep things minimal - don't add features "just in case"
- Remove deprecated options rather than commenting them out
- Use `$HOME` instead of hardcoded paths

## install.sh conventions
- Each command should output manual steps with emojis:
  - ✅ for completion
  - 📋 for "Manual steps:"
  - 👉 for each manual step
- Example:
  ```
  echo "✅ thing configured"
  echo "📋 Manual steps:"
  echo "   👉 Do this thing manually"
  ```
