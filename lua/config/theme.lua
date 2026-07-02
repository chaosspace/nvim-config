vim.cmd.colorscheme "tokyonight-moon"

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
    lualine_x = {
      {
        -- Git blame 信息组件（使用结构化字典数据）
        function()
          local blame = vim.b.gitsigns_blame_line_dict
          if blame and blame.author then
            -- 格式：作者 时间（将时间戳转为相对时间）
            local time_diff = os.time() - blame.author_time
            local time_str
            if time_diff < 60 then
              time_str = 'now'
            elseif time_diff < 3600 then
              time_str = string.format('%dm', math.floor(time_diff / 60))
            elseif time_diff < 86400 then
              time_str = string.format('%dh', math.floor(time_diff / 3600))
            else
              time_str = string.format('%dd', math.floor(time_diff / 86400))
            end
            return string.format(' %s %s', blame.author, time_str)
          end
          return ''
        end,
        color = { fg = '#7aa2f7' }, -- Tokyo Night 蓝色
      },
      'encoding', -- 编码
      'filetype', -- 文件类型
    },
    lualine_y = {'progress'},           -- 进度（行百分比）
    lualine_z = {'location'}            -- 位置（行:列）
  }
})
