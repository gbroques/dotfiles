return {
  {
    'awslabs/amazonq.nvim',
    tag = 'v0.1.0',
    config = function()
      require('amazonq').setup({
        ssoStartUrl = 'https://charter-cloud-connect.awsapps.com/start',
        -- Open chat window on right (instead of default left)
        on_chat_open = function()
          vim.cmd [[
            vertical botright split
            set wrap breakindent nonumber norelativenumber nolist
          ]]
        end,
        -- Uncomment the below line to debug plugin:
        -- debug = true
      })
    end
  }
}
