return {
  {
    -- TODO:
    -- Try echasnovski/mini.surround?
    'kylechui/nvim-surround',
    tag = 'v3.1.2',
    event = 'VeryLazy',
    dependencies = { 'folke/tokyonight.nvim' },
    config = function()
      require('nvim-surround').setup()
      local colors = require('tokyonight.colors').setup()
      -- TODO: Should I contribute this to tokyonight theme?
      -- https://github.com/folke/tokyonight.nvim/blob/v4.11.0/lua/tokyonight/groups/mini_surround.lua#L9
      vim.api.nvim_set_hl(0, 'NvimSurroundHighlight', { bg = colors.orange, fg = colors.black })
    end
  },
  {
    'gbprod/substitute.nvim',
    commit = '9db749a880e3dd3b0eb57f698aa8f1e1630e1f25',
    config = function()
      require('substitute').setup()
      vim.keymap.set('n', 'gs', require('substitute').operator, { noremap = true })
      vim.keymap.set('x', 'gs', require('substitute').visual, { noremap = true })
    end
  },
}
