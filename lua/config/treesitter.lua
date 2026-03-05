require'nvim-treesitter.configs'.setup {
  ensure_installed = {  -- 前端需安装的语法解析器
    "html", "css", "scss", "less", "javascript", "typescript",
    "jsdoc", "json", "vue", "tsx", "jsonc", "lua", ""
  },
  highlight = { enable = true },  -- 启用高亮
  indent = { enable = true },     -- 启用基于语法树的缩进（对 JSX/Vue 友好）
  incremental_selection = { enable = true },  -- 增量选择（按 v 扩展选区）
}
