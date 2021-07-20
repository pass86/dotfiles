# Dotfiles
Workspace settings

# Setup macOS
* Install [Homebrew](https://brew.sh)

* Install [Oh My Zsh](https://github.com/robbyrussell/oh-my-zsh)

* Install Tools
```sh
brew install tmux ctags the_silver_searcher reattach-to-user-namespace htop pstree git-lfs
```

# Install dotfiles
```sh
git clone https://github.com/pass86/dotfiles.git ~/dotfiles
```

* macOS & Linux
```sh
~/dotfiles/bin/install.sh
```

* Windows
```bat
%USERPROFILE%\dotfiles\bin\install.bat
```

# Install Submodules
```sh
cd ~/dotfiles && ./bin/submodules_init.sh
```

# Install [YouCompleteMe](https://github.com/Valloric/YouCompleteMe)
```sh
cd ~/dotfiles && ./bin/ycm_init.sh
```
