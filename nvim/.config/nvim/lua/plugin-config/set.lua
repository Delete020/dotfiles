--vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
-- always uses spaces instead of tab characters
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.opt.smarttab = true
vim.opt.cindent = true

-- search
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.backspace = {'eol', 'start', 'indent'}

vim.opt.mouse = 'a'
vim.opt.wildignore:append({'*.pyc', '*_build/*', '**/coverage/*', '**/node_modules/*', '**/.git/*','*.so', '*.o'})
vim.opt.wildmenu = true
--vim.opt.wildmode = 'list:longest,full'
