# package
sudo yum install -y epel-release
sudo yum install -y git zsh the_silver_searcher tree psmisc htop iotop iftop dstat ctags net-tools wget bzip2 unzip p7zip autoconf automake libtool gcc-c++ ncurses-devel python-devel zlib-devel bzip2-devel libquadmath-devel libevent-devel tcl

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
