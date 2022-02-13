if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/.zinit/bin/zinit.zsh

export ZSH="/home/cancel/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"
HISTSIZE=2000

plugins=(git sudo systemd archlinux history tmux)

DISABLE_MAGIC_FUNCTIONS=true
source $ZSH/oh-my-zsh.sh

# aliases
# configuration
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias nvimconfig='nvim $HOME/.config/nvim/init.vim'
alias bspwmrc='nvim $HOME/.config/bspwm/bspwmrc'
alias picomrc='nvim $HOME/.config/picom/picom.conf'
alias sxhkbrc='nvim $HOME/.config/sxhkd/sxhkdrc'
alias alacrc='nvim $HOME/.config/alacritty/alacritty.yml'

# proxy
alias setproxy="export http_proxy=socks5://127.0.0.1:1089 https_proxy=socks5://127.0.0.1:1089"
alias unsetproxy="unset http_proxy https_proxy"

# pacman
alias pacman='sudo pacman'
alias paclean='pacman -Rns $(pacman -Qtdq)'

# Changing Directories
alias zc='z -c'      # 严格匹配当前路径的子路径
alias zz='z -i'      # 使用交互式选择模式
alias zf='z -I'      # 使用 fzf 对多个结果进行选择
alias zb='z -b'      # 快速回到父目录
alias zzz='z ~'
alias cdb='cd -'
alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'

# p10kupdate
alias p10kupdate='git -C ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k pull'

# ls
DISABLE_LS_COLORS=true
alias ls="exa -bh --color=auto --icons"
alias ll='ls -l'
alias la='ls -a'
alias l="ls"      l.='ls -d .*'   la='ls -a'   ll='ls -lbt created' 

alias cp='cp -iv'
alias mv='mv -iv'
alias ln='ln -iv'
alias mkdir='mkdir -v -p'

# Convenience
alias vi='nvim'
alias vim='nvim'
alias fd="fd --hidden --exclude '.git'"
alias btop='bashtop'
alias hrg='history | rg'
alias glow='glow -p'

# Remove git from a project
alias ungit="find . -name '.git' -exec rm -rf {} \;"

# tmux
alias tn='tmux new-session -s'                    # tmux new session
alias ta='tmux attach -t'                         # tmux attach
alias tl='tmux ls'                                # list
alias tk='tmux kill-session -s'                   # kill session name


# Zinit
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-rust \
    zdharma-continuum/zinit-annex-readurl \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-bin-gem-node

### End of Zinit's installer chunk

autoload -Uz compinit promptinit
compinit
promptinit
zstyle ':completion:*' menu select

## 插件
zinit wait="1" lucid light-mode for \
    kevinhwang91/zsh-tmux-capture \
    hlissner/zsh-autopair \
    hchbaw/zce.zsh \
    Aloxaf/gencomp \
    wfxr/forgit

zinit light-mode for \
    blockf \
        zsh-users/zsh-completions

# 快速目录跳转
zinit ice lucid wait='1'
zinit light skywind3000/z.lua
zinit light zdharma-continuum/history-search-multi-word

# enhancd
zinit ice as"program" pick"init.zsh" wait"2" lucid
zinit light b4b4r07/enhancd

zinit ice as"program" mv=":cht.sh -> cht.sh" atclone="chmod +x cht.sh" pick"cht.sh" 
zinit snippet https://cht.sh/:cht.sh

zinit ice mv=":zsh -> _cht" as="completion"
zinit snippet https://cheat.sh/:zsh

# fzf-tab
zinit ice wait'1' lucid
zinit light Aloxaf/fzf-tab
zstyle ':fzf-tab:complete:_zlua:*' query-string input
zstyle ':fzf-tab:complete:kill:argument-rest' fzf-preview 'ps --pid=$word -o cmd --no-headers -w -w'
zstyle ':fzf-tab:complete:kill:argument-rest' fzf-flags '--preview-window=down:3:wrap'
zstyle ':fzf-tab:complete:kill:*' popup-pad 0 3
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
zstyle ':fzf-tab:complete:cd:*' popup-pad 30 0
zstyle ":fzf-tab:*" fzf-flags --color=bg+:23
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
zstyle ':fzf-tab:*' switch-group ',' '.'
zstyle ":completion:*:git-checkout:*" sort false
zstyle ':completion:*' file-sort modification
zstyle ':completion:*:exa' sort false
zstyle ':completion:files' sort false
zstyle ':fzf-tab:*:*argument-rest*' popup-pad 100 0

#高亮 自动建议
zinit wait lucid for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
 atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions \
 atload"!export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=yellow,fg=white,bold'" \
    zsh-users/zsh-history-substring-search \
 pick"fz.plugin.zsh" \
    changyuheng/fz \
 pick"git-it-on.plugin.zsh" \
    peterhurford/git-it-on.zsh 

export FZF_DEFAULT_COMMAND='fd --type f'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#set Editor
export VISUAL=nvim
export EDITOR="$VISUAL"

# npm
PATH="$HOME/.node_modules/bin:$PATH"
export npm_config_prefix=~/.node_modules

# tldr
export TLDR_COLOR_NAME="cyan"
export TLDR_COLOR_DESCRIPTION="white"
export TLDR_COLOR_EXAMPLE="green"
export TLDR_COLOR_COMMAND="red"
export TLDR_COLOR_PARAMETER="white"
export TLDR_CACHE_ENABLED=1
export TLDR_CACHE_MAX_AGE=720
export TLDR_PAGES_SOURCE_LOCATION="https://raw.githubusercontent.com/tldr-pages/tldr/master/pages"
export TLDR_DOWNLOAD_CACHE_LOCATION="https://tldr-pages.github.io/assets/tldr.zip"

# NNN
export NNN_PLUG='f:finder;o:fzopen;p:preview-tabbed;d:diffs;v:imgview,c:fzcd;t:preview-tui'
#NNN bookmark
export NNN_BMS='i:~/Pictures/Wallpapers;n:~/Documents/Notes'
export NNN_SEL='/tmp/.sel'
export NNN_FIFO='/tmp/nnn.fifo'

# rg
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
