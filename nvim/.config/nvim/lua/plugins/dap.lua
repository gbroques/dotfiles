-- Debugging
return {
  -- TODO LiadOz/nvim-dap-repl-highlights
  {
    'mfussenegger/nvim-dap',
    tag = '0.10.0',
    cmd = { 'DapUIToggle', 'DapToggleRepl', 'DapToggleBreakpoint' },
    ft = { 'java ' }, -- for mfussenegger/nvim-jdtls
    config = function()
      local dap = require('dap')
      local icons = require('icons')

      -- Customize breakpoint
      -- https://github.com/LunarVim/LunarVim/blob/76040d25ff61400317640347e5d5d551ca8cc2d0/lua/lvim/core/dap.lua#L107C1-L107C1
      local breakpoint = {
        text = icons.ui.Breakpoint,
        texthl = 'DiagnosticSignError',
        linehl = '',
        numhl = '',
      }
      vim.fn.sign_define('DapBreakpoint', breakpoint)

      local conditional_breakpoint = {
        text = icons.ui.Breakpoint,
        texthl = 'DiagnosticSignWarn',
        linehl = '',
        numhl = '',
      }
      vim.fn.sign_define('DapBreakpointCondition', conditional_breakpoint)

      -- Open and close dapui automatically.
      -- Comment out because DAP UI briefly shows up when running JDTLS tests.
      -- dap.listeners.after.event_initialized['dapui_config'] = function()
      --   dapui.open()
      -- end
      -- dap.listeners.before.event_terminated['dapui_config'] = function()
      --   dapui.close()
      -- end
      -- dap.listeners.before.event_exited['dapui_config'] = function()
      --   dapui.close()
      -- end

      -- Keymaps
      -- Inspired by AstroNvim, LazyVIM, and mfussenegger's config
      -- https://astronvim.com/Basic%20Usage/mappings#debugger-mappings
      -- https://www.lazyvim.org/keymaps#nvim-dap
      -- https://github.com/mfussenegger/dotfiles/blob/833d634251ebf3bf7e9899ed06ac710735d392da/vim/.config/nvim/lua/me/dap.lua#L118-L136
      vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Toggle breakpoint' })
      vim.keymap.set('n', '<leader>dB', function()
        dap.toggle_breakpoint(vim.fn.input('Breakpoint condition: '), nil, nil, true)
      end, { desc = 'Toggle conditional breakpoint' })
      vim.keymap.set('n', '<leader>dc', dap.continue, { desc = 'Continue (or start) (F5)' })
      vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debugger: Continue (or start)' })
      vim.keymap.set('n', '<leader>di', dap.step_into, { desc = 'Step into (F11)' })
      vim.keymap.set('n', '<F11>', dap.step_into, { desc = 'Debugger: Step into' })
      vim.keymap.set('n', '<leader>do', dap.step_over, { desc = 'Step over (F10)' })
      vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'Debugger: Step over' })
      vim.keymap.set('n', '<leader>dO', dap.step_out, { desc = 'Step out (F12)' })
      vim.keymap.set('n', '<F12>', dap.step_out, { desc = 'Debugger: Step out' })
      vim.keymap.set('n', '<leader>dr', function()
        dap.repl.toggle({ height = 15 })
      end, { desc = 'Toggle DAP repl' })
      vim.keymap.set('n', '<leader>ds', dap.terminate, { desc = 'Stop' })
    end
  },
  {
    'rcarriga/nvim-dap-ui',
    -- Upgrade past v4.0.0 as it doesn't include the following fix for dapui toggle:
    -- https://github.com/rcarriga/nvim-dap-ui/commit/13888eb35faaba48efaf49130b83e0d12e042e1b
    commit = 'cf91d5e2d07c72903d052f5207511bf7ecdb7122',
    config = function ()
      local dapui = require('dapui')
      dapui.setup()
      vim.keymap.set('n', '<leader>du', dapui.toggle, { desc = 'Toggle UI' })
    end,
    dependencies = {
      'mfussenegger/nvim-dap',
      {
        'nvim-neotest/nvim-nio',
        tag = 'v1.10.1'
      }
    }
  },
}
