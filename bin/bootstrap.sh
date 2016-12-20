# package
sudo yum install -y epel-release git zsh the_silver_searcher tree psmisc htop iotop iftop dstat ctags net-tools wget bzip2 unzip p7zip autoconf automake libtool gcc-c++ ncurses-devel python-devel zlib-devel bzip2-devel libquadmath-devel libevent-devel

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

# dir
#mkdir -p ~/code
#mkdir -p ~/repo

# dotfiles
#git clone https://github.com/pass86/dotfiles.git ~
#ln -s ~/dotfiles/.vimrc ~/.vimrc
#ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
#rm ~/dotfiles/.bash_profile
#ln -s ~/dotfiles/.bash_profile ~/.bash_profile

# vimwiki
#git clone https://github.com/pass86/vimwiki.git ~

# vim
#git clone https://github.com/vim/vim.git ~/code
#cd ~/code/vim
#./configure --enable-pythoninterp=yes --without-python-config-dir
#make
#sudo make install

# tmux
#git clone https://github.com/tmux/tmux.git ~/code
#cd ~/code/tmux
#./autogen.sh
#./configure 
#make
#sudo make install

# plugin
#cd ~/dotfiles
#./bin/update.sh
#git submodule update --init --recursive

# ycm
#cd ~/dotfiles/vim/bundle/YouCompleteMe
#./install.py --clang-completer

# oh my zsh
#sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
#git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins
