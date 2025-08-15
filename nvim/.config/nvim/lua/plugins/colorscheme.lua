local colors_module = require('colors')

return {
  'folke/tokyonight.nvim',
  tag = 'v4.11.0',
  config = function()
    require('tokyonight').setup({
      styles = {
        comments = { italic = false },
        keywords = { italic = false },
        functions = {},
        variables = {},
      },
      -- Lighten light colors and darken dark colors for added contrast.
      on_colors = function(colors)
        colors.comment = colors_module.lighten(colors.comment, 0.20)
        -- Lighten unused symbols (DiagnosticUnnecessary)
        colors.terminal_black = colors_module.lighten(colors.terminal_black, 0.30)
        colors.fg = colors_module.lighten(colors.fg, 0.20)          -- #c8d3f5 lightened to #d3dcf7
        colors.bg = colors_module.darken(colors.bg, 0.20)           -- #222436 darkened to #1b1d2b
        colors.bg_dark = colors_module.darken(colors.bg_dark, 0.20) -- #1e2030 darkened to #181a26
      end,
      on_highlights = function(hl, c)
        -- Default is fg_gutter
        -- https://github.com/folke/tokyonight.nvim/blob/v4.11.0/lua/tokyonight/groups/base.lua#L33-L36
        hl.LineNr       = { fg = c.fg_dark }
        hl.LineNrAbove  = { fg = c.fg_dark }
        hl.LineNrBelow  = { fg = c.fg_dark }

        -- Default is bold orange
        -- https://github.com/folke/tokyonight.nvim/blob/v4.11.0/lua/tokyonight/groups/base.lua#L34
        hl.CursorLineNr = { fg = c.fg }
      end
    })

    vim.cmd('colorscheme tokyonight-moon')
  end
}
