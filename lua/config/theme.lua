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

require("noice").setup({
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
    },
  },
  cmdline = {
    view = "cmdline",
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = false, -- use a classic bottom cmdline for search
    command_palette = false, -- position the cmdline and popupmenu together
    long_message_to_split = false, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
  },
})