DISABLE_MAGIC_FUNCTIONS=true
# ==== history ====
HISTSIZE=1000000                  # maximum history size in terminal's memory
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
      OMZP::git \
      OMZP::docker \
      OMZP::brew \
      OMZP::sudo

# ==== zinit plugins ====
zinit ice as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull"%atclone" src"init.zsh"
zinit light starship/starship

# fzf-tab ====
# fzf is sourced after fzf-tab so its `**<Tab>` completion wraps fzf-tab-complete;
# empty FZF_CTRL_R_COMMAND keeps fzf off ^R, which belongs to atuin
zinit ice wait lucid depth"1" atload"zicompinit; zicdreplay; FZF_CTRL_R_COMMAND= source <(fzf --zsh)" blockf
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
    atclone="gdircolors -b LS_COLORS > c.zsh" atpull='%atclone' pick='c.zsh' \
    atload'zstyle ":completion:*" list-colors ${(s.:.)LS_COLORS}' \
    trapd00r/LS_COLORS \
    as="program" atclone="rm -f ^(rgg|agv)" \
    lilydjwg/search-and-view

zinit as"program" make'!' atclone'./direnv hook zsh > zhook.zsh' \
    atpull'%atclone' pick"direnv" src"zhook.zsh" for \
        direnv/direnv

zstyle ':fzf-tab:*' switch-group ',' '.'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

zstyle ':completion:*:descriptions' format '[%d]'
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

zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:down,shift-tab:up
zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':completion:*' file-sort modification
zstyle ':completion:*:eza' sort false
zstyle ':completion:files' sort false
zstyle ':fzf-tab:*:*argument-rest*' popup-pad 100 0
zstyle ':completion:*' menu no

zinit as="completion" for \
    OMZP::rust/_rustc \

# Zoxide
if (( $+commands[zoxide] )); then
    eval "$(zoxide init zsh)"
fi

# atuin
eval "$(atuin init zsh)"
# pyenv
eval "$(pyenv init -)"

#########################################################################
# ENV VARIABLE
#########################################################################
## alias env ====
source $HOME/.zsh_aliases

# Re-source env vars: /etc/zprofile's path_helper pushed our PATH entries behind system dirs
source $HOME/.dotfiles/zsh/.zshenv

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
