-- Autocommands
-- :help autocommands
-- :help events

-- TJ DeVries - [Demo] Lua Autocmd Patterns
-- https://www.youtube.com/watch?v=HR1dKKrOmDs

-- TJ DeVries - [Demo] Lua Augroups - Why And How To Use?
-- https://www.youtube.com/watch?v=F6GNPOXpfwU

-- See also:
-- https://itmecho.com/blog/neovim-lua-hooks-with-user-events

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight yanked selection',
  -- https://neovim.io/doc/user/lua.html#vim.hl
  group = vim.api.nvim_create_augroup('highlight_yanked_selection', { clear = true }),
  pattern = '*',
  callback = function()
    vim.hl.on_yank({ higroup = 'IncSearch' })
  end
})

vim.api.nvim_create_autocmd('BufWinEnter', {
  desc = 'Automatically make the help window the only one on the screen.',
  -- https://vi.stackexchange.com/a/39697
  group = vim.api.nvim_create_augroup('maximize_help', { clear = true }),
  pattern = '*.txt',
  callback = function()
    if vim.o.filetype == 'help' then vim.cmd.wincmd('o') end
  end
})

vim.api.nvim_create_autocmd('TermOpen', {
  desc = 'Automatically enter INSERT mode upon opening a terminal.',
  -- https://vi.stackexchange.com/questions/3670/how-to-enter-insert-mode-when-entering-neovim-terminal-pane
  -- https://github.com/nvim-neotest/neotest/issues/2#issuecomment-1149532666
  group = vim.api.nvim_create_augroup('enter_insert_mode_upon_opening_term', { clear = true }),
  pattern = '*',
  callback = function()
    if vim.startswith(vim.api.nvim_buf_get_name(0), 'term://') then
      vim.cmd('startinsert')
    end
  end
})

vim.api.nvim_create_autocmd('TermClose', {
  desc = 'Automatically close terminal buffer when process exits',
  -- when the process exits successfully (pressing Ctrl + d),
  -- or when using the exit command in fish. See:
  -- https://fishshell.com/docs/current/cmds/exit.html
  group = vim.api.nvim_create_augroup('close_terminal_buffer_when_process_exits', { clear = true }),
  pattern = '*',
  callback = function()
    local status = vim.v.event.status
    if status == 0 or status == 255 then
      vim.cmd('bdelete! ' .. vim.fn.expand('<abuf>'))
    end
  end
})
