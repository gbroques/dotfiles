-- TODO: Better organize plugins into groups by concern like LazyVim.
-- See https://www.lazyvim.org/plugins
-- See also https://www.reddit.com/r/neovim/comments/zow2u9/which_structure_of_neovim_config_files_do_you/
-- TODO: See the following link for a reference of how to lazy-load various plugins
-- https://github.com/2KAbhishek/nvim2k/blob/main/lua/plugins/list.lua
return {
  {
    -- Reopen files at last edit position.
    'farmergreg/vim-lastplace',
    commit = 'e58cb0df716d3c88605ae49db5c4741db8b48aa9',
    event = { 'BufReadPre', 'BufNewFile' },
  },
  -- Editing
  {
    'max397574/better-escape.nvim',
    commit = '19a38aab94961016430905ebec30d272a01e9742',
    event = 'InsertEnter',
    config = function()
      -- 'dh' is a convenient escape from Insert mode in Colemak.
      require('better_escape').setup({ mappings = { i = { d = { h = '<Esc>' } } } })
    end
  },
  {
    'chrishrb/gx.nvim',
    commit = '38d776a0b35b9daee5020bf3336564571dc785af',
    event = { 'BufEnter' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = true
  },
  -- TODO:
  -- Try echasnovski/mini.surround?
  {
    'kylechui/nvim-surround',
    tag = 'v3.1.2',
    event = 'VeryLazy',
    dependencies = {
      'folke/tokyonight.nvim'
    },
    config = function()
      require('nvim-surround').setup()
      local colors = require('tokyonight.colors').setup()
      -- TODO: Should I contribute this to tokyonight theme?
      -- https://github.com/folke/tokyonight.nvim/blob/v4.11.0/lua/tokyonight/groups/mini_surround.lua#L9
      vim.api.nvim_set_hl(0, 'NvimSurroundHighlight', { bg = colors.orange, fg = colors.black })
    end
  },
  {
    -- Upgrade to fix vim.validate deprecation warning:
    -- https://github.com/smjonas/live-command.nvim/issues/45
    'smjonas/live-command.nvim',
    commit = '05b9f886628f3e9e6122e734c1fac4f13dcb64b4',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('live-command').setup {
        commands = {
          Norm = { cmd = 'norm' },
        },
      }
      -- https://vim.fandom.com/wiki/Unused_keys
      vim.keymap.set('v', '<C-N>', ':Norm ', { desc = 'norm (live-preview)' })
    end,
  },
  {
    -- TODO: consider lspsaga instead of dressing.nvim for LSP rename input
    -- TODO: this was archived and snacks.nvim was a suggested replacement
    -- See https://github.com/stevearc/dressing.nvim/issues/190
    --     https://github.com/folke/snacks.nvim/blob/main/docs/input.md
    -- For vim.ui.input and LSP renames.
    'stevearc/dressing.nvim',
    commit = '8b7ae53d7f04f33be3439a441db8071c96092d19',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('dressing').setup({
        input = { start_in_insert = false, start_mode = 'normal' },
        select = { enabled = false }
      })
    end
  },
  {
    -- TODO: Add visual indicator upon pressing s / S.
    -- For example, status bar could say LEAP and change colors.
    -- See https://github.com/rebelot/heirline.nvim/issues/220
    'ggandor/leap.nvim',
    commit = 'ebaf38f7fd7193cc918c10eb955afed63301cd76',
    dependencies = {
      'folke/tokyonight.nvim'
    },
    config = function()
      -- Map z instead of s in operator pending mode as it conflicts with cs, ds, and ys for surround in normal mode.
      -- https://www.reddit.com/r/neovim/comments/13j3j45/comment/jkcuj2b/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
      -- x is for visual mode, see :help map-modes
      vim.keymap.set({ 'n', 'x' }, 's', '<Plug>(leap-forward)')
      vim.keymap.set({ 'n', 'x' }, 'S', '<Plug>(leap-backward)')
      vim.keymap.set('o', 'z', '<Plug>(leap-forward)')
      vim.keymap.set('o', 'Z', '<Plug>(leap-backward)')

      -- https://github.com/folke/tokyonight.nvim/blob/v4.11.0/lua/tokyonight/groups/leap.lua#L9-L11
      local colors = require('tokyonight.colors').setup()
      vim.api.nvim_set_hl(0, 'LeapMatch', { bg = colors.bg_search, fg = colors.fg })
      vim.api.nvim_set_hl(0, 'LeapLabel', { bg = colors.bg_search, fg = colors.fg })
      vim.api.nvim_set_hl(0, 'LeapBackdrop', { fg = 'none' })

      -- Center screen vertically upon automatically leaping to second character in search pattern.
      -- See: https://github.com/ggandor/leap.nvim/issues/256#issuecomment-2480668362
      vim.api.nvim_create_autocmd('User', {
        group = vim.api.nvim_create_augroup('center_screen_upon_leap', { clear = true }),
        pattern = 'LeapEnter',
        callback = function()
          vim.api.nvim_create_autocmd('CursorMoved', {
            once = true,
            callback = function()
              vim.cmd('normal! zz')
            end,
          })
        end,
      })
    end
  },
  {
    'rasulomaroff/telepath.nvim',
    commit = '2879da05463db7bdc8824b13cccd8e8920c62a55',
    dependencies = 'ggandor/leap.nvim',
    lazy = false,
    config = function()
      vim.keymap.set('o', 'r', function()
          require('telepath').remote({ restore = true })
        end,
        { desc = 'Remote action' })
    end
  },
  {
    -- Enhanced f / F and t / T by highlighting unique letters for each word on the cursor line.
    -- TODO: Highlights remain after yank and change operations. See:
    --       https://github.com/jinh0/eyeliner.nvim/issues/63
    -- TODO: camelCase / PascalCase aren't considered separate "words".
    'jinh0/eyeliner.nvim',
    commit = '8f197eb30cecdf4c2cc9988a5eecc6bc34c0c7d6',
    dependencies = {
      'folke/tokyonight.nvim'
    },
    config = function()
      require('eyeliner').setup({
        highlight_on_key = true
      })
      local colors = require('tokyonight.colors').setup()
      -- TODO: Should I contribute this to tokyonight theme?
      -- Based on https://github.com/folke/tokyonight.nvim/blob/v4.11.0/lua/tokyonight/groups/base.lua#L56-L57
      vim.api.nvim_set_hl(0, 'EyelinerPrimary', { bg = colors.orange, fg = colors.black })
      vim.api.nvim_set_hl(0, 'EyelinerSecondary', { bg = colors.bg_search, fg = colors.fg })
    end
  },
  -- TODO: Plugins under consideration:
  -- { 'andymas/vim-matchup' },
  -- TODO: Interferes with rendering C in statusline for : and /
  --       https://github.com/sphamba/smear-cursor.nvim/issues/150
  {
    'sphamba/smear-cursor.nvim',
    commit = '58e69a911e7f5296b3d7fec5e7414df5a4ac91fb',
    opts = {
      -- Smooth cursor without smear
      stiffness = 0.5,
      trailing_stiffness = 0.5,
      damping = 0.67,
      matrix_pixel_threshold = 0.5,
    },
  },
  --
  -- smooth scrolling
  -- { 'karb94/neoscroll.nvim' },
  -- { 'psliwka/vim-smoothie' },
  --
  -- { 'SmiteshP/nvim-navic' },
  -- { 'chentoast/marks.nvim' },
  -- { 'chrisgrieser/nvim-rip-substitute' },
  {
    'chrisgrieser/nvim-spider',
    commit = '6da0307421bc4be6fe02815faabde51007c4ea1a',
    config = function()
      require('spider').setup()
      vim.keymap.set({ 'n', 'o', 'x' }, 'w', "<cmd>lua require('spider').motion('w')<CR>")
      vim.keymap.set({ 'n', 'o', 'x' }, 'e', "<cmd>lua require('spider').motion('e')<CR>")
      vim.keymap.set({ 'n', 'o', 'x' }, 'b', "<cmd>lua require('spider').motion('b')<CR>")
    end
  },
  -- Similar to subword text object in nvim-various-textobjs, but uses v instead of S.
  -- { 'Julian/vim-textobj-variable-segment' },
  -- text objects of interest are subword, quote, value, key, number, and html attribute
  {
    'chrisgrieser/nvim-various-textobjs',
    event = 'VeryLazy',
    commit = '65cd7eecc6ad92578a91acb2baebc1a27abf7e2b',
    config = function()
      vim.keymap.set({ 'o', 'x' }, 'av', '<cmd>lua require("various-textobjs").subword("outer")<CR>')
      vim.keymap.set({ 'o', 'x' }, 'iv', '<cmd>lua require("various-textobjs").subword("inner")<CR>')
      vim.keymap.set({ 'o', 'x' }, 'aq', '<cmd>lua require("various-textobjs").anyQuote("outer")<CR>')
      vim.keymap.set({ 'o', 'x' }, 'iq', '<cmd>lua require("various-textobjs").anyQuote("inner")<CR>')
    end
  },
  {
    -- Interactive evaluation
    -- :ConjureSchool for a tutorial.
    -- https://oli.me.uk/Blog+archive/2020/Conversational+software+development
    'Olical/conjure',
    ft = { 'lua', 'fennel', 'python' },
    commit = '0ac12d481141555cc4baa0ad656b590ed30d2090'
  },

  -- TEXT OBJECTS PLUGINS
  -- Read https://thevaluable.dev/vim-create-text-objects/

  -- Has special operators to specially handle whitespace (like `I` and `A`)
  -- { 'wellle/targets.vim' },

  -- ciq - change in quotes "" '' or ``
  -- { 'echasnovski/mini.ai' },
  {
    'gbprod/substitute.nvim',
    commit = '9db749a880e3dd3b0eb57f698aa8f1e1630e1f25',
    config = function()
      require('substitute').setup()
      vim.keymap.set('n', 'gs', require('substitute').operator, { noremap = true })
      vim.keymap.set('x', 'gs', require('substitute').visual, { noremap = true })
    end
  },
  -- gs is taken by substitute.nvim currently
  -- s is used for leap
  -- { 'simrat39/symbols-outline.nvim' },
  -- { 'kosayoda/nvim-lightbulb' },

  -- Java
  {
    -- Java Development Tools Language Server
    'mfussenegger/nvim-jdtls',
    commit = '4d77ff02063cf88963d5cf10683ab1fd15d072de',
    ft = { 'java' }
  },
  -- TODO: Consider java.nvim for file renames.
  -- https://github.com/simaxme/java.nvim/tree/main
  -- YAML & JSON
  -- TODO:
  -- YAML Language Server doesn't work with openapi 3.0
  -- See: https://github.com/redhat-developer/yaml-language-server/issues/7
  -- swagger-ui-watcher needs to bump swagger-editor-dist to 5.x for openapi 3.1:
  -- See: https://github.com/swagger-api/swagger-editor/releases/tag/v4.10.0
  -- {
  --   'vinnymeller/swagger-preview.nvim',
  --   commit = '4e1db32e7934c57d653846d5d297f7ea9ddb6ee8',
  --   build = 'npm install -g swagger-ui-watcher',
  --   config = function()
  --     require("swagger-preview").setup({
  --       -- The port to run the preview server on
  --       port = 8000,
  --       -- The host to run the preview server on
  --       host = "localhost",
  --     })
  --   end
  -- },

  -- Utility
  -- TODO: Look at opening last edited file automatically or automatically saving sessions per project
  -- https://neovimcraft.com/?search=tag%3Asession
  -- https://github.com/folke/persistence.nvim - is very simple and creates the session by folder + branch.
  -- Need to create an autocmd to automatically load the session.
  {
    'nvim-lua/plenary.nvim',
    commit = '857c5ac632080dba10aae49dba902ce3abf91b35',
    lazy = true
  },
  {
    'nvim-tree/nvim-web-devicons',
    commit = '1fb58cca9aebbc4fd32b086cb413548ce132c127',
    lazy = true
  },
  {
    'dstein64/vim-startuptime',
    cmd = 'StartupTime',
    config = function()
      vim.g.startuptime_tries = 10
    end,
  }
}
