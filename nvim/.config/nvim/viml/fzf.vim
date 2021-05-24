"" fzf ""
let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline'
" let $FZF_DEFAULT_OPTS='--reverse'
map <leader>f :Files<cr>
map <leader>fg :GFiles<cr>

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' } 
