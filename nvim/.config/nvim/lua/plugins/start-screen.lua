return {
  {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    commit = '2b3cbcdd980cae1e022409289245053f62fb50f6',
    event = 'VimEnter',
    config = function()
      local alpha = require('alpha')
      local startify = require('alpha.themes.startify')
      startify.section.header.val = {
        -- Source: https://github.com/MaximilianLloyd/ascii.nvim/blob/master/lua/ascii/text/neovim.lua#L21-L32
        -- See: https://patorjk.com/software/taag/#p=display&f=Graffiti&t=Type%20Something%20
        [[                                                                       ]],
        [[  ██████   █████                   █████   █████  ███                  ]],
        [[ ░░██████ ░░███                   ░░███   ░░███  ░░░                   ]],
        [[  ░███░███ ░███   ██████   ██████  ░███    ░███  ████  █████████████   ]],
        [[  ░███░░███░███  ███░░███ ███░░███ ░███    ░███ ░░███ ░░███░░███░░███  ]],
        [[  ░███ ░░██████ ░███████ ░███ ░███ ░░███   ███   ░███  ░███ ░███ ░███  ]],
        [[  ░███  ░░█████ ░███░░░  ░███ ░███  ░░░█████░    ░███  ░███ ░███ ░███  ]],
        [[  █████  ░░█████░░██████ ░░██████     ░░███      █████ █████░███ █████ ]],
        [[ ░░░░░    ░░░░░  ░░░░░░   ░░░░░░       ░░░      ░░░░░ ░░░░░ ░░░ ░░░░░  ]],
        [[                                                                       ]],
      }
      startify.section.top_buttons.val = {}
      -- Move 'edit new buffer' to bottom buttons
      startify.section.bottom_buttons.val = {
        startify.button("b", "New", "<cmd>enew <CR>"),
        startify.button("q", "Quit", "<cmd>q <CR>"),
      }
      -- disable global MRU
      startify.section.mru.val = { { type = "padding", val = 0 } }

      --- @param cwd string? optional
      local stats = require("lazy").stats()
      local setFooter = function()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        local footer = "⚡ Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. " ms"
        startify.section.footer.val = {
          { type = 'padding', val = 1 },
          { type = 'text',    val = footer, opts = { position = 'left' } }
        }
      end
      setFooter()
      alpha.setup(startify.config)
      -- autocmd adapted from LazyVim:
      -- https://github.com/LazyVim/LazyVim/blob/53e1637a864cb7e8f21af107b8073bc8b24acd11/lua/lazyvim/plugins/extras/ui/alpha.lua#L61-L76
      vim.api.nvim_create_autocmd("User", {
        once = true,
        pattern = "LazyVimStarted",
        callback = function()
          setFooter()
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end
  },
}
