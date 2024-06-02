```shell
git clone --bare git@github.com:jayd-lee/.dotfiles.git ~/.dotfiles

git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout -f

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

source ~/.zprofile

brew bundle --file ~/.config/Brewfile

git clone git@github.com:tmux-plugins/tpm.git ~/.config/tmux/plugins/tpm

tmux source-file ~/.config/tmux/tmux.conf

source ~/.zshrc
```
