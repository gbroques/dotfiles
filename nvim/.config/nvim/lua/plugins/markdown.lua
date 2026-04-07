return {
  {
    'bullets-vim/bullets.vim',
    tag = '2.0.0'
  },
  {
    'selimacerbas/markdown-preview.nvim',
    tag = 'v1.5.3',
    ft = { 'markdown', 'mermaid' },
    dependencies = { 'selimacerbas/live-server.nvim' },
    config = function()
      require('markdown_preview').setup()
    end,
    keys = {
      { '<leader>mp', '<cmd>MarkdownPreview<cr>', desc = 'Markdown: Start preview' },
      { '<leader>mP', '<cmd>MarkdownPreviewStop<cr>', desc = 'Markdown: Stop preview' },
    },
  },
}
