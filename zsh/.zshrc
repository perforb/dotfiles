# -----------------------------------------------
# mise (CLI tools and runtimes; activate first so later sections can use them)
# -----------------------------------------------
eval "$(mise activate zsh)"

# -----------------------------------------------
# Completion
# -----------------------------------------------
autoload -Uz compinit && compinit

setopt AUTO_MENU
setopt COMPLETE_IN_WORD
setopt ALWAYS_TO_END
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# -----------------------------------------------
# History
# -----------------------------------------------
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY

# -----------------------------------------------
# Aliases
# -----------------------------------------------
alias ls='eza'
alias ll='eza -lah --git'
alias lt='eza --tree --level=2'
alias cat='bat --paging=never'

# -----------------------------------------------
# fzf
# -----------------------------------------------
# Key bindings (CTRL-R / CTRL-T / ALT-C) and completion, built into fzf 0.48+
source <(fzf --zsh)

# Full screen, no borders; the prompt shows the current directory and git branch
export FZF_DEFAULT_OPTS="--layout=reverse --no-separator --highlight-line --color=bg+:#a0566f,fg+:255 --bind 'start:transform-prompt:echo \"\$(pwd | sed \"s|^\$HOME|~|\") \$(git branch --show-current 2>/dev/null) > \"'"

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# zoxide
eval "$(zoxide init zsh --no-cmd)"

# CTRL-N for interactive directory jump (zoxide + fzf)
bindkey -r '^[c'
function _zoxide_fzf() {
  local dir
  dir=$(zoxide query --list | fzf --height=~100% --preview 'echo; eza --tree --level=2 {}' --preview-window=down:10:noborder)
  if [ -n "$dir" ]; then
    cd "$dir"
    zle reset-prompt
  fi
}
zle -N _zoxide_fzf
bindkey '^N' _zoxide_fzf

# -----------------------------------------------
# uv
# -----------------------------------------------
export PATH="$HOME/.local/bin:$PATH"

# Auto-activate virtual environment on directory change
autoload -Uz add-zsh-hook
_uv_auto_activate() {
  if [ -f ".venv/bin/activate" ]; then
    source .venv/bin/activate
  fi
}
add-zsh-hook chpwd _uv_auto_activate

# -----------------------------------------------
# AWS CLI completion
# -----------------------------------------------
if type aws_completer > /dev/null 2>&1; then
  autoload -Uz bashcompinit && bashcompinit
  complete -C aws_completer aws
fi

# -----------------------------------------------
# Syntax highlighting (must be sourced last)
# -----------------------------------------------
# Plugins are cloned by install.sh
ZSH_PLUGINS_DIR=~/.local/share/zsh/plugins
[ -f $ZSH_PLUGINS_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && \
  source $ZSH_PLUGINS_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# -----------------------------------------------
# Inline suggestions
# -----------------------------------------------
[ -f $ZSH_PLUGINS_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh ] && \
  source $ZSH_PLUGINS_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=240'
bindkey '^]' autosuggest-accept

_tab_or_autosuggest() {
  if [[ -n "$POSTDISPLAY" ]]; then
    zle autosuggest-accept
  else
    zle expand-or-complete
  fi
}
zle -N _tab_or_autosuggest
bindkey '^I' _tab_or_autosuggest

# -----------------------------------------------
# Prompt (starship)
# -----------------------------------------------
eval "$(starship init zsh)"

