-- Default settings: Hard tabs
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false
vim.opt.colorcolumn = "81"

local function set_hard_tabs()
  vim.opt.tabstop = 4
  vim.opt.shiftwidth = 4
  vim.opt.expandtab = false
end

local function set_soft_tabs()
  vim.opt_local.tabstop = 2
  vim.opt_local.softtabstop = 2
  vim.opt_local.shiftwidth = 2
  vim.opt_local.expandtab = true
end

-- https://vi.stackexchange.com/questions/39285/is-it-possible-to-set-a-vim-api-nvim-create-autocmd-for-a-filetype-not-just-a-p
vim.api.nvim_create_autocmd("FileType", {
  --pattern = "lua,python,javascript,typescript",
  pattern = "lua",
  callback = set_soft_tabs,
})

-- Makefiles require tab characters/hardtabs to be used
vim.api.nvim_create_autocmd("FileType", {
  pattern = "make",
  callback = set_hard_tabs,
})
