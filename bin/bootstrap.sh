# package
sudo yum install -y git zsh tmux psmisc net-tools wget bzip2 unzip autoconf automake libtool gcc-c++ ncurses-devel python-devel zlib-devel bzip2-devel libquadmath-devel

# dir
cd ~
mkdir code
mkdir repo

# git
git config --global user.name pass86
git config --global diff.tool vimdiff
git config --global difftool.prompt false
git config --global merge.tool vimdiff
git config --global core.editor vim
git config --global push.default simple
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status
git config --global alias.last 'log -1 HEAD'
git config --global alias.unstage 'reset HEAD --'

# dotfiles
cd ~
git clone https://github.com/pass86/dotfiles.git
ln -s ~/dotfiles/.vimrc ~/.vimrc
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf

# vim
#cd ~/code
#git clone https://github.com/vim/vim.git
#cd vim
#./configure --enable-pythoninterp=yes --without-python-config-dir
#make
#sudo make install

# plugin
#cd ~/dotfiles
#git submodule update --init --recursive

# ycm
#cd ~/dotfiles/vim/bundle/YouCompleteMe
#./install.py --clang-completer

# oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
#cd ~/.oh-my-zsh/custom/plugins
#git clone https://github.com/zsh-users/zsh-syntax-highlighting.git

# finish
cd ~
