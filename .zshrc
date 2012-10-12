# users generic .zshrc file for zsh(1)

# environment variable configuration
export LANG=en_US.UTF-8

# auto change directory
setopt auto_cd

# auto directory pushd that you can get dirs list by cd -[tab]
setopt auto_pushd

# command correct edition before each completion attempt
setopt correct

# compacked complete list display
setopt list_packed

# no remove postfix slash of command line
setopt noautoremoveslash

# no beep sound when complete list displayed
setopt nolistbeep

# emacs like keybind (e.x. Ctrl-a goes to head of a line and Ctrl-e goes 
# to end of it)
bindkey -e

# historical backward/forward search with linehead string binded to ^P/^N
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end

# command history configuration
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# ignore duplication command history list
setopt hist_ignore_dups

# share command history data
setopt share_history

# completion configuration
autoload -U compinit
compinit

# source-highlight
export LESS=mqeisz-2XR
export LESSOPEN='| /usr/local/bin/src-hilite-lesspipe.sh %s'

# terminal configuration
unset LSCOLORS
case "${TERM}" in
    xterm)
        export TERM=xterm-color
        ;;
    kterm)
        export TERM=kterm-color
  # set BackSpace control character
        stty erase
        ;;
    cons25)
        unset LANG
        export LSCOLORS=ExFxCxdxBxegedabagacad
        export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
        zstyle ':completion:*' list-colors \
            'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
        ;;
esac

# set terminal title including current directory
case "${TERM}" in
    kterm*|xterm*)
        precmd() {
            echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
            psvar=()
            LANG=en_US.UTF-8 vcs_info
            [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
        }
        export LSCOLORS=exfxcxdxbxegedabagacad
        export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
        zstyle ':completion:*' list-colors \
            'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
        ;;
esac

# VCS settings
# http://d.hatena.ne.jp/mollifier/20090814/p1
# http://liosk.blog103.fc2.com/blog-entry-209.html
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'

# default shell configuration
# set prompt
# http://blog.blueblack.net/item_207
# http://journal.mycom.co.jp/column/zsh/002/index.html
# http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Prompt-Expansion
autoload colors
colors
case ${UID} in
    0)
        PROMPT="%{${fg[red}%}[%n@%m] %(!.#.$) %{${reset_color}%}"
        PROMPT2="%{${fg[red]}%}%_> %{${reset_color}%}"
        SPROMPT="%{${fg[cyan]}%}correct: %R -> %r [n,y,a,e]? %{${reset_color}%}"
        RPROMPT="%{${fg[yellow]}%}[%~]%{${reset_color}%}"
        [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        PROMPT="%{${fg[green]}%}${HOST%%.*} ${PROMPT}"
        ;;
    *)
        PROMPT="%{${fg[white]}%}[%n@%m] %(!.#.$) %{${reset_color}%}"
        PROMPT2="%{${fg[white]}%}%_> %{${reset_color}%}"
        SPROMPT="%{${fg[cyan]}%}correct: %R -> %r [n,y,a,e]? %{${reset_color}%}"
        RPROMPT="%1(v|%F{green}%1v%f|)" # git 管理下のディレクトリにいる場合にブランチを表示
        [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        PROMPT="%{${fg[green]}%}${HOST%%.*} ${PROMPT}"
        ;;
esac

# git-completion
[ -f ~/dotfiles/lib/git-completion.sh ] && source ~/dotfiles/lib/git-completion.sh

# perlbrew
[ -f ~/.perlbrew/etc/bashrc ] && source ~/.perlbrew/etc/bashrc

# perlbrew-completion
[ -f ~/.perlbrew/etc/perlbrew-completion.bash ] && source ~/.perlbrew/etc/perlbrew-completion.bash

# pythonbrew
[ -f ~/.pythonbrew/etc/bashrc ] && source ~/.pythonbrew/etc/bashrc

# rbenv
eval "$(rbenv init -)"

# alias configuration
# expand aliases before completing
# aliased ls needs if file/dir completions work
setopt complete_aliases

case "${OSTYPE}" in
    freebsd*|darwin*)
        alias ls="ls -G -w"
        ;;
    linux*)
        alias ls="ls --color"
        ;;
esac

# switch configuration
case "${OSTYPE}" in
    darwin*)
        [ -f ~/dotfiles/.zshrc.osx ] && source ~/dotfiles/.zshrc.osx
        ;;
    linux*)
        [ -f ~/dotfiles/.zshrc.linux ] && source ~/dotfiles/.zshrc.linux
        ;;
esac

# load user .zshrc configuration file
[ -f ~/.zshrc.mine ] && source ~/.zshrc.mine
