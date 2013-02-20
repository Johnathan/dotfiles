My dotfiles currently for tmux, zsh and Vim, I like them. Use them if you want, just take bits and pieces or fix them for me if you like.
There's a few dependencies such as having ruby, python and brew installed on your system. Let me know on twitter @johnathan1707 if you have any issues.

`brew install zsh`

`curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh`

`brew install tmux`

`brew install reattach-to-user-namespace`

`cd ~`

`git clone git://github.com/Johnathan/dotfiles.git`

`ln -s ~/dotfiles/tmux/tmux.conf ~/.tmux.conf`

`ln -s ~/dotfiles/zsh/.oh-my-zsh ~/.oh-my-zsh`

`ln -s ~/dotfiles/zsh/.zshrc ~/.zshrc`

`ln -s ~/dotfiles/vim ~/.vim`

`ln -s ~/dotfiles/vim/.vimrc ~/.vimrc`

`cd ~/.vim/bundle/command-t/ruby/command-t/`

`ruby extconf.rb`

`make`

`mkdir ycm_temp`

`cd ycm_temp`

`curl -O http://llvm.org/releases/3.2/clang+llvm-3.2-x86_64-apple-darwin11.tar.gz`

`tar -zxvf clang+llvm-3.2-x86_64-apple-darwin11.tar.gz`

`cp clang+llvm-3.2-x86_64-apple-darwin11/lib/libclang.dylib ~/.vim/bundle/YouCompleteMe/python`

`cd ~`

`mkdir ycm_build`

`cd ycm_build`

`cmake -G "Unix Makefiles" -DPATH_TO_LLVM_ROOT=~/ycm_temp/clang+llvm-3.2-x86_64-apple-darwin11 . ~/.vim/bundle/YouCompleteMe/cpp`

`make ycm_core`
