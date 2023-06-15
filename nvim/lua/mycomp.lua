-- automatically call autocomplete popup plugin
-- https://github.com/jacobsimpson/nvim-example-lua-plugin
if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for mycomp! | echohl None"')
  return
end

local min_length = 2

local augroup = vim.api.nvim_create_augroup('mycomp', {clear = true})

local function popup_next()
  key = vim.api.nvim_replace_termcodes("<C-n>", true, false, true)
  vim.api.nvim_feedkeys(key, 'n', false)
end

local function remap_tab()
  vim.keymap.set('i', '<Tab>', function()
    return vim.fn.pumvisible() == 1 and "<C-n>" or "<Tab>"
  end, { expr = true })
  -- end, { expr = true, buffer = true })
  vim.keymap.set('i', '<S-Tab>', function()
    return vim.fn.pumvisible() == 1 and "<C-p>" or "<S-Tab>"
  end, { expr = true })
  -- end, { expr = true, buffer = true })
end

-- Get word before cursor
local function get_context()
  return vim.fn.strpart(vim.fn.getline('.'), 0, vim.fn.col('.') - 1)
end

--local function meets_keyword(context)
--  if min_length <= 0 then
--    return 0
--  end
--  local matches = vim.fn.matchlist(a:context, '\(\k\{' . min_length . ',}\)$')
--  if vim.fn.empty(matches) == 1 then
--    return 0
--  end
--  -- for ignore in g:myacp_key_ignore
--  --   if stridx(ignore, matches[1]) == 0
--  --     return 0
--  --   endif
--  -- endfor
--  return 1
--end

local function feed_popup()
  -- Not visible
  if vim.fn.pumvisible() == 0 then
    if (vim.fn.strchars(get_context()) >= min_length) then
      popup_next()
    end
  end
end

local function setup()
  vim.api.nvim_create_autocmd("CursorMovedI", {
    group = augroup,
    pattern = {"*.c", "*.h"},
    -- pattern = {"*"},
    callback = feed_popup,
  })

  remap_tab()
end

return {
  setup = setup,
}
