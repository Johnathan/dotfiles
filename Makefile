.PHONY: install bootstrap tmux tpm zsh vim vscode

VSCODE_DIR := $(HOME)/Library/Application Support/Code/User

install: tmux zsh vim vscode
	@echo ""
	@echo "✅ Install complete!"
	@echo ""

# Bootstrap a fresh Mac (run once before install)
bootstrap: homebrew prezto
	brew install --cask visual-studio-code
	brew install --cask font-meslo-lg-nerd-font
	brew install tmux
	brew install powerlevel10k
	@echo ""
	@echo "✅ Bootstrap complete!"
	@echo ""
	@echo "📋 Manual steps:"
	@echo "   👉 iTerm2: Preferences → Profiles → Text → Font → MesloLGS Nerd Font"
	@echo "   👉 Run 'make install' to symlink configs"
	@echo ""

homebrew:
	@if ! command -v brew &> /dev/null; then \
		echo "Installing Homebrew..."; \
		/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
	else \
		echo "Homebrew already installed"; \
	fi

prezto:
	@if [ ! -d "$(HOME)/.zprezto" ]; then \
		echo "Installing Prezto..."; \
		git clone --recursive https://github.com/sorin-ionescu/prezto.git "$(HOME)/.zprezto"; \
	else \
		echo "Prezto already installed"; \
	fi

# Tmux setup
tmux: tpm
	ln -sf $(CURDIR)/tmux/.tmux.conf $(HOME)/.tmux.conf
	~/.tmux/plugins/tpm/bin/install_plugins
	@echo ""
	@echo "✅ tmux configured"
	@echo ""
	@echo "📋 Manual steps:"
	@echo "   👉 Reload config: prefix + r (or tmux source-file ~/.tmux.conf)"
	@echo ""

# Install TPM if not present
tpm:
	@if [ ! -d "$(HOME)/.tmux/plugins/tpm" ]; then \
		echo "Installing TPM..."; \
		git clone https://github.com/tmux-plugins/tpm $(HOME)/.tmux/plugins/tpm; \
	fi

# Zsh setup
zsh:
	ln -sf $(CURDIR)/.zshrc $(HOME)/.zshrc
	@if [ -f "$(CURDIR)/.p10k.zsh" ]; then \
		ln -sf $(CURDIR)/.p10k.zsh $(HOME)/.p10k.zsh; \
	fi
	@echo ""
	@echo "✅ zsh configured"
	@echo ""
	@echo "📋 Manual steps:"
	@echo "   👉 Reload: source ~/.zshrc (or open new terminal)"
	@echo ""

# Vim setup
vim:
	ln -sf $(CURDIR)/.vimrc $(HOME)/.vimrc
	@echo ""
	@echo "✅ vim configured"
	@echo ""

# VS Code setup
vscode:
	ln -sf "$(CURDIR)/vscode/settings.json" "$(VSCODE_DIR)/settings.json"
	ln -sf "$(CURDIR)/vscode/keybindings.json" "$(VSCODE_DIR)/keybindings.json"
	@echo "Installing VS Code extensions..."
	@cat $(CURDIR)/vscode/extensions.txt | xargs -L 1 code --install-extension
	@echo ""
	@echo "✅ VS Code configured"
	@echo ""
	@echo "📋 Manual steps:"
	@echo "   👉 Restart VS Code to apply settings"
	@echo ""
