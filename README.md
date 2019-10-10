# Dotfiles
Workspace settings

# Setup macOS
* Install [Homebrew](https://brew.sh)
```sh
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```
* Install [Oh My Zsh](https://github.com/robbyrussell/oh-my-zsh)
```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```
* Install tools
```sh
brew install vim tmux ctags the_silver_searcher reattach-to-user-namespace
brew cask install macvim alacritty
```

# Setup Windows
* Install [babun](https://babun.github.io)
* Update babun
```bat
%USERPROFILE%\.babun\update.bat
```
* Install tools
```sh
pact install ctags the_silver_searcher
```

# Install dotfiles
```sh
git clone https://github.com/pass86/dotfiles.git
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
~/dotfiles/bin/submodules_init.sh
```

# Install [YouCompleteMe](https://github.com/Valloric/YouCompleteMe)
```sh
~/dotfiles/bin/ycm_init.sh
```
