require'nvim-treesitter.configs'.setup {
  highlight = { enable = true },  -- 启用高亮
  indent = { enable = true },     -- 启用基于语法树的缩进（对 JSX/Vue 友好）
  incremental_selection = { enable = true },  -- 增量选择（按 v 扩展选区）

}

vim.api.nvim_create_autocmd('FileType', {
  pattern = { '<filetype>' },
  callback = function() vim.treesitter.start() end,
})
vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.wo[0][0].foldmethod = 'expr'
vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"