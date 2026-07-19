# Dotfiles
Workspace settings

# Setup macOS
* Install [Homebrew](https://brew.sh)

* Install [Oh My Zsh](https://github.com/robbyrussell/oh-my-zsh)

* Install Tools
```sh
brew install vim cmake tmux ctags the_silver_searcher reattach-to-user-namespace htop pstree git git-lfs
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

# Install [coc.nvim](https://github.com/neoclide/coc.nvim.git)
* Install Plugins
```sh
cd ~/dotfiles && ./bin/coc_init.sh
```

* Install coc-clangd Extension
```
:CocInstall coc-clangd
```

* Install [Node.js](https://nodejs.org/en/download)
 
* Install [clangd](https://github.com/clangd/clangd/releases) & Add to PATH
