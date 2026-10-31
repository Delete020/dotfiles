typeset -U path PATH
path=(
  "$HOME/.local/bin"
  "$HOME/.node_modules/bin"
  $path
)

export VISUAL=nvim
export EDITOR="$VISUAL"
export npm_config_prefix="$HOME/.node_modules"
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

HISTFILE="$HOME/.zsh_history"
HISTSIZE=1000000
SAVEHIST=1000000
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt INTERACTIVE_COMMENTS
setopt AUTO_CD

bindkey -e

zsh_cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
mkdir -p "$zsh_cache_dir"
autoload -Uz compinit
compinit -d "$zsh_cache_dir/zcompdump-$ZSH_VERSION"

zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*'
zstyle ':completion:*' cache-path "$zsh_cache_dir/completion"

[[ -r /usr/share/fzf/completion.zsh ]] && source /usr/share/fzf/completion.zsh
[[ -r /usr/share/fzf/key-bindings.zsh ]] && source /usr/share/fzf/key-bindings.zsh

if [[ -r /usr/share/zsh/plugins/fzf-tab-git/fzf-tab.plugin.zsh ]]; then
  source /usr/share/zsh/plugins/fzf-tab-git/fzf-tab.plugin.zsh
  zstyle ':fzf-tab:*' switch-group ',' '.'
  zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always --icons $realpath 2>/dev/null'
  zstyle ':fzf-tab:complete:(bat|cat|less|nvim|vim):*' fzf-preview 'bat --color=always --style=numbers $realpath 2>/dev/null'
  zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview 'git diff --color=always $word | delta'
  zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'
fi

if (( $+commands[vivid] )); then
  export LS_COLORS="$(vivid generate molokai)"
fi

export FZF_DEFAULT_COMMAND='fd --type f --hidden --no-ignore --exclude .git --exclude node_modules 2>/dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS='--preview "bat --color=always --style=numbers {} 2>/dev/null" --preview-window=right:60%:wrap'
export FZF_ALT_C_COMMAND='fd --type d --hidden --exclude .git'
export FZF_ALT_C_OPTS='--preview "eza -1 --icons --git --git-ignore {}" --preview-window=right:60%:wrap'
export FZF_DEFAULT_OPTS='--ansi --layout=reverse --border=rounded --height=70% --color=fg:#D8DEE9,bg:-1,hl:#A3BE8C --color=fg+:#D8DEE9,bg+:#191e2a,hl+:#ffcc66 --color=info:#DDB6F2,prompt:#be5046,pointer:#45cdff --color=marker:#73d0ff,spinner:#73d0ff,header:#d4bfff'

[[ -r /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

(( $+commands[zoxide] )) && eval "$(zoxide init zsh)"
(( $+commands[atuin] )) && eval "$(atuin init zsh)"

fo() {
  local selected
  selected="$(fd --type f --hidden --exclude .git | fzf --prompt='open> ' --preview 'bat --color=always --style=numbers {} 2>/dev/null')" || return
  [[ -n "$selected" ]] && xdg-open "$selected" >/dev/null 2>&1 &
}

fe() {
  local selected
  selected="$(fd --type f --hidden --exclude .git | fzf --prompt='edit> ' --preview 'bat --color=always --style=numbers {} 2>/dev/null')" || return
  [[ -n "$selected" ]] && "$EDITOR" "$selected"
}

y() {
  local tmp cwd
  tmp="$(mktemp -t 'yazi-cwd.XXXXXX')"
  command yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd < "$tmp"
  [[ "$cwd" != "$PWD" && -d "$cwd" ]] && builtin cd -- "$cwd"
  command rm -f -- "$tmp"
}

rga-fzf() {
  local file
  file="$(rga --files-with-matches "$1" | fzf --sort --preview "rga --pretty --context 5 {q} {}" --phony -q "$1" --bind 'change:reload:rga --files-with-matches {q}' --preview-window='70%:wrap')" || return
  [[ -n "$file" ]] && xdg-open "$file" >/dev/null 2>&1 &
}

source "$HOME/.zsh_aliases"

(( $+commands[starship] )) && eval "$(starship init zsh)"

[[ -r /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
