setopt auto_cd
setopt auto_pushd
setopt correct
setopt list_packed
setopt noautoremoveslash
setopt nolistbeep
setopt complete_aliases

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

bindkey -e
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end

HISTFILE=~/.zsh_history
HISTSIZE=10000000
SAVEHIST=10000000

setopt hist_ignore_dups
setopt share_history
setopt hist_ignore_space

autoload -Uz compinit && compinit -u
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'

case "${TERM}" in
  kterm*|xterm*|screen)
    precmd() {
      echo -ne "\e]0;${USER}@${HOST%%.*}:${PWD}\007"
      psvar=()
      LANG=en_US.UTF-8 vcs_info
      [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
    }
    export LSCOLORS=exfxcxdxbxegedabagacad
    export LS_COLORS='di=01;34:ln=00;36:so=01;32:ex=00;32:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors 'di=01;34' 'ln=00;36' 'so=01;32' 'ex=00;32' 'bd=46;34' 'cd=43;34'
    ;;
esac

autoload colors
colors
PROMPT="%{${fg[000]}%}[%n@%m] %(!.#.$) %{${reset_color}%}"
PROMPT2="%{${fg[000]}%}%_> %{${reset_color}%}"
SPROMPT="%{${fg[cyan]}%}correct: %R -> %r [n,y,a,e]? %{${reset_color}%}"
RPROMPT="%1(v|%F{cyan}%1v%f|)"

LS_COMMON="-hF --color=always --show-control-chars"
alias ls="command ls $LS_COMMON"
alias ll="ls -l"
alias la="ls -al"
alias l="ls -CF"
alias cp="cp -i"
alias mv="mv -i"
alias grep="grep --color"

zshaddhistory() {
  local line=${1%%$'\n'}
  local cmd=${line%% *}

  [[ ${#line} -ge 3
    && ${cmd} != (l|l[sal])
    && ${cmd} != (c|cd)
    && ${cmd} != (m|man)
    && ${cmd} != (rm)
  ]]
}

function percol_select_history() {
  local tac
  which gtac &> /dev/null && tac="gtac" || { which tac &> /dev/null && tac="tac" }
  BUFFER=$(fc -l -n 1 | eval $tac | percol --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle -R -c
}

zle -N percol_select_history
bindkey '^r' percol_select_history
autoload -Uz is-at-least

if is-at-least 4.3.11; then
  autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
  add-zsh-hook chpwd chpwd_recent_dirs
  zstyle ':chpwd:*' recent-dirs-max 5000
  zstyle ':chpwd:*' recent-dirs-default yes
  zstyle ':completion:*' recent-dirs-insert both

  function percol_cdr() {
    local selected_dir=$(cdr -l | awk '{ print $2 }' | percol)
    if [ -n "$selected_dir" ]; then
      BUFFER="cd ${selected_dir}"
      zle accept-line
    fi
    zle clear-screen
  }

  zle -N percol_cdr
  bindkey '^@' percol_cdr
fi
