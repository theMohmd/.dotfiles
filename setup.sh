#!/bin/bash
#color first letter
color_f(){
  local word="$1"
  local first_char="${word:0:1}"
  local rest_of_word="${word:1}"

  # Print the colored first character followed by the rest of the word
  echo -e "\e[33m$first_char\e[0m$rest_of_word"
}

#pre colored options
backup=$(color_f "backup")
delete=$(color_f "delete")
cancel=$(color_f "cancel")

linkFn(){ #dotfiles folder name, destination, callback(optional)
  read -p "Do you want $1 config? [Y/n]: " answer
  if [[ ! "$answer" =~ ^[Nn]$ ]]; then
    echo "Linking $1"
    if [ -d "$2" ]; then
      read -p "What do you want to do with the existing config? ($backup/$cancel/$delete): " answer

      if [[ "$answer" =~ ^[Dd]$ ]]; then
        echo "Deleting old config"
        sudo rm -rf "$2"
        sudo ln -s $HOME/.dotfiles/$1 $2

      elif [[ "$answer" =~ ^[Bb]$ ]]; then
        echo "Backing up old config"
        sudo mv $2 $2.bak
        sudo ln -s $HOME/.dotfiles/$1 $2
      else
        echo "Canceled"
      fi
    else
      sudo ln -s $HOME/.dotfiles/$1 $2
    fi 
    $3
  else
    echo "Canceled $1"
  fi
}

# Function to check and install a package
install() {
  local manager=$1
  local package=$2

  # Check if the package is installed
  if $manager -Qi "$package" &> /dev/null; then
    echo "$package is already installed."
  else
    echo "$package is not installed. Installing..."
    sudo $manager -S --noconfirm "$package"
  fi
  $3
}

#installation process
read -p "Do you want installation process? [Y/n]: " answer
if [[ ! "$answer" =~ ^[Nn]$ ]]; then

  install pacman neovim

  install pacman tmux

  install pacman zsh

  install pacman kitty

  # install pacman keyd "sudo systemctl enable keyd sudo systemctl start keyd"

  install pacman npm

  install pacman ripgrep

  install pacman wl-clipboard

  install yay ttf-jetbrains-mono-nerd

  install pacman flameshot
fi

#linking process
#app name, path of config, optional callback

linkFn "kitty" "$HOME/.config/kitty"
linkFn "zsh" "$HOME/.config/zsh"
linkFn "tmux" "$HOME/.config/tmux" "git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm"
linkFn "nvim" "$HOME/.config/nvim" "sudo npm i -g rustywind"
linkFn "keyd" "/etc/keyd" "sudo keyd reload"

linkFn(){
  read -p "Do you want $1 config? ($yes/$no): " answer
  if [[ "$answer" =~ ^[Yy]$ ]]; then
    if [ -d "$HOME/.config/$2" ]; then
      read -p "What do you want to do with the existing config? ($backup/$cancel/$delete): " answer

      if [[ "$answer" =~ ^[Dd]$ ]]; then
        rm -rf $HOME/.config/$2
        ln -s $HOME/.dotfiles/$2 $HOME/.config/$2

      elif [[ "$answer" =~ ^[Bb]$ ]]; then
        mv $HOME/.config/$2 $HOME/.config/$2.bak
        ln -s $HOME/.dotfiles/$2 $HOME/.config/$2
      fi
    else
      ln -s $HOME/.dotfiles/$2 $HOME/.config/$2
    fi
  fi
}

# #neovim
# read -p "Do you want neovim config? ($yes/$no): " answer
# if [[ "$answer" =~ ^[Yy]$ ]]; then
#   if [ -d "$HOME/.config/nvim" ]; then
#     read -p "What do you want to do with the existing config? ($backup/$cancel/$delete): " answer
#
#     if [[ "$answer" =~ ^[Dd]$ ]]; then
#       rm -rf $HOME/.config/nvim
#       ln -s $HOME/.dotfiles/nvim $HOME/.config/nvim
#
#     elif [[ "$answer" =~ ^[Bb]$ ]]; then
#       mv $HOME/.config/nvim $HOME/.config/nvim.bak
#       ln -s $HOME/.dotfiles/nvim $HOME/.config/nvim
#     fi
#   else
#     ln -s $HOME/.dotfiles/nvim $HOME/.config/nvim
#   fi 
#   npm install -g rustywind

read -p "Do you want x scripts? [Y/n]: " answer
if [[ ! "$answer" =~ ^[Nn]$ ]]; then
  sudo ln -s $HOME/.dotfiles/scripts/x-scripts.sh /usr/local/bin/x
fi

read -p "Do you want tm script (tmux sessionizer)? [Y/n]: " answer
if [[ ! "$answer" =~ ^[Nn]$ ]]; then
  sudo ln -s $HOME/.dotfiles/scripts/tm.sh /usr/local/bin/ts
fi

read -p "Do you want vpn script ? [Y/n]: " answer
if [[ ! "$answer" =~ ^[Nn]$ ]]; then
  sudo ln -s $HOME/.dotfiles/scripts/vpn.sh /usr/local/bin/vpn
fi

read -p "Do you want nd script (custom npm run dev)? [Y/n]: " answer
if [[ ! "$answer" =~ ^[Nn]$ ]]; then
  sudo ln -s $HOME/.dotfiles/scripts/nd.sh /usr/local/bin/nd
fi

read -p "Do you want grub theme? ($yes/$no): " answer
if [[ "$answer" =~ ^[Yy]$ ]]; then
  sudo ln -sf $HOME/.dotfiles/grub/crt-amber-theme /boot/grub/themes
  echo "GRUB_THEME=\"/boot/grub/themes/crt-amber-theme/theme.txt\"" | sudo tee -a /etc/default/grub > /dev/null
  sudo grub-mkconfig -o /boot/grub/grub.cfg
fi

read -p "Do you want splash screen? ($yes/$no): " answer
if [[ "$answer" =~ ^[Yy]$ ]]; then
  sudo ln -sf $HOME/.dotfiles/splash_screen/* /usr/share/plasma/look-and-feel/
fi

