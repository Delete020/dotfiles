vim.g.mapleader = " "

local opts = {noremap = true, silent = true}
local normal = 'n'
local visual = 'v'
-- local command = 'c'
-- local insert = 'i'
-- local term = 't'
-- local visual_block = 'x'

vim.keymap.set(normal, "<leader>pv", vim.cmd.Ex)

vim.keymap.set(normal, "<Left>", "<esc>:echoe \"Use h\"<CR>")
vim.keymap.set(normal, "<Right>", "<esc>:echoe \"Use l\"<CR>")
vim.keymap.set(normal, "<Up>", "<esc>:echoe \"Use k\"<CR>")
vim.keymap.set(normal, "<Down>", "<esc>:echoe \"Use j\"<CR>")

vim.keymap.set(normal, "sk", "<esc>:set nosplitright<CR>:vsplit<CR>")

-- navigate splits
vim.keymap.set(normal, '<c-h>', '<c-w>h', opts)
vim.keymap.set(normal, '<c-j>', '<c-w>j', opts)
vim.keymap.set(normal, '<c-k>', '<c-w>k', opts)
vim.keymap.set(normal, '<c-l>', '<c-w>l', opts)

vim.keymap.set(visual, "J", ":m '>+1<CR>gv=gv")
vim.keymap.set(visual, "K", ":m '<-2<CR>gv=gv")

-- keeping cursor in the middle
vim.keymap.set(normal, "J", "mzJ`z")
vim.keymap.set(normal, "<C-d>", "<C-d>zz")
vim.keymap.set(normal, "<C-u>", "<C-u>zz")
vim.keymap.set(normal, "n", "nzzzv")
vim.keymap.set(normal, "N", "Nzzzv")

-- greatest remap ever, after paste ain't change register
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
-- also copy to system clipboard
vim.keymap.set({normal, visual}, "<leader>y", [["+y]])
vim.keymap.set(normal, "<leader>Y", [["+Y]])

vim.keymap.set({normal, visual}, "<leader>d", [["_d]])

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set(normal, "Q", "<nop>")
vim.keymap.set(normal, "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set(normal, "<leader>f", vim.lsp.buf.format)

vim.keymap.set(normal, "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set(normal, "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set(normal, "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set(normal, "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set(normal, "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set(normal, "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set(normal, "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>")
vim.keymap.set(normal, "<leader><C-s>", "<cmd>SudaWrite<CR>")
vim.keymap.set(normal, "<leader>uu", "<cmd>PackerSync<CR>")
