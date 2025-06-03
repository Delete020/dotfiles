vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true

-- fix markdown indentation settings
vim.g.markdown_recommended_style = 0

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

local opt = vim.opt

opt.nu = true
opt.relativenumber = true

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
-- always uses spaces instead of tab characters
opt.expandtab = true
opt.breakindent = true
opt.smartindent = true

opt.wrap = false

opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

opt.hlsearch = true
opt.incsearch = true
opt.inccommand = 'split'

opt.termguicolors = true

opt.scrolloff = 8
opt.signcolumn = "yes"
opt.isfname:append("@-@")

opt.updatetime = 250
opt.timeoutlen = 300

opt.colorcolumn = "80"

opt.smarttab = true
opt.cindent = true

-- search
opt.ignorecase = true
opt.smartcase = true

opt.backspace = {'eol', 'start', 'indent'}

opt.mouse = 'a'
-- Show which line your cursor is on
opt.cursorline = true
opt.wildignore:append({'*.pyc', '*_build/*', '**/coverage/*', '**/node_modules/*', '**/.git/*','*.so', '*.o'})
opt.wildmenu = true

opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200 -- save swap file and trigger CursorHold

opt.autowrite = true -- enable auto write
opt.joinspaces = false -- No double spaces with join after a dot
opt.laststatus = 0
opt.list = true -- Show some invisible characters (tabs...
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
opt.grepprg = "rg --vimgrep"
opt.clipboard:append("unnamedplus")

-- Configure how new splits should be opened
opt.splitright = true
opt.splitbelow = true