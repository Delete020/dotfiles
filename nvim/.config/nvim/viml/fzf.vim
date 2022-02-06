"" fzf ""
let $FZF_DEFAULT_COMMAND = 'fd --type f --color=always --exclude .git --ignore-file ~/.gitignore'
let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline'

nnoremap <silent> <C-p> :Files<CR>
" let $FZF_DEFAULT_OPTS='--reverse'
map <leader>f :Files<cr>
map <lnnoremap <silent> <C-p> :Files<CR>eader>fg :GFiles<cr>

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' } 
