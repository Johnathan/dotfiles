dotfiles. symlink them. or whatever.

```
brew install reattach-to-user-namespace
cd ~
git clone git@github.com:Johnathan/dotfiles.git
ln -s ~/dotfiles/.vimrc ~/
ln -s ~/dotfiles/.zshrc ~/
ln -s ~/dotfiles/.tmux.conf ~/
source ~/.zshrc
```
