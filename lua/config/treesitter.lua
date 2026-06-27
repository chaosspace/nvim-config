require("nvim-treesitter.configs").setup({
  highlight = { enable = true },
  indent = { enable = false },
  incremental_selection = { enable = true },
})

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
