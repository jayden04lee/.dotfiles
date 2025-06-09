## MacOS

```shell
git clone --bare https://github.com/jayd-lee/.dotfiles.git ~/.dotfiles

git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout -f

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

source ~/.zprofile

brew bundle --file ~/.config/Brewfile

git clone https://github.com/tmux-plugins/tpm.git ~/.config/tmux/plugins/tpm

tmux source-file ~/.config/tmux/tmux.conf

source ~/.zshrc
```

## Debian

```shell
git clone --bare https://github.com/jayd-lee/.dotfiles.git ~/.dotfiles

git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout -f

sudo apt update && sudo xargs -a ~/.config/Aptfile apt install -y

chsh -s $(which zsh)

mkdir -p ~/.config/zsh

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.config/zsh/powerlevel10k

git clone https://github.com/zsh-users/zsh-autosuggestions ~/.config/zsh/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.config/zsh/zsh-syntax-highlighting

git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm

tmux source-file ~/.config/tmux/tmux.conf

source ~/.zprofile

source ~/.zshrc
```

## Neovim build from source
https://github.com/neovim/neovim/blob/master/BUILD.md
