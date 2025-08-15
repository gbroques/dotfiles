---Usage: `:lua P(package.loaded)`
---
---Print a large table to a new buffer in a vertical split.
---
---See the following thread for context:
---[What's a fast way to load the output of a command into a temporary buffer?](https://www.reddit.com/r/neovim/comments/zhweuc/whats_a_fast_way_to_load_the_output_of_a_command/)
---
---@param value any A large table to print.
---@return any value The same value returned as a refernce.
P = function(value)
  local lines = vim.split(vim.inspect(value), '\n', { plain = true })
  vim.cmd('vnew')
  vim.cmd('set filetype=lua')
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
  vim.opt_local.modified = false
  return value
end
