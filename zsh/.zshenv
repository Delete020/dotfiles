# Environment Variables
# Loaded as ~/.zshenv and sourced again from .zshrc (macOS path_helper in
# /etc/zprofile reorders PATH), so everything here must be idempotent.

# keep PATH/FPATH entries unique so re-sourcing does not duplicate them
typeset -U path PATH fpath FPATH

#set Editor
export VISUAL=nvim
export EDITOR="$VISUAL"

# rg
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

# fzf
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git || git ls-tree -r --name-only HEAD || rg --files --hidden --follow --glob '!.git' || find ."
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview '(bat --style=numbers --color=always {} || cat {} || tree -NC {}) 2>/dev/null | head -200'"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview' --exact"
export FZF_ALT_C_OPTS="--preview '(eza --tree --icons --level 3 --color=always --group-directories-first {} || tree -NC {} || ls --color=always --group-directories-first {}) 2>/dev/null | head -200'"

# FZF theme
export FZF_DEFAULT_OPTS='--ansi
 --color=fg:#908caa,bg:-1,hl:#ea9a97
 --color=fg+:#e0def4,bg+:#393552,hl+:#ea9a97
 --color=border:#44415a,header:#3e8fb0,gutter:#232136
 --color=spinner:#f6c177,info:#9ccfd8
 --color=pointer:#c4a7e7,marker:#eb6f92,prompt:#73d0ff'

# mdv
export MDV_THEME="729.8953"
export MDV_CODE_THEME="729.8953"
export XDG_CONFIG_HOME=$HOME/.config

# homebrew
export HOMEBREW_NO_ENV_HINTS=1

#volta
export PATH="$HOME/.volta/bin:$PATH"

# cheat
export CHEAT_USE_FZF=true

#go
export GOPATH=$HOME/Projects/go
export PATH="$HOME/Projects/go/bin:$PATH"

#GPG
export GPG_TTY=$TTY

# Zoxide FZF options
export _ZO_FZF_OPTS="--scheme=path --tiebreak=end,chunk,index --bind=ctrl-z:ignore,btab:up,tab:down --cycle --keep-right --border=sharp --height=45% --info=inline --layout=reverse --tabstop=1 --exit-0 --select-1 --preview '(eza --tree --icons --level 3 --color=always --group-directories-first {2} || tree -NC {2} || ls --color=always --group-directories-first {2}) 2>/dev/null | head -200'"


# uv
export PATH="/Users/cancel/.local/bin:$PATH"

# claude code
export MAX_THINKING_TOKENS=32000

# claude-powerline
export CLAUDE_POWERLINE_THEME=rose-pine
