## p10k ============================================================================================
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# omz ==============================================================================================
export ZSH="/home/cancel/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git sudo systemd archlinux history tmux docker docker-compose)

DISABLE_MAGIC_FUNCTIONS=true
source $ZSH/oh-my-zsh.sh

## history =========================================================================================
HISTSIZE=10000                  # maximum history size in terminal's memory
SAVEHIST=1000000                # maximum size of history file
setopt HIST_IGNORE_SPACE        # ignore commands with leading space
setopt HIST_IGNORE_DUPS         # do not put duplicated command into history list
setopt HIST_REDUCE_BLANKS       # remove unnecessary blanks
setopt INC_APPEND_HISTORY       # append command to history file immediately after execution

## Zinit ===========================================================================================
source ~/.zinit/bin/zinit.zsh
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

## zinit plugins ===================================================================================

zinit light-mode for \
    blockf \
        zsh-users/zsh-completions

# 快速目录跳转
zinit ice lucid wait='0'
zinit light skywind3000/z.lua

# fzf-tab ===========================================================
zinit ice wait lucid depth"1" atload"zicompinit; zicdreplay" blockf
zinit light Aloxaf/fzf-tab

zstyle ':fzf-tab:*' switch-group ',' '.'

zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:complete:*:options' sort false
zstyle ':fzf-tab:complete:(cd|ls|exa|bat|cat|emacs|vi|vim|nvim):*' fzf-preview 'exa -1 --color=always $realpath 2>/dev/null'
zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' \
	   fzf-preview 'echo ${(P)word}'

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

# zstyle ":fzf-tab:*" fzf-flags --color=bg+:+23
zstyle ":completion:*:git-checkout:*" sort false
zstyle ':completion:*' file-sort modification
zstyle ':completion:*:exa' sort false
zstyle ':completion:files' sort false
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':fzf-tab:*:*argument-rest*' popup-pad 100 0

# 高亮 自动建议
zinit wait lucid for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
 atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions \
 pick"git-it-on.plugin.zsh" \
    peterhurford/git-it-on.zsh 

zinit wait="1" lucid light-mode for \
    kevinhwang91/zsh-tmux-capture \
    hlissner/zsh-autopair \
    hchbaw/zce.zsh \
    Aloxaf/gencomp \
    wfxr/forgit \

# chopin
zinit ice as"program" pick"chopin" wait"0" lucid
zinit light zetatez/chopin

# mcfly
zinit ice lucid wait"0a" from"gh-r" as"program" atload'eval "$(mcfly init zsh)"' 
zinit light cantino/mcfly

# enhancd
zinit ice as"program" pick"init.sh" wait"2" lucid
zinit light b4b4r07/enhancd
export ENHANCD_FILTER=fzf:fzy:peco

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

zinit as="completion" for \
    OMZP::fd/_fd \
    OMZP::rust/_rustc

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

## alias env ===========================================================================================
source $HOME/.zsh_aliases
# bindkey -v
# eval "$(zoxide init zsh)"

#set Editor
export VISUAL=nvim
export EDITOR="$VISUAL"
export FZF_DEFAULT_COMMAND='fd --type f'

# npm
PATH="$HOME/.node_modules/bin:$PATH"
export npm_config_prefix=~/.node_modules

# NNN
export NNN_PLUG='f:finder;o:fzopen;p:preview-tabbed;d:diffs;v:imgview,c:fzcd;t:preview-tui'
# NNN bookmark
export NNN_BMS='i:~/Pictures/Wallpapers;n:~/Documents/Notes'
export NNN_SEL='/tmp/.sel'
export NNN_FIFO='/tmp/nnn.fifo'

# rg
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

## fzf
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2>/dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS='--preview="bat --color=always --style=header {} 2>/dev/null" --preview-window=right:60%:wrap'
export FZF_ALT_C_COMMAND='fd -t d -d 1'
export FZF_ALT_C_OPTS='--preview="exa -1 --icons --git --git-ignore {}" --preview-window=right:60%:wrap'

# FZF custom OneDark theme
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS' --ansi
 --color=fg:#D8DEE9,bg:-1,hl:#A3BE8C
 --color=fg+:#D8DEE9,bg+:#191e2a,hl+:#ffcc66
 --color=info:#DDB6F2,prompt:#be5046,pointer:#45cdff
 --color=marker:#73d0ff,spinner:#73d0ff,header:#d4bfff'

# fzf catppuccin
#export FZF_DEFAULT_OPTS='--color=bg+:#302D41,bg:-1,spinner:#F8BD96,hl:#F28FAD --color=fg:#D9E0EE,header:#F28FAD,info:#DDB6F2,pointer:#F8BD96 --color=marker:#F8BD96,fg+:#F2CDCD,prompt:#DDB6F2,hl+:#F28FAD'

 # mdv
export MDV_THEME="729.8953"
export MDV_CODE_THEME="729.8953"

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

# To customize prompt, run `p10k configure` or edit ~/.dotfiles/zsh/.p10k.zsh.
[[ ! -f ~/.dotfiles/zsh/.p10k.zsh ]] || source ~/.dotfiles/zsh/.p10k.zsh
