require'nvim-treesitter.configs'.setup {
  highlight = { enable = true },  -- 启用高亮
  indent = { enable = true },     -- 启用基于语法树的缩进（对 JSX/Vue 友好）
  incremental_selection = { enable = true },  -- 增量选择（按 v 扩展选区）
}
