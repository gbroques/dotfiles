local fnamemodify = vim.fn.fnamemodify
local filereadable = vim.fn.filereadable

local default_mru_ignore = { "gitcommit" }

local mru_opts = {
  ignore = function(path, ext)
    return (string.find(path, "COMMIT_EDITMSG")) or (vim.tbl_contains(default_mru_ignore, ext))
  end,
  autocd = false
}

local function mru_title()
  return "MRU " .. vim.fn.getcwd()
end

return {
  {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    commit = '2b3cbcdd980cae1e022409289245053f62fb50f6',
    event = 'VimEnter',
    config = function()
      local alpha = require('alpha')
      local utils = require("alpha.utils")
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
      startify.section.top_buttons.val = {
        startify.button("b", "New file", "<cmd>ene <CR>"),
      }
      -- disable global MRU
      startify.section.mru.val = { { type = "padding", val = 0 } }

      --- @param cwd string? optional
      local function mru(cwd, opts)
        opts = opts or mru_opts
        -- Colemak homerow
        -- Start with the left-hand index finger, then right-hand index finger,
        -- then left-hand middle finger, then right-hand middle finger, and so on.
        -- TODO: t conflicts with till operator on start screen
        local keys = { 't', 'n', 's', 'e', 'r', 'i', 'a', 'o' }
        local items_number = #keys
        local oldfiles = {}
        for _, v in pairs(vim.v.oldfiles) do
          if #oldfiles == items_number then
            break
          end
          local cwd_cond
          if not cwd then
            cwd_cond = true
          else
            cwd_cond = vim.startswith(v, cwd)
          end
          local ignore = (opts.ignore and opts.ignore(v, utils.get_extension(v))) or false
          if (filereadable(v) == 1) and cwd_cond and not ignore then
            oldfiles[#oldfiles + 1] = v
          end
        end

        local tbl = {}
        for i, fn in ipairs(oldfiles) do
          local short_fn
          if cwd then
            short_fn = fnamemodify(fn, ":.")
          else
            short_fn = fnamemodify(fn, ":~")
          end
          local file_button_el = startify.file_button(fn, keys[i], short_fn, opts.autocd)
          tbl[i] = file_button_el
        end
        return {
          type = "group",
          val = tbl,
          opts = {},
        }
      end

      startify.section.mru_cwd.val = {
        { type = "padding", val = 1 },
        { type = "text",    val = mru_title, opts = { hl = "SpecialComment", shrink_margin = false } },
        { type = "padding", val = 1 },
        {
          type = "group",
          val = function()
            return { mru(vim.fn.getcwd()) }
          end,
          opts = { shrink_margin = false },
        },
      }

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
