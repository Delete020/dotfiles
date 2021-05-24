# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.

source ~/.zinit/bin/zinit.zsh
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/cancel/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"
HISTSIZE=2000

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git sudo systemd archlinux history tmux)

DISABLE_MAGIC_FUNCTIONS=true
source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# aliases
# configuration
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias nvimconfig='nvim $HOME/.config/nvim/init.vim'

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
alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'

alias p10kupdate='git -C ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k pull'

# ls
DISABLE_LS_COLORS=true
alias ls="exa -bh --color=auto --icons"
alias ll='ls -l'
alias la='ls -a'
alias l="ls"      l.='ls -d .*'   la='ls -a'   ll='ls -lbt created' 
#alias ls=lsd

alias vi='nvim'
alias vim='nvim'
#alias cat='bat'
alias btop='bashtop'

# Remove git from a project
alias ungit="find . -name '.git' -exec rm -rf {} \;"

# tmux
alias tn='tmux new-session -s'                    # tmux new session
alias ta='tmux attach -t'                         # tmux attach
alias tl='tmux ls'                                # list
alias tk='tmux kill-session -s'                   # kill session name

#set Editor
export VISUAL=nvim
export EDITOR="$VISUAL"

# Zinit
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

# fzf-tab
zinit light Aloxaf/fzf-tab
zstyle ':fzf-tab:complete:_zlua:*' query-string input
zstyle ':fzf-tab:complete:kill:argument-rest' fzf-preview 'ps --pid=$word -o cmd --no-headers -w -w'
zstyle ':fzf-tab:complete:kill:argument-rest' fzf-flags '--preview-window=down:3:wrap'
zstyle ':fzf-tab:complete:kill:*' popup-pad 0 3
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
zstyle ':fzf-tab:complete:cd:*' popup-pad 30 0
zstyle ":completion:*:git-checkout:*" sort false
zstyle ':completion:*:exa' file-sort modification
zstyle ':completion:*:exa' sort false
zstyle ":fzf-tab:*" fzf-flags --color=bg+:23
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup

# 快速目录跳转
zinit ice lucid wait='1'
zinit light skywind3000/z.lua

#高亮
#zinit ice lucid wait='0' atinit='zpcompinit'
#zinit light zdharma/fast-syntax-highlighting
#
##自动建议
#zinit ice lucid wait="0" atload='_zsh_autosuggest_start'
#zinit light zsh-users/zsh-autosuggestions

zinit wait lucid for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay" \
    zdharma/fast-syntax-highlighting \
 atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions \

export FZF_DEFAULT_COMMAND='fd --type f'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

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
#bookmark
export NNN_BMS='i:~/Pictures/Wallpapers;n:~/Documents/Notes'
export NNN_SEL='/tmp/.sel'
export NNN_FIFO='/tmp/nnn.fifo'
