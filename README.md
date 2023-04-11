# Dotfiles
Workspace settings

# Setup macOS
* Install [Homebrew](https://brew.sh)

* Install [Oh My Zsh](https://github.com/robbyrussell/oh-my-zsh)

* Install Tools
```sh
brew install vim cmake tmux ctags the_silver_searcher reattach-to-user-namespace htop pstree git-lfs
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

# YCM macOS & Linux
```sh
cd ~/dotfiles/vim/plugins/YouCompleteMe
./install.py --clangd-completer --verbose
```

# YCM Windows
1. Install Python3.10 32-bit & add to PATH
2. `cd .\dotfiles\vim\plugins\YouCompleteMe`
3. `python install.py --clangd-completer --msvc=17 --verbose`
4. Open `x64 Native Tools Command Prompt for VS 2022` & cd to cmake project directory
5. `cmake . -G "NMake Makefiles" -D CMAKE_EXPORT_COMPILE_COMMANDS=on`
6. [clangd config](https://clangd.llvm.org/config)
