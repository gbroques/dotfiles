return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate', -- Update installed parsers when upgrading plugin
    commit = '42fc28ba918343ebfd5565147a42a26580579482',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      {
        'tronikelis/ts-autotag.nvim',
        commit = '0f1dc38fddd99b468ef58938d7cd99ce1d6bcb0e',
        config = true
      },
      {
        'HiPhish/rainbow-delimiters.nvim',
        commit = '55ad4fb76ab68460f700599b7449385f0c4e858e'
      },
      {
        'nvim-treesitter/nvim-treesitter-textobjects',
        dependencies = 'nvim-treesitter/nvim-treesitter',
        commit = '89ebe73cd2836db80a22d9748999ace0241917a5'
      },
      {
        'JoosepAlviste/nvim-ts-context-commentstring'
      }
      -- TODO: nvim-treesitter/nvim-treesitter-context for easier function navigation
      --       with relative line numbers.
      --       See https://youtu.be/uL9oOZStezw?t=291
    },
    config = function()
      require('nvim-treesitter.configs').setup({
        highlight = { enable = true },
        incremental_selection = { enable = true },
        indent = { enable = true },
        autopairs = { enable = true },
        rainbow = { enable = true },
        textobjects = {
          select = {
            enable = true,
            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,
            keymaps = {
              -- Text objects
              -- TODO: Add assignment and property text object?
              --       See https://www.josean.com/posts/nvim-treesitter-and-textobjects
              ['aa'] = { query = '@parameter.outer', desc = 'an argument' },
              ['ia'] = { query = '@parameter.inner', desc = 'inner argument' },
              ['ac'] = { query = '@class.outer', desc = 'a class' },
              ['ic'] = { query = '@class.inner', desc = 'inner class' },
              ['ad'] = { query = '@conditional.outer', desc = 'a decision or con(d)itional' },
              ['id'] = { query = '@conditional.inner', desc = 'inner decision or con(d)itional' },
              ['af'] = { query = '@function.outer', desc = 'a function' },
              ['if'] = { query = '@function.inner', desc = 'inner function' },
              ['al'] = { query = '@loop.outer', desc = 'a loop' },
              ['il'] = { query = '@loop.inner', desc = 'inner loop' },
              ['ar'] = { query = '@return.outer', desc = 'a return statement' },
              ['ir'] = { query = '@return.inner', desc = 'inner return statement' },
              -- Mnemonic: "Attr" sounds like "adder" which is close to the "add" symbol "+"
              --           rotated 45 degrees gives you x.
              --           x is also used for HTML / XML attributes in chrisgrieser/nvim-various-textobjs.
              --           Supported in HTML and JavaScript.
              ['ax'] = { query = '@attribute.outer', desc = 'a attribute' },
              ['ix'] = { query = '@attribute.inner', desc = 'inner attribute' },
            },
            include_surrounding_whitespace = function(table)
              -- Only include surrounding whitespace for outer text objects when deleting.
              if vim.endswith(table.query_string, 'outer') and vim.v.operator == 'd' then
                return true
              end
              return false
            end
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              -- Override builtin gf 'goto file' as it's more ergonomic than ]m
              -- Also gd usually goes to the file with an LSP server
              ['gf'] = { query = '@function.outer', desc = 'Goto next function' },
              [']]'] = { query = '@class.outer', desc = 'Next class start' },
            },
            goto_next_end = {
              [']M'] = { query = '@function.outer', desc = 'Next method end' },
              [']['] = { query = '@class.outer', desc = 'Next class end' },
            },
            goto_previous_start = {
              -- Override builtin gF 'goto file' as it's more ergonomic than [m
              -- Also gd usually goes to the file with an LSP server
              ['gF'] = { query = '@function.outer', desc = 'Goto previous function' },
              ['[['] = { query = '@class.outer', desc = 'Previous class start' },
            },
            goto_previous_end = {
              ['[M'] = { query = '@function.outer', desc = 'Previous method end' },
              ['[]'] = { query = '@class.outer', desc = 'Previous class end' },
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ['<leader>rs'] = { query = '@parameter.inner', desc = 'Swap next' },
            },
            swap_previous = {
              ['<leader>rS'] = { query = '@parameter.inner', desc = 'Swap previous' },
            },
          },
        }
      })
    end
  },

}
