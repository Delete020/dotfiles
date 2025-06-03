# ==== p10k instant prompt ====
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

DISABLE_MAGIC_FUNCTIONS=true
# ==== history ====
HISTSIZE=100000000                # maximum history size in terminal's memory
SAVEHIST=$HISTSIZE               # maximum size of history file
HISTFILE=$HOME/.zsh_history
setopt HIST_IGNORE_SPACE        # ignore commands with leading space
setopt HIST_IGNORE_DUPS         # do not put duplicated command into history list
setopt HIST_REDUCE_BLANKS       # remove unnecessary blanks
setopt INC_APPEND_HISTORY       # append command to history file immediately after execution

# ==== Zinit ====
source ~/.local/share/zinit/zinit.git/zinit.zsh
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-{'as-monitor','bin-gem-node','binary-symlink','patch-dl','submods','rust','readurl'}

### End of Zinit's installer chunk

autoload -Uz compinit promptinit
compinit
promptinit
zinit cdreplay -q

# ==== Oh My Zsh =====
zinit for \
      OMZL::correction.zsh \
      OMZL::directories.zsh \
      OMZL::history.zsh \
      OMZL::theme-and-appearance.zsh \
      OMZP::common-aliases

zinit wait="1" lucid for \
      OMZP::colored-man-pages \
      OMZP::cp \
      OMZP::extract \
      OMZP::fancy-ctrl-z \
      OMZP::systemd/systemd.plugin.zsh \
      OMZP::git \
      OMZP::brew \
      OMZP::sudo

# ==== zinit plugins ====
# P10k ====
zinit ice depth=1; zinit light romkatv/powerlevel10k

# fzf-tab ====
zinit ice wait lucid depth"1" atload"zicompinit; zicdreplay" blockf
zinit light Aloxaf/fzf-tab

# Completion enhancements ====
zinit wait="0" lucid light-mode depth"1" for \
    atinit"ZINIT[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
    blockf \
    zsh-users/zsh-completions \
    atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions \
    pick"git-it-on.plugin.zsh" \
    peterhurford/git-it-on.zsh

zinit wait="1" lucid light-mode depth"2" for \
    kevinhwang91/zsh-tmux-capture \
    djui/alias-tips \
    hlissner/zsh-autopair \
    hchbaw/zce.zsh \
    Aloxaf/gencomp \
    wfxr/forgit \
    lukechilds/zsh-nvm \
    atclone="dircolors -b LS_COLORS > c.zsh" atpull='%atclone' pick='c.zsh' \
    trapd00r/LS_COLORS \
    as="program" atclone="rm -f ^(rgg|agv)" \
    lilydjwg/search-and-view

zstyle ':fzf-tab:*' switch-group ',' '.'
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:complete:*:options' sort false
zstyle ':fzf-tab:complete:(cd|ls|lsd|exa|eza|bat|cat|emacs|nano|vi|vim):*' \
       fzf-preview 'eza -1 --icons --color=always $realpath 2>/dev/null || ls -1 --color=always $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' \
	   fzf-preview 'echo ${(P)word}'
zstyle ':fzf-tab:complete:(\\|*/|)nvim:argument-rest' \
       fzf-preview '[[ -f $realpath ]] && bat --style=numbers --color=always $realpath 2>/dev/null || eza -1 --icons --color=always $realpath 2>/dev/null || ls -1 --color=always $realpath'

# Preivew `kill` and `ps` commands
zstyle ':completion:*:*:*:*:processes' command 'ps -u $USER -o pid,user,comm -w -w'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview \
       '[[ $group == "[process ID]" ]] &&
        if [[ $OSTYPE == darwin* ]]; then
           ps -p $word -o comm="" -w -w
        elif [[ $OSTYPE == linux* ]]; then
           ps --pid=$word -o cmd --no-headers -w -w
        fi'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags '--preview-window=down:3:wrap'
zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'

# Preivew `git` commands
zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview \
	   'git diff $word | delta'
zstyle ':fzf-tab:complete:git-log:*' fzf-preview \
	   'git log --color=always $word'
zstyle ':fzf-tab:complete:git-help:*' fzf-preview \
	   'git help $word | bat -plman --color=always'
zstyle ':fzf-tab:complete:git-show:*' fzf-preview \
	   'case "$group" in
	"commit tag") git show --color=always $word ;;
	*) git show --color=always $word | delta ;;
	esac'
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':fzf-tab:complete:git-checkout:*' fzf-preview \
	   'case "$group" in
	"modified file") git diff $word | delta ;;
	"recent commit object name") git show --color=always $word | delta ;;
	*) git log --color=always $word ;;
	esac'

# Privew help
zstyle ':fzf-tab:complete:(\\|)run-help:*' fzf-preview 'run-help $word'
zstyle ':fzf-tab:complete:(\\|*/|)man:*' fzf-preview 'man $word'
# Privew brew
zstyle ':fzf-tab:complete:brew-(install|uninstall|search|info):*-argument-rest' fzf-preview 'brew info $word'
# Privew tldr
zstyle ':fzf-tab:complete:tldr:argument-1' fzf-preview 'tldr --color always $word'

zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:accept
zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ":completion:*:git-checkout:*" sort false
zstyle ':completion:*' file-sort modification
zstyle ':completion:*:eza' sort false
zstyle ':completion:files' sort false
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':fzf-tab:*:*argument-rest*' popup-pad 100 0
zstyle ':completion:*' menu no

# chopin lazy
#zinit ice as"program" pick"lazy" atclone"cargo install --path ." lucid wait"1"
#zinit light zetatez/lazy

# cheat.sh
zinit wait'2a' lucid \
  id-as'cht.sh' \
  as'program' \
  for https://cht.sh/:cht.sh
zinit wait'2b' lucid \
  id-as'cht-completion' \
  has'rlwrap' \
  mv'cht* -> _cht' \
  as'completion' \
  for https://cheat.sh/:zsh

zi wait'2c' lucid for \
    https://github.com/junegunn/fzf/raw/master/shell/{'completion','key-bindings'}.zsh \
    https://raw.githubusercontent.com/cheat/cheat/master/scripts/cheat.zsh

zinit as="completion" for \
    OMZP::rust/_rustc \

# Zoxide
if (( $+commands[zoxide] )); then
    eval "$(zoxide init zsh)"
    export _ZO_FZF_OPTS="--scheme=path --tiebreak=end,chunk,index --bind=ctrl-z:ignore,btab:up,tab:down --cycle --keep-right --border=sharp --height=45% --info=inline --layout=reverse --tabstop=1 --exit-0 --select-1 --preview '(eza --tree --icons --level 3 --color=always --group-directories-first {2} || tree -NC {2} || ls --color=always --group-directories-first {2}) 2>/dev/null | head -200'"
fi

# Homebrew completion
if type brew &>/dev/null; then
    FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
    autoload -Uz compinit
    compinit
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# atuin
eval "$(atuin init zsh)"

#########################################################################
# ENV VARIABLE
#########################################################################
## alias env ====
source $HOME/.zsh_aliases

#set Editor
export VISUAL=nvim
export EDITOR="$VISUAL"

# npm
#PATH="$HOME/.node_modules/bin:$PATH"
#export npm_config_prefix=~/.node_modules

# NNN
export NNN_PLUG='f:finder;o:fzopen;p:preview-tabbed;d:diffs;v:imgview,c:fzcd;t:preview-tui'
# NNN bookmark
export NNN_BMS='i:~/Pictures/Wallpapers;n:~/Documents/Notes'
export NNN_SEL='/tmp/.sel'
export NNN_FIFO='/tmp/nnn.fifo'

# rg
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
# fzf
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git || git ls-tree -r --name-only HEAD || rg --files --hidden --follow --glob '!.git' || find ."
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview '(bat --style=numbers --color=always {} || cat {} || tree -NC {}) 2>/dev/null | head -200'"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview' --exact"
export FZF_ALT_C_OPTS="--preview '(eza --tree --icons --level 3 --color=always --group-directories-first {} || tree -NC {} || ls --color=always --group-directories-first {}) 2>/dev/null | head -200'"

# FZF custom OneDark theme
#export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS' --ansi
# --color=fg:#D8DEE9,bg:-1,hl:#A3BE8C
# --color=fg+:#D8DEE9,bg+:#191e2a,hl+:#ffcc66
# --color=info:#DDB6F2,prompt:#be5046,pointer:#45cdff
# --color=marker:#73d0ff,spinner:#73d0ff,header:#d4bfff'

export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS' --ansi
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

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
export NVM_COMPLETION=true
export NVM_SYMLINK_CURRENT="true"

# cheat
export CHEAT_USE_FZF=true

## func ===========================================================================================
rga-fzf() {
	RG_PREFIX="rga --files-with-matches"
	local file
	file="$(
		FZF_DEFAULT_COMMAND="$RG_PREFIX '$1'" \
			fzf --sort --preview="[[ ! -z {} ]] && rga --pretty --context 5 {q} {}" \
				--phony -q "$1" \
				--bind "change:reload:$RG_PREFIX {q}" \
				--preview-window="70%:wrap"
	)" &&
	echo "opening $file" &&
	xdg-open "$file"
}

#export CLASSPATH=~/Projects/IdeaProjects/ucb_cs61b_software_2022sp-master/lib/*

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Added by Windsurf
export PATH="/Users/cancel/.codeium/windsurf/bin:$PATH"

#go
export GOPATH=$HOME/Projects/go
