#!/bin/bash

fu(){
    local word="$1"
    local first_char="${word:0:1}"  
    local rest_of_word="${word:1}"   

    # Print the colored first character followed by the rest of the word
    echo -e "\e[33m$first_char\e[0m$rest_of_word"
}
yes=$(fu "yes")
no=$(fu "no")
backup=$(fu "backup")
delete=$(fu "delete")
cancel=$(fu "cancel")

#installation process
read -p "Do you want installation process? ($yes/$no): " answer
if [[ "$answer" =~ ^[Yy]$ ]]; then
    sudo pacman -S neovim
    sudo pacman -S tmux
    sudo pacman -S zsh
fi

#linking process
#app name, path in .config

read -p "Do you want xprofile? ($yes/$no): " answer
if [[ "$answer" =~ ^[Yy]$ ]]; then
    if [ -e "$HOME/.xprofile" ]; then
        read -p "What do you want to do with the existing profile? ($backup/$cancel/$delete): " answer

        if [[ "$answer" =~ ^[Dd]$ ]]; then
            rm -f $HOME/.xprofile
            ln -s $HOME/.dotfiles/x/.xprofile $HOME/.xprofile

        elif [[ "$answer" =~ ^[Bb]$ ]]; then
            mv $HOME/.xprofile $HOME/.xprofile.bak 
            ln -s $HOME/.dotfiles/x/.xprofile $HOME/.xprofile
        fi
    else
        ln -s $HOME/.dotfiles/x/.xprofile $HOME/.xprofile
    fi 
fi
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

#neovim
read -p "Do you want neovim config? ($yes/$no): " answer
if [[ "$answer" =~ ^[Yy]$ ]]; then
    if [ -d "$HOME/.config/nvim" ]; then
        read -p "What do you want to do with the existing config? ($backup/$cancel/$delete): " answer

        if [[ "$answer" =~ ^[Dd]$ ]]; then
            rm -rf $HOME/.config/nvim
            ln -s $HOME/.dotfiles/nvim $HOME/.config/nvim

        elif [[ "$answer" =~ ^[Bb]$ ]]; then
            mv $HOME/.config/nvim $HOME/.config/nvim.bak
            ln -s $HOME/.dotfiles/nvim $HOME/.config/nvim
        fi
    else
        ln -s $HOME/.dotfiles/nvim $HOME/.config/nvim
    fi 
    git clone --depth 1 https://github.com/wbthomason/packer.nvim\ ~/.local/share/nvim/site/pack/packer/start/packer.nvim
fi


#tmux
read -p "Do you want tmux config? ($yes/$no): " answer
if [[ "$answer" =~ ^[Yy]$ ]]; then
    if [ -d "$HOME/.config/tmux" ]; then
        read -p "What do you want to do with the existing config? ($backup/$cancel/$delete): " answer

        if [[ "$answer" =~ ^[Dd]$ ]]; then
            rm -rf $HOME/.config/tmux
            ln -s $HOME/.dotfiles/tmux $HOME/.config/tmux

        elif [[ "$answer" =~ ^[Bb]$ ]]; then
            mv $HOME/.config/tmux $HOME/.config/$2.bak
            ln -s $HOME/.dotfiles/tmux $HOME/.config/tmux
        fi
    else
        ln -s $HOME/.dotfiles/tmux $HOME/.config/tmux
    fi 
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm 
fi

read -p "Do you want cleanreact? ($yes/$no): " answer
    if [[ "$answer" =~ ^[Yy]$ ]]; then
        ln -s $HOME/.dotfiles/cleanreact /usr/local/bin
    fi
    
$(linkFn "zsh" "zsh")
