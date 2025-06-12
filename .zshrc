# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' matcher-list '' '' 'm:{[:lower:]}={[:upper:]} m:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
zstyle :compinstall filename '/home/yutah/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=3000
SAVEHIST=3000
# End of lines configured by zsh-newuser-install

#alias
alias reso="xrandr --output DP-2 --mode  3440x1440 --rate 100.00  --output DP-1 --mode 2560x1440 --right-of DP-2"
alias resodual="xrandr --output DP-2 --mode  1720x1440 --output DP-1 --mode 2560x1440 --right-of DP-2"
alias ll="lsd -l"
alias ls="lsd -a"
alias cat="bat"
alias vmconf="nvim /home/yutah/.config/nvim/"

#tldr tool for better man
alias mn="tldr"

#git alias
alias gf="git fetch"
alias gpl="git pull"
alias gfp="git fetch && git pull"
alias gs="git status"
alias gl="git log"
alias gd="git diff"
alias ga="git add"
alias gc="git commit -m"
alias gps="git push"
alias gch="git checkout"

#functions
#git add commit and push all
gall() {
    git add .
    git commit -m "$([ "$1" != "" ] && echo "$1" || echo "update")"
    git push
}

#plugins
source ~/powerlevel10k/powerlevel10k.zsh-theme
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# source /usr/share/zsh/plugins/zsh-sudo/sudo.plugin.zsh


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey  "^[[3~"  delete-char
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

#zsh-syntax-highlighting configuration
# Customize syntax highlighting colors
typeset -gA ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=white'
ZSH_HIGHLIGHT_STYLES[command]='fg=cyan'

ZSH_HIGHLIGHT_STYLES[alias]='fg=cyan'  # Change alias color (optional)
ZSH_HIGHLIGHT_STYLES[variable]='fg=yellow'  # Change variable color (optional)
source ~/powerlevel10k/powerlevel10k.zsh-theme
export PATH="$HOME/.local/bin:$PATH"
