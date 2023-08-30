vim.opt.title = true

-- Enable line numbers
vim.opt.number = true
-- Make line numbers relative to the cursor
vim.opt.relativenumber = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 11
vim.opt.sidescrolloff = 5

-- Indicate tabs and trailing spaces
-- listchars var defines the characters that indicate whitespace
vim.opt.list = true

vim.opt.smartindent = true

-- Wildmenu ignore files
vim.opt.wildignore = { '*.o', '*.a', '*.pyc', '__pycache__' }

vim.opt.foldenable = true
-- Folds text inside {{{'}}} by default
vim.opt.foldmethod = "marker"

vim.opt.wrap = false
-- Modelines have historically been a source of security vulnerabilities
vim.opt.modeline = false

-- Disable backup files
vim.opt.swapfile = false
vim.opt.backup = false
-- https://vi.stackexchange.com/questions/9570/how-do-i-shadont
-- vim.opt.shada = "NONE"
-- Disable netrw history (cuz it's really annoying)
vim.g.netrw_dirhistmax = 0

-- Case insensitive search and highlight
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Completion Menu Settings
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.complete = ".,w,b,u,t"

-- Status line
vim.opt.laststatus = 2
vim.opt.showcmd = true
vim.opt.showmode = true
