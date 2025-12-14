.PHONY: install bootstrap tmux tpm zsh vim vscode

VSCODE_DIR := $(HOME)/Library/Application Support/Code/User

install: tmux zsh vim vscode

# Bootstrap a fresh Mac (run once before install)
bootstrap: homebrew prezto
	brew install --cask visual-studio-code
	brew install tmux
	@echo "Bootstrap complete. Run 'make install' next."

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
	ln -sf $(CURDIR)/.tmux.conf $(HOME)/.tmux.conf
	~/.tmux/plugins/tpm/bin/install_plugins

# Install TPM if not present
tpm:
	@if [ ! -d "$(HOME)/.tmux/plugins/tpm" ]; then \
		echo "Installing TPM..."; \
		git clone https://github.com/tmux-plugins/tpm $(HOME)/.tmux/plugins/tpm; \
	fi

# Zsh setup
zsh:
	ln -sf $(CURDIR)/.zshrc $(HOME)/.zshrc

# Vim setup
vim:
	ln -sf $(CURDIR)/.vimrc $(HOME)/.vimrc

# VS Code setup
vscode:
	ln -sf "$(CURDIR)/vscode/settings.json" "$(VSCODE_DIR)/settings.json"
	ln -sf "$(CURDIR)/vscode/keybindings.json" "$(VSCODE_DIR)/keybindings.json"
	@echo "Installing VS Code extensions..."
	@cat $(CURDIR)/vscode/extensions.txt | xargs -L 1 code --install-extension
