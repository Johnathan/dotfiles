#!/bin/bash
set -e

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

# Detect OS
case "$(uname -s)" in
    Darwin) OS="macos" ;;
    Linux)  OS="linux" ;;
    *)      echo "Unsupported OS"; exit 1 ;;
esac

# Helper to create symlink (removes existing file/link first)
link() {
    local src="$1"
    local dest="$2"
    rm -rf "$dest"
    ln -sf "$src" "$dest"
    echo "  Linked $dest"
}

# Bootstrap a fresh machine
bootstrap() {
    if [[ "$OS" == "macos" ]]; then
        bootstrap_macos
    else
        bootstrap_linux
    fi
}

bootstrap_macos() {
    # Homebrew
    if ! command -v brew &> /dev/null; then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
        echo "Homebrew already installed"
    fi

    # Prezto
    install_prezto

    # Packages
    brew install tmux
    brew install neovim
    brew install fzf
    brew install powerlevel10k
    brew install --cask font-meslo-lg-nerd-font

    echo ""
    echo "✅ Bootstrap complete!"
    echo ""
    echo "📋 Manual steps:"
    echo "   👉 iTerm2/Kitty: Set font to MesloLGS Nerd Font"
    echo "   👉 Run './install.sh' to symlink configs"
    echo ""
}

bootstrap_linux() {
    echo "Updating apt..."
    sudo apt update

    # Packages
    sudo apt install -y tmux neovim fzf zsh git curl

    # Prezto
    install_prezto

    # Powerlevel10k
    if [ ! -d "$HOME/.powerlevel10k" ]; then
        echo "Installing Powerlevel10k..."
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/.powerlevel10k"
    else
        echo "Powerlevel10k already installed"
    fi

    # Nerd Font
    install_nerd_font_linux

    # Set zsh as default shell
    if [[ "$SHELL" != *"zsh"* ]]; then
        echo "Setting zsh as default shell..."
        sudo chsh -s "$(which zsh)" "$USER"
    fi

    echo ""
    echo "✅ Bootstrap complete!"
    echo ""
    echo "📋 Manual steps:"
    echo "   👉 Set terminal font to MesloLGS Nerd Font"
    echo "   👉 Run './install.sh' to symlink configs"
    echo "   👉 Log out and back in for shell change to take effect"
    echo ""
}

install_prezto() {
    if [ ! -d "$HOME/.zprezto" ]; then
        echo "Installing Prezto..."
        git clone --recursive https://github.com/sorin-ionescu/prezto.git "$HOME/.zprezto"
    else
        echo "Prezto already installed"
    fi
}

install_nerd_font_linux() {
    local font_dir="$HOME/.local/share/fonts"
    if [ ! -f "$font_dir/MesloLGSNerdFont-Regular.ttf" ]; then
        echo "Installing MesloLGS Nerd Font..."
        mkdir -p "$font_dir"
        cd "$font_dir"
        curl -fLO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Meslo.tar.xz
        tar -xf Meslo.tar.xz
        rm Meslo.tar.xz
        fc-cache -fv
        cd - > /dev/null
    else
        echo "Nerd Font already installed"
    fi
}

install_tmux() {
    # TPM
    if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
        echo "Installing TPM..."
        git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
    fi

    link "$DOTFILES/tmux/.tmux.conf" "$HOME/.tmux.conf"

    echo ""
    echo "✅ tmux configured"
    echo ""
    echo "📋 Manual steps:"
    echo "   👉 Open tmux and press prefix + I to install plugins"
    echo ""
}

install_zsh() {
    link "$DOTFILES/.zshrc" "$HOME/.zshrc"
    if [ -f "$DOTFILES/.p10k.zsh" ]; then
        link "$DOTFILES/.p10k.zsh" "$HOME/.p10k.zsh"
    fi

    echo ""
    echo "✅ zsh configured"
    echo ""
    echo "📋 Manual steps:"
    echo "   👉 Reload: source ~/.zshrc (or open new terminal)"
    echo ""
}

install_nvim() {
    mkdir -p "$HOME/.config"
    link "$DOTFILES/nvim" "$HOME/.config/nvim"

    echo ""
    echo "✅ neovim configured"
    echo ""
}

install_all() {
    install_tmux
    install_zsh
    install_nvim

    echo ""
    echo "✅ Install complete!"
    echo ""
}

# Main
case "${1:-install}" in
    bootstrap)
        bootstrap
        ;;
    tmux)
        install_tmux
        ;;
    zsh)
        install_zsh
        ;;
    nvim)
        install_nvim
        ;;
    install|"")
        install_all
        ;;
    *)
        echo "Usage: $0 {bootstrap|install|tmux|zsh|nvim}"
        exit 1
        ;;
esac
