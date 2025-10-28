return {
  {
    'awslabs/amazonq.nvim',
    tag = 'v0.1.0',
    config = function()
      require('amazonq').setup({
        ssoStartUrl = 'https://charter-cloud-connect.awsapps.com/start',
        -- Uncomment the below line to debug plugin:
        -- debug = true
      })
    end
  }
}
