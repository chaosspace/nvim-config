require'nvim-treesitter.configs'.setup {
  highlight = { enable = true },  -- 启用高亮
  indent = { enable = false },     -- 禁用，使用 vim 内置缩进
  incremental_selection = { enable = true },  -- 增量选择（按 v 扩展选区）

}

vim.api.nvim_create_autocmd('FileType', {
  pattern = { '<filetype>' },
  callback = function() vim.treesitter.start() end,
})
vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.wo[0][0].foldmethod = 'expr'