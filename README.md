## MacOS

```shell
xcode-select --install

git clone --bare https://github.com/jayd-lee/.dotfiles.git ~/.dotfiles
git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout -f
git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME config --local status.showUntrackedFiles no

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew analytics off

source ~/.zprofile

brew install bat
brew install fd
brew install fzf
brew install gh
brew install git-delta
brew install jq
brew install neofetch
brew install neovim
brew install powerlevel10k
brew install ripgrep
brew install tldr
brew install tmux
brew install trash
brew install zsh-autosuggestions
brew install zsh-syntax-highlighting

brew install --cask ghostty
brew install --cask scroll-reverser
brew install --cask karabiner-elements
brew install --cask nikitabobko/tap/aerospace
brew install --cask font-jetbrains-mono-nerd-font

brew tap FelixKratz/formulae
brew install borders

defaults write com.apple.dock autohide -bool true
defaults write NSGlobalDomain _HIHideMenuBar -bool true
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
defaults write .GlobalPreferences com.apple.mouse.scaling -1

git clone https://github.com/tmux-plugins/tpm.git ~/.config/tmux/plugins/tpm

~/.config/tmux/plugins/tpm/bin/install_plugins

source ~/.zshrc
```

## Debian

```shell
git clone --bare https://github.com/jayd-lee/.dotfiles.git ~/.dotfiles
git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout -f
git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME config --local status.showUntrackedFiles no

sudo apt update && sudo apt upgrade -y
sudo apt install -y \
  bat \
  curl \
  fd-find \
  fzf \
  gh \
  jq \
  neofetch \
  neovim \
  ripgrep \
  tldr \
  tmux \
  zsh

sudo chsh $(whoami) -s $(which zsh)

mkdir -p ~/.config/zsh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.config/zsh/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.config/zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.config/zsh/zsh-syntax-highlighting

git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
tmux new-session -d -s init
tmux source-file ~/.config/tmux/tmux.conf
~/.config/tmux/plugins/tpm/bin/install_plugins

source ~/.zprofile
source ~/.zshrc
```

## Neovim build from source

https://github.com/neovim/neovim/blob/master/BUILD.md

```shell
sudo apt-get install ninja-build gettext cmake curl build-essential
git clone https://github.com/neovim/neovim
cd neovim
git checkout stable
make CMAKE_BUILD_TYPE=RelWithDebInfo
cd build && cpack -G DEB && sudo dpkg -i nvim-linux-x86_64.deb
```
