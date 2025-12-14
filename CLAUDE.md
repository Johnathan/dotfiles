# Dotfiles Project Context

## Platform
- macOS (Apple Silicon)
- Homebrew for package management

## Tools
- **Shell**: zsh with [Prezto](https://github.com/sorin-ionescu/prezto)
- **Terminal multiplexer**: tmux with [TPM](https://github.com/tmux-plugins/tpm)
- **Editor**: VS Code with vim extension, planning transition to neovim
- **Vim config**: `.vimrc` - works in vim, neovim, and VS Code vim extension

## Philosophy
- Keep configs modern and minimal - remove outdated cruft
- Prefer current best practices over legacy compatibility
- Use plugin managers (TPM for tmux, Prezto for zsh)
- Secrets go in `~/.secrets` (not in repo)
- Makefile handles installation and symlinking

## Structure
```
dotfiles/
├── .tmux.conf      # tmux config
├── .zshrc          # zsh config (uses Prezto)
├── .vimrc          # vim/neovim config
├── vscode/         # VS Code settings
│   ├── settings.json
│   ├── keybindings.json
│   └── extensions.txt
├── Makefile        # installation automation
└── README.md
```

## Makefile targets
- `make bootstrap` - fresh Mac setup (homebrew, prezto, vscode, tmux)
- `make install` - symlink all configs
- Individual: `make tmux`, `make zsh`, `make vim`, `make vscode`

## When updating configs
- Test changes work before committing
- Keep things minimal - don't add features "just in case"
- Remove deprecated options rather than commenting them out
- Use `$HOME` instead of hardcoded paths
