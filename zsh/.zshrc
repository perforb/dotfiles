# Every tool below is optional: a section is skipped when its command is missing,
# so a fresh machine opens a working shell before `mise install` has run.

# Keep PATH entries unique (nested shells and local files prepend again)
typeset -U path PATH

# ~/.local/bin holds mise (https://mise.run) and uv-installed tools
export PATH="$HOME/.local/bin:$PATH"

# -----------------------------------------------
# mise (CLI tools and runtimes; activate first so later sections can use them)
# -----------------------------------------------
command -v mise > /dev/null && eval "$(mise activate zsh)"

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
if command -v eza > /dev/null; then
  alias ls='eza'
  alias ll='eza -lah --git'
  alias lt='eza --tree --level=2'
fi
command -v bat > /dev/null && alias cat='bat --paging=never'

# -----------------------------------------------
# fzf
# -----------------------------------------------
if command -v fzf > /dev/null; then
  # Key bindings (CTRL-R / CTRL-T / ALT-C) and completion, built into fzf 0.48+
  source <(fzf --zsh)

  # Full screen, no borders; the prompt shows the current directory and git branch
  export FZF_DEFAULT_OPTS="--layout=reverse --no-separator --highlight-line --color=bg+:#a0566f,fg+:255 --bind 'start:transform-prompt:echo \"\$(pwd | sed \"s|^\$HOME|~|\") \$(git branch --show-current 2>/dev/null) > \"'"

  if command -v fd > /dev/null; then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  fi
fi

# zoxide
command -v zoxide > /dev/null && eval "$(zoxide init zsh --no-cmd)"

# CTRL-N for interactive directory jump (zoxide + fzf)
if command -v zoxide > /dev/null && command -v fzf > /dev/null; then
  bindkey -r '^[c'
  function _zoxide_fzf() {
    local dir preview='ls -1 {}'
    command -v eza > /dev/null && preview='eza --tree --level=2 {}'
    dir=$(zoxide query --list | fzf --height=~100% --preview "echo; $preview" --preview-window=down:10:noborder)
    if [ -n "$dir" ]; then
      cd "$dir"
      zle reset-prompt
    fi
  }
  zle -N _zoxide_fzf
  bindkey '^N' _zoxide_fzf
fi

# -----------------------------------------------
# uv
# -----------------------------------------------
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
# Machine-local settings (not tracked)
# -----------------------------------------------
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

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
command -v starship > /dev/null && eval "$(starship init zsh)"

