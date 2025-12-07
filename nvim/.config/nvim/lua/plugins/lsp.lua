return {
  {
    -- Configuration for Neovim's LSP client.
    'neovim/nvim-lspconfig',
    tag = 'v2.3.0',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      {
        'williamboman/mason.nvim',
        tag = 'v2.0.0',
        cmd = { 'Mason', 'MasonLog', 'MasonInstall', 'MasonUninstall', 'MasonUninstallAll' },
        config = function()
          require('mason').setup({
            log_level = vim.log.levels.DEBUG,
            ui = {
              -- Fullscreen
              height = vim.o.lines - 1,
              width = vim.o.columns
            },
          })
        end
      },
      {
        'williamboman/mason-lspconfig.nvim',
        tag = 'v2.0.0',
        config = function()
          require('mason-lspconfig').setup({
            ensure_installed = { 'lua_ls' },
          })
        end
      },
      { 'hrsh7th/cmp-nvim-lsp' },
    },
    config = function()
      local client_capabilities = vim.lsp.protocol.make_client_capabilities()
      -- turn on `window/workDoneProgress` capability
      local capabilities = require('cmp_nvim_lsp').default_capabilities(client_capabilities)
      -- Folding
      -- Advertise foldingRange client capability to server.
      -- Neovim hasn't added foldingRange to default capabilities.
      -- https://github.com/kevinhwang91/nvim-ufo
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true
      }

      vim.lsp.config('*', {
        capabilities = capabilities
      })
      -- setup inspired from LunarVim
      -- https://github.com/LunarVim/Launch.nvim/blob/e4d2fb941ecce66cc012ee88ddb997dc9185aedc/lua/user/lspconfig.lua#L51-L116
      -- Only list servers with custom settings.
      -- Other Mason-installed servers auto-enable with defaults in Neovim 0.11+
      local servers = {
        'lua_ls',
        'eslint',
        'ts_ls'
      }
      for _, server in ipairs(servers) do
        local require_ok, settings = pcall(require, 'plugins.language-server-settings.' .. server)

        if require_ok then
          vim.lsp.config(server, settings)
          vim.lsp.enable(server)
        end
      end
      -- YAML
      -- TODO: Get OpenAPI workflow for Neovim working.
      -- See plugins.lua. Need a swagger ui previewer.
      -- require('lspconfig').yamlls.setup {
      --   capabilities = capabilities,
      --   settings = {
      --     yaml = {
      --       schemas = {
      --         ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "/*.yaml",
      --       },
      --     },
      --   }
      -- }
    end
  },
}
