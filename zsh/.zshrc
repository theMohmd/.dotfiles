#########################
# Environment variables #
#########################

export EDITOR=nvim
export VISUAL=nvim
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

###########
# Aliases #
###########
 
alias zrc="$EDITOR $ZODTDIT/.zshrc"
alias ll='ls -lah'
alias zsource="source $ZDOTDIR/.zshrc"
alias shut="shutdown now"
alias pm="sudo pacman -S"
alias dad="cd /run/media/DaDisk"
#alias caps="setxkbmap -option caps:escape,shift:both_capslock &"
#alias caps="xmodmap -e 'keycode 9 = Caps_Lock' -e 'clear Lock' -e 'keycode 0x42 = Escape'"
alias myip="curl https://myip.wtf/json"
alias cdd='cd && cd'
alias minecraft='java -jar ~/Downloads/TLauncher.v10/TLauncher.jar'
alias nd="clear && npm run dev"
#alias nb="npm run build"
alias vpn="sudo openvpn --data-ciphers AES-128-CBC --config /etc/openvpn/client/XDE.ovpn --auth-user-pass /etc/openvpn/client/pass.txt"

function nb() {
  local word="todo.*build"
  local command=$2

  if rg -qi "$word"; then
    echo "Found:"
    rg -i "$word"  # Show the search results
  else
    npm run build
  fi
}
#############
# Functions #
#############
 
zPlug()
{
    index=$(expr index "$1" "/")
    plug_name="${1:$index}"

    if [[ ! -d $ZDOTDIR/plugin/$plug_name ]]; then
        git clone https://github.com/$1 $ZDOTDIR/plugin/$plug_name
    fi
    if [[ -n $2 ]]; then
        
        source $ZDOTDIR/plugin/$plug_name/$2
    else
        source $ZDOTDIR/plugin/$plug_name/$plug_name.zsh
       
    fi
}

##########################
# Keybind mode for shell #
##########################

# For vi keybinding
bindkey -v

#######################
# Command-line editor #
#######################

# Uses $VISUAL editor
autoload -z edit-command-line
zle -N edit-command-line
# If using emacs keybinds (CTRL-X + CTRL-E)
#bindkey "^X^E" edit-command-line
# If using vi keybinds (`v` in control mode)
bindkey -M vicmd v edit-command-line

#######################
# Settings            #
#######################

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history


# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# auto suggestion color
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=249'

# case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# swap escape and caps lock
#xmodmap -e 'keycode 9 = Caps_Lock' -e 'clear Lock' -e 'keycode 0x42 = Escape'

#######################
# Prompt              #
#######################
#colors: https://www.hackitu.de/termcolor256/
function git_branch_name()
{
  branch=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')
  if [[ $branch == "" ]];
  then
    echo "%F{227}"
  else
    echo "%F{227}%K{084}%k%f%F{black}%K{084}  $branch %k%f%F{084}"
  fi
}

# show vim mode
mode=""
function zle-line-init zle-keymap-select {
    mode="" #prev background
    if [[ $KEYMAP == 'vicmd' ]]; then
        mode+="%K{197}%k%f%F{black}%B%K{197} N %f%b%k%F{197}%f"
    elif [[ $KEYMAP == 'main' ]]; then
        mode+="%K{69}%k%f%F{black}%B%K{69} I %f%b%k%F{69}%f"
    else
        mode+="[$KEYMAP]"
    fi
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

setopt PROMPT_SUBST
dir="%K{227}%F{black}%B  %c %b%f%k"
PROMPT='
%F{227}╭─%f$dir$(git_branch_name)$mode
%F{227}╰─⏵%f '

#######################
# Plugins             #
#######################

zPlug "zsh-users/zsh-autosuggestions"
zPlug "zsh-users/zsh-syntax-highlighting"
zPlug "zsh-users/zsh-history-substring-search"
zPlug "zsh-users/zsh-completions" "zsh-completions.plugin.zsh"
#zPlug "MichaelAquilina/zsh-auto-notify" "auto-notify.plugin.zsh"
#zPlug "romkatv/powerlevel10k" "powerlevel10k.zsh-theme"
