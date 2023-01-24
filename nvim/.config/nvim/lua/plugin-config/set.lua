local opt = vim.opt

opt.nu = true
opt.relativenumber = true

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
-- always uses spaces instead of tab characters
opt.expandtab = true

opt.smartindent = true

opt.wrap = false

opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

opt.hlsearch = true
opt.incsearch = true

opt.termguicolors = true

opt.scrolloff = 8
opt.signcolumn = "yes"
opt.isfname:append("@-@")

opt.updatetime = 50

opt.colorcolumn = "80"

opt.smarttab = true
opt.cindent = true

-- search
opt.ignorecase = true
opt.smartcase = true

opt.backspace = {'eol', 'start', 'indent'}

opt.mouse = 'a'
opt.wildignore:append({'*.pyc', '*_build/*', '**/coverage/*', '**/node_modules/*', '**/.git/*','*.so', '*.o'})
opt.wildmenu = true

opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200 -- save swap file and trigger CursorHold

opt.autowrite = true -- enable auto write
opt.joinspaces = false -- No double spaces with join after a dot
opt.laststatus = 0
opt.list = true -- Show some invisible characters (tabs...
opt.grepprg = "rg --vimgrep"

-- fix markdown indentation settings
vim.g.markdown_recommended_style = 0
