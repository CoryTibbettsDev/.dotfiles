-- This file must be required before loading plugins so correct leader key is set
-- A bunch of keymappings

vim.g.mapleader = " "
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "<leader>s", vim.cmd.write)
vim.keymap.set("n", "<leader>m", vim.cmd.make)

-- Source current file
vim.keymap.set("n", "<leader>r", vim.cmd.source)
-- Source $MYVIMRC
vim.keymap.set("n", "<leader>r", ":source $MYVIMRC<CR>")

vim.keymap.set({"n", "v"}, "<leader>f", vim.cmd.Ex)

-- xclip is needed for paste and yank with system clipboard
-- For some reason leader key with this binding is slow but not with control
-- Paste from system clipboard
vim.keymap.set("n", "<C-p>", '"+p')
-- Yank into system clipboard
vim.keymap.set("n", "<C-y>", '"+y')

-- Map <C-L> (redraw screen) to also turn off search highlighting until the
-- next search
vim.keymap.set("n", "<C-L>", ":nohl<CR><C-L>")

-- Tab management
vim.keymap.set("n", "<leader>n", ":tabnew<Space>")
vim.keymap.set("n", "<leader>c", vim.cmd.tabclose)
vim.keymap.set("n", "<leader>k", vim.cmd.tabnext)
vim.keymap.set("n", "<leader>j", vim.cmd.tabprev)
vim.keymap.set("n", "<leader>h", vim.cmd.tabfirst)
vim.keymap.set("n", "<leader>l", vim.cmd.tablast)

-- Quickfix list shortcuts
-- https://github.com/tpope/vim-unimpaired
vim.keymap.set("n", "[q", vim.cmd.cprev)
vim.keymap.set("n", "]q", vim.cmd.cnext)