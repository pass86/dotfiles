# Setup macOS
```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
brew install vim ctags tmux reattach-to-user-namespace libuv
```

# Install dotfiles
```sh
git clone https://github.com/pass86/dotfiles.git
~/dotfiles/bin/install.sh
```

# Install Submodules
```sh
~/dotfiles/bin/submodules_init.sh
```

# Install [YouCompleteMe](https://github.com/Valloric/YouCompleteMe)
```sh
~/dotfiles/bin/ycm_init.sh
```

# Install [omnisharp-vim](https://github.com/OmniSharp/omnisharp-vim)
```sh
~/dotfiles/bin/omnisharp_init.sh
```
