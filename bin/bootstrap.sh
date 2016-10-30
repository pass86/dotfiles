# package
yum install -y git zsh tmux psmisc net-tools wget bzip2 unzip autoconf automake libtool gcc-c++ ncurses-devel python-devel zlib-devel bzip2-devel libquadmath-devel

# dotfiles
cd ~
git clone https://github.com/pass86/dotfiles.git
ln -s ~/dotfiles/.vimrc ~/.vimrc
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf

# oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
cd ~/.oh-my-zsh/custom/plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git

# dir
cd ~
mkdir code
mkdir repo

# vim
cd ~/code
git clone https://github.com/vim/vim.git
cd vim
./configure --enable-pythoninterp=yes --without-python-config-dir
make
sudo make install

# plugin
cd ~/dotfiles
git submodule update --init --recursive

# ycm
cd ~/dotfiles/vim/bundle/YouCompleteMe
./install.py --clang-completer

# finish
cd ~
