-- Default settings: Hard tabs
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false
vim.opt.colorcolumn = "81"

local function hard_tabs()
  vim.opt.tabstop = 4
  vim.opt.shiftwidth = 4
  vim.opt.expandtab = false
end

local function soft_tabs()
  vim.opt_local.tabstop = 4
  vim.opt_local.softtabstop = 4
  vim.opt_local.shiftwidth = 4
  vim.opt_local.expandtab = true
end

local function soft_tabs_2()
  vim.opt_local.tabstop = 2
  vim.opt_local.softtabstop = 2
  vim.opt_local.shiftwidth = 2
  vim.opt_local.expandtab = true
end

-- https://vi.stackexchange.com/questions/39285/is-it-possible-to-set-a-vim-api-nvim-create-autocmd-for-a-filetype-not-just-a-p

-- PEP 8, the style guide for python, specifies the use of
-- spaces aka softtabs this is because they are morons
-- Haskell compiler (GHC) is picky about whitespace
-- using four spaces as a tab aka softtabs is generally safer and easier
-- Settings for softtabs
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python,javascript,typescript,haskell",
  callback = soft_tabs,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua,json,lisp",
  callback = soft_tabs_2,
})

-- Python does not want lines to exceed 79 characters instead of the normal 80
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function(ev)
    vim.opt.colorcolumn = "80"
  end
})

-- https://lisp-lang.org/style-guide/
-- https://google.github.io/styleguide/lispguide.xml
vim.api.nvim_create_autocmd("FileType", {
  pattern = "lisp",
  callback = function(ev)
    vim.opt.colorcolumn = "100"
  end
})

-- Makefiles require tab characters/hardtabs to be used
vim.api.nvim_create_autocmd("FileType", {
  pattern = "make",
  callback = hard_tabs,
})
