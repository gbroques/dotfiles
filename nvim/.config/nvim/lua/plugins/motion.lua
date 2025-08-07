return {
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
  {
    -- TODO: Improve visual indicator upon pressing s / S.
    -- Statusline could say LEAP for the mode and change colors to red or yellow.
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
        group = vim.api.nvim_create_augroup('leap_enter', { clear = true }),
        pattern = 'LeapEnter',
        callback = function()
          print('LEAP')
          vim.api.nvim_create_autocmd('CursorMoved', {
            once = true,
            callback = function()
              vim.cmd('normal! zz')
            end,
          })
        end,
      })
      vim.api.nvim_create_autocmd('User', {
        group = vim.api.nvim_create_augroup('leap_leave', { clear = true }),
        pattern = 'LeapLeave',
        callback = function()
          -- Clear LEAP message
          print()
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
}
