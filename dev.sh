#!/usr/bin/env sh
cd $HOME

echo "Installing development tools ..."
sudo pacman -Syu --noconfirm --needed gcc go ruby git make cmake openssh wget curl fzf \
  p7zip unrar unzip zip unarchiver bzip2 gzip lrzip lz4 lzip lzop xz tar \
  base-devel openssl zlib readline sqlite llvm ncurses xz tk python-pyopenssl libffi \
  python python-pip python2 python2-pip pyenv \
  vim neovim zsh \
  nodejs yarn npm \
  jdk-openjdk jre-openjdk maven \
  ffmpeg \
  boost swig sox \
  neofetch htop xdotool xclip

echo "Installing vim-plug ..."
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
mkdir ~/.swap-files

echo "Setting up yarn ..."
yarn global add spaceship-prompt neovim
gem install neovim

echo "Setting up npm ..."
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'

echo "Setting up pyenv"
eval "$(pyenv init -)"
pyenv install 3.7.7
pyenv install 2.7.17
pyenv shell 2.7.17 && pip install neovim
pyenv shell 3.7.7 && pip install neovim pylint autopep8
pyenv global 3.7.7

echo "Setting up zsh ..."
# Oh my zsh
[ ! -d "$HOME/.oh-my-zsh" ] && /usr/bin/env sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# Zsh auto suggestion
[ ! -d "$HOME/.zsh/zsh-autosuggestions" ] && git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.zsh/zsh-autosuggestions
# Zsh syntax highlighting
[ ! -d "$HOME/.zsh/zsh-syntax-highlighting" ] && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.zsh/zsh-syntax-highlighting
