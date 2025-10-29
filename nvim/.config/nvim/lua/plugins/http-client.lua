return {
  {
    -- There's an open PR to add kulala_ls to Mason.nvim:
    -- https://github.com/mason-org/mason-registry/pull/7477
    'mistweaverco/kulala.nvim',
    tag = 'v5.3.3',
    keys = {
      { "<leader>Rs", desc = "Send request" },
      { "<leader>Ra", desc = "Send all requests" },
      { "<leader>Rb", desc = "Open scratchpad" },
    },
    ft = { "http", "rest" },
    opts = {
      global_keymaps = true,
      global_keymaps_prefix = "<leader>R",
      kulala_keymaps_prefix = "",
      ui = {
        -- increase to 1MB from default of 32kb
        max_response_size = 1048576,
      }
    },
  }
}
