return {
  {
    'kevinhwang91/nvim-ufo',
    commit = '80fe8215ba566df2fbf3bf4d25f59ff8f41bc0e1',
    -- Use lazy = false instead of BufReadPre or BufNewFile to fix
    -- index out of bounds error:
    -- https://github.com/kevinhwang91/nvim-ufo/issues/235
    -- event = { 'BufReadPre', 'BufNewFile' },
    lazy = false,
    dependencies = {
      {
        'kevinhwang91/promise-async',
        commit = '119e8961014c9bfaf1487bf3c2a393d254f337e2'
      }
    },
    config = function()
      -- See also lsp.lua for advertising foldingRange capability to LSP servers.
      vim.o.foldcolumn = '0'
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
      vim.o.foldtext = ''
      local ufo = require('ufo')
      ufo.setup({
        provider_selector = function(bufnr, filetype, buftype)
          -- Use treesitter for Markdown folds like LazyVim:
          -- https://github.com/LazyVim/LazyVim/blob/v15.13.0/lua/lazyvim/util/treesitter.lua#L46-L48
          -- https://youtu.be/EYczZLNEnIY?list=PLZWMav2s1MZQnIfyXOQRaqwp7QAFtDPVk&t=67
          if filetype == 'markdown' then
            return { 'treesitter', 'indent' }
          end
          return { 'lsp', 'indent' }
        end
      })

      -- Keymaps
      vim.keymap.set('n', 'zR', ufo.openAllFolds)
      vim.keymap.set('n', 'zM', ufo.closeAllFolds)
    end
  },
}
