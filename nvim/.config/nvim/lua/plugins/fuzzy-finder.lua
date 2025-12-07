local function is_current_prompt_search()
  local bufnr = vim.api.nvim_get_current_buf()
  local current_picker = require('telescope.actions.state').get_current_picker(bufnr)
  return current_picker ~= nil and current_picker.prompt_title == 'Search'
end

vim.api.nvim_create_autocmd('FileType', {
  -- Relies on autopairs being enabled for TelescopePrompt filetype.
  desc = 'Automatically insert quotes for search',
  group = vim.api.nvim_create_augroup('insert_quotes_for_search', { clear = true }),
  pattern = 'TelescopePrompt',
  callback = function()
    if is_current_prompt_search() then
      vim.fn.feedkeys("'")
    end
  end
})

return {
  {
    'nvim-telescope/telescope.nvim',
    commit = 'b4da76be54691e854d3e0e02c36b0245f945c2c7',
    event = { 'LspAttach' }, -- telescope used as vim.ui.select for code actions
    cmd = { 'Telescope' },
    keys = {
      -- TODO: Cycle through history
      -- https://www.reddit.com/r/neovim/comments/phndpv/comment/hbl89xp/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button

      {
        '<leader>f',
        ':Telescope frecency<CR>',
        desc = 'Find files',
      },
      {
        '<leader>s',
        ':lua require("telescope").extensions.live_grep_args.live_grep_args()<CR>',
        desc = 'Search'
      },
      { '<leader>pb', ':Telescope buffers<CR>',      desc = 'Buffers' },
      { '<leader>pc', ':Telescope commands<CR>',     desc = 'Commands' },
      { '<leader>pd', ':Telescope diagnostics<CR>',  desc = 'Diagnostics' },
      { '<leader>ph', ':Telescope help_tags<CR>',    desc = 'Help' },
      { '<leader>pj', ':Telescope jumplist<CR>',     desc = 'Jumplist' },
      { '<leader>pk', ':Telescope keymaps<CR>',      desc = 'Keymaps' },
      { '<leader>pm', ':Telescope marks<CR>',        desc = 'Marks' },
      { '<leader>pp', ':Telescope resume<CR>',       desc = 'Resume' },
      { '<leader>pq', ':Telescope quickfix<CR>',     desc = 'Quickfix' },
      { '<leader>pr', ':Telescope registers<CR>',    desc = 'Registers' },
      -- Git
      { '<leader>gb', ':Telescope git_branches<CR>', desc = 'Branches' },
      { '<leader>gc', ':Telescope git_commits<CR>',  desc = 'Commits' },
      { '<leader>gC', ':Telescope git_bcommits<CR>', desc = 'Commits for buffer' },
      { '<leader>gs', ':Telescope git_status<CR>',   desc = 'Status' },
      -- LSP
      -- TODO: Write function that goes to reference automatically if there's only 1,
      -- and open Telescope if there's more than 1 reference.
      -- https://matrix.to/#/!cxlVvaAjYkBpQTKumW:gitter.im/$XuhOCs-CBTyGDT5cSSrwFvDUVlxbtlSISmztUEbG1Bo?via=matrix.org&via=gitter.im
      -- This appears to be a bug, with a neglected / stale PR to fix it:
      -- https://github.com/nvim-telescope/telescope.nvim/pull/2281
      { 'gr', function()
        -- Consider LSP Saga for references instead:
        -- https://nvimdev.github.io/lspsaga/finder/
        require('telescope.builtin').lsp_references({ include_declaration = false })
      end, { desc = 'Goto references' } },
      { 'gW', ':Telescope lsp_dynamic_workspace_symbols<CR>', desc = 'Workplace symbols' },
      -- {
      --   '<leader>ls',
      --   function()
      --     require('telescope.builtin').lsp_document_symbols({
      --       symbol_width = 50, -- Increase from default of 25
      --     })
      --   end,
      --   desc = 'Lists LSP document symbols in the current buffer'
      -- },
    },
    dependencies = {
      {
        'nvim-lua/plenary.nvim'
      },
      -- for nvim-jdtls
      -- https://github.com/mfussenegger/nvim-jdtls/wiki/UI-Extensions
      {
        'nvim-telescope/telescope-ui-select.nvim',
        commit = '6e51d7da30bd139a6950adf2a47fda6df9fa06d2'
      },
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        commit = '1f08ed60cafc8f6168b72b80be2b2ea149813e55'
      },
      {
        -- Potential alternatives to telescope-frecency:
        -- * danielfalk/smart-open.nvim
        -- * prochri/telescope-all-recent.nvim
        -- * smartpde/telescope-recent-files
        'nvim-telescope/telescope-frecency.nvim',
        commit = '03a0efd1a8668b902bddef4b82cb7d46cd5ab22c'
      },
      {
        'nvim-telescope/telescope-live-grep-args.nvim',
        commit = 'b80ec2c70ec4f32571478b501218c8979fab5201'
      }
    },
    config = function()
      local telescope = require('telescope')
      -- TelescopeResultsLineNr is brighter than TelescopeResultsComment
      vim.api.nvim_set_hl(0, 'TelescopeResultsComment', { link = 'TelescopeResultsLineNr' })
      telescope.setup({
        defaults = {
          wrap_results = true,
          results_title = false,
          file_ignore_patterns = {
            "^.git/"
          },
          layout_config = {
            -- Fullscreen
            width = { padding = 0 },
            height = { padding = 0 },
          },
          mappings = {
            i = {
              ['<C-Down>'] = require('telescope.actions').cycle_history_next,
              ['<C-Up>'] = require('telescope.actions').cycle_history_prev,
            },
          },
          vimgrep_arguments = {
            "rg",
            -- Defaults
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            -- Added
            "--trim" -- trim leading whitespace
          },
        },
        pickers = {
          lsp_references = {
            prompt_title = 'References',
            preview_title = false,
            layout_strategy = 'vertical',
            layout_config = {
              prompt_position = 'top',
              preview_cutoff = 1,
              preview_height = 0.60,
              mirror = true
            },
          },
          find_files = {
            preview_title = false
          },
        },
        extensions = {
          frecency = {
            default_workspace = 'CWD',
            show_filter_column = false, -- hide root directory from filepaths
            prompt_title = 'Find Files',
            preview_title = false,
            path_display = {
              'truncate',
              filename_first = {
                reverse_directories = true
              }
            },
            sorter = require('telescope.config').values.file_sorter(),
            layout_config = {
              preview_width = 0.40,
            },
            -- Fixes automatically inserting 'A' into the Telescope picker.
            -- See https://github.com/nvim-telescope/telescope-frecency.nvim/issues/270#issuecomment-2412515625
            --
            -- Seems to only happen when first openting frecency,
            -- and doesn't occur when opening other pickers such as :Telescope find_files
            --
            -- Running :FrecencyValidate to remove entries also manually fixes it, but the problem comes back later.
            -- See https://github.com/nvim-telescope/telescope-frecency.nvim/issues/270#issuecomment-2820374822
            --
            -- Related problem in Telescope:
            -- https://github.com/nvim-telescope/telescope-frecency.nvim/issues/270#issuecomment-2820374822
            -- https://github.com/nvim-telescope/telescope.nvim/issues/2195
            -- https://www.reddit.com/r/neovim/comments/1ed65xm/telescope_prompt_prefilled_with_a_when_using/?rdt=40029
            -- https://github.com/nvim-telescope/telescope.nvim/blob/b4da76be54691e854d3e0e02c36b0245f945c2c7/lua/telescope/pickers.lua#L601-L602
            db_safe_mode = false
          },
          -- TODO: Consider switching to fzf.lua.
          --       https://github.com/ibhagwan/fzf-lua
          --
          -- Numerous limitations exist:
          -- 1. Not being able to easily colorize entries (see https://github.com/nvim-telescope/telescope.nvim/issues/3496)
          --    For making the background green for tests.
          -- 2. Highlighting matches for entries breaks when using a regular expression.
          -- 3. Can't customize the colon ':' delimiting the filename and the text from ripgrep output.
          -- 4. Can't limit line length by showing matches with context on either side by passing:
          --
          --        --only-matching .{0,N}query.{0,N}
          --
          --    See:
          --    * https://github.com/BurntSushi/ripgrep/issues/2449#issuecomment-1464979702
          --    * https://github.com/BurntSushi/ripgrep/issues/1352#issuecomment-1959071755
          -- 5. Consider adding insert mode mappings for generating ripgrep arguments.
          -- 6. Can't highlight matches in the preview window (only line-level Highlighting is possible).
          --    This doesn't seem possible via fzf.lua or command-line either (e.g. with rg, bat, and delta).
          --
          -- A lot of these issues stem from being more abstracted away from ripgrep.
          live_grep_args = {
            preview_title = false,
            prompt_title = 'Search',
            disable_coordinates = true, -- hide row and column number from each entry
            layout_strategy = 'vertical',
            layout_config = {
              prompt_position = 'bottom',
              preview_cutoff = 1,
              preview_height = 0.30,
              mirror = false
            },
            -- file_ignore_patterns = {
            --   '%.jmx',
            --   '%.drawio'
            -- },
            path_display = function(opts, path)
              local Path = require "plenary.path"
              local shortened_path = Path:new(path):shorten(1)
              local highlights = {
                {
                  {
                    0,                      -- highlight start position
                    #shortened_path,        -- highlight end position
                  },
                  "TelescopeResultsLineNr", -- highlight group name
                },
              }

              return shortened_path, highlights
            end
          },
        }
      })
      telescope.load_extension('ui-select')
      telescope.load_extension('fzf')
      telescope.load_extension('frecency')
    end
  },
  {
    'folke/snacks.nvim',
    commit = 'fe7cfe9800a182274d0f868a74b7263b8c0c020b',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      bigfile = { enabled = false },
      dashboard = { enabled = false },
      explorer = { enabled = false },
      -- This keeps the image on the top right corner, basically leaving your
      -- text area free, suggestion found in reddit by user `Redox_ahmii`
      -- https://www.reddit.com/r/neovim/comments/1irk9mg/comment/mdfvk8b/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
      styles = {
        snacks_image = {
          relative = "editor",
          col = -1,
        },
      },
      image = {
        enabled = true,
        doc = { enabled = false },
        convert = {
          magick = {
            -- Make background white instead of transparent to see black text for transparent images
            default = { "{src}[0]", "-background", "white", "-alpha", "remove", "-scale", "1920x1080>" }
          }
        }
      },
      indent = { enabled = false },
      input = { enabled = false },
      picker = {
        enabled = true,
        layout = {
          preset = "default",
          layout = {
            backdrop = false,
            row = 0,
            col = 0,
            width = vim.o.columns,
            height = vim.o.lines - 2, -- subtract 2 for statusbar and last line
          },
        },
      },
      notifier = { enabled = false },
      quickfile = { enabled = false },
      scope = { enabled = false },
      scroll = { enabled = false },
      statuscolumn = { enabled = false },
      words = { enabled = false },
    },
    keys = {
      {
        '<leader>ls',
        function()
          Snacks.picker.lsp_symbols()
        end,
        desc = 'Lists LSP document symbols in the current buffer'
      },
      {
        'K',
        function()
          Snacks.image.hover()
        end,
        desc = 'Show image',
        ft = 'markdown'
      },
    }
  }
}
