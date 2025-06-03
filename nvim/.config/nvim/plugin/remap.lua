local opts = {noremap = true, silent = true}
local normal = "n"
local visual = "v"
-- local command = "c"
-- local insert = "i"
-- local term = "t"
-- local visual_block = "x"
function CreateNoremap(type, opts)
	return function(lhs, rhs, bufnr)
		bufnr = bufnr or 0
		vim.api.nvim_buf_set_keymap(bufnr, type, lhs, rhs, opts)
	end
end

Nnoremap = CreateNoremap("n", { noremap = true })
Inoremap = CreateNoremap("i", { noremap = true })

local set = vim.keymap.set

set(normal, "<leader>pv", vim.cmd.Ex)
set(normal, "<Esc>", "<cmd>nohlsearch<CR>")

set(normal, "<Left>", "<esc>:echoe \"Use h\"<CR>")
set(normal, "<Right>", "<esc>:echoe \"Use l\"<CR>")
set(normal, "<Up>", "<esc>:echoe \"Use k\"<CR>")
set(normal, "<Down>", "<esc>:echoe \"Use j\"<CR>")

-- Diagnostic keymaps
set(normal, "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
set(normal, "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
set(normal, "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
set(normal, "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

set(normal, "sk", "<esc>:set nosplitright<CR>:vsplit<CR>")

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
set(normal, "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
set(normal, "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
set(normal, "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
set(normal, "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- These mappings control the size of splits (height/width)
set(normal, "<M-,>", "<c-w>5<")
set(normal, "<M-.>", "<c-w>5>")
set(normal, "<M-t>", "<C-W>+")
set(normal, "<M-s>", "<C-W>-")

set(visual, "J", ":m '>+1<CR>gv=gv")
set(visual, "K", ":m '<-2<CR>gv=gv")

-- keeping cursor in the middle
set(normal, "J", "mzJ`z")
set(normal, "<C-d>", "<C-d>zz")
set(normal, "<C-u>", "<C-u>zz")
set(normal, "n", "nzzzv")
set(normal, "N", "Nzzzv")

-- greatest remap ever, after paste ain"t change register
set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
-- also copy to system clipboard
set({normal, visual}, "<leader>y", [["+y]])
set(normal, "<leader>Y", [["+Y]])

set({normal, visual}, "<leader>d", [["_d]])

-- This is going to get me cancelled
set("i", "<C-c>", "<Esc>")

set(normal, "Q", "<nop>")
set(normal, "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
set(normal, "<leader>f", vim.lsp.buf.format)

set(normal, "<C-k>", "<cmd>cnext<CR>zz")
set(normal, "<C-j>", "<cmd>cprev<CR>zz")
set(normal, "<leader>k", "<cmd>lnext<CR>zz")
set(normal, "<leader>j", "<cmd>lprev<CR>zz")

set(normal, "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
set(normal, "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

set(normal, "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>")
set(normal, "<leader><C-s>", "<cmd>SudaWrite<CR>")
set(normal, "<A-u>", "<cmd>Lazy sync<CR>")
