require('lualine').setup()
require("bufferline").setup({
  options = {
    sepearator_style = "thick",
    tab_size = 15,
    hover = {
      enabled = true,
      delay = 300,
      reveal = { 'close' },
      
    }
  }
})
vim.cmd.colorscheme "tokyonight-moon"

require("ibl").setup {
  scope = {
    enabled = true,
    show_start = true,
    show_end = false,
    injected_languages = false,
    highlight = { "Function", "Label" },
    priority = 500,
  }
}

require('mini.starter').setup({
  footer = "Be your own GOAT"
})