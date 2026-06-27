vim.cmd.colorscheme "tokyonight-moon"

require('mini.starter').setup({
  footer = "Be your own GOAT"
})

require('lualine').setup({
  options = {
    component_separators = { left = '»', right = '«'},
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {{
      'filename',
      symbols = {
        modified = ' ●', -- 修改后显示的标记
        readonly = ' ', -- 只读文件标记
        unnamed = '[No Name]', -- 无命名文件显示
      }
    }},
    lualine_x = {'encoding', 'filetype'}, -- 编码、文件格式、文件类型
    lualine_y = {'progress'},           -- 进度（行百分比）
    lualine_z = {'location'}            -- 位置（行:列）
  }
})
