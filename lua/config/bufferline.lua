require("bufferline").setup({
  options = {
    separator_style = "padded_slant",
    tab_size = 15,
    max_name_length = 18,    -- 缓冲区名称最大长度
    max_prefix_length = 15,  -- 路径前缀最大长度
    truncate_names = true,   -- 截断长名称
    color_icons = true,              -- 启用彩色图标
    show_buffer_icons = true,        -- 显示缓冲区图标
    buffer_close_icon = "✘",
    show_tab_indicators = true,      -- 显示标签指示器
    show_duplicate_prefix = true,    -- 显示重复前缀
    persist_buffer_sort = true,      -- 持久化缓冲区排序
    enforce_regular_tabs = false,
    always_show_bufferline = true,   -- 始终显示 bufferline
    hover = {                        -- 悬浮提示
      enabled = true,
      delay = 200,
      reveal = { "close" },
    },
    offsets = {
      {
        filetype = "NvimTree",       -- 适配 NvimTree 侧边栏
        text = "File Explorer",
        text_align = "center",
        separator = true,
      },
    },
    -- 鼠标悬浮标签
    buffer_hover = {
      gui = "rounded",
    },
    custom_areas = {
      right = function()
        local result = {}
        local seve = vim.diagnostic.severity
        local error = #vim.diagnostic.get(0, {severity = seve.ERROR})
        local warning = #vim.diagnostic.get(0, {severity = seve.WARN})
        local info = #vim.diagnostic.get(0, {severity = seve.INFO})
        local hint = #vim.diagnostic.get(0, {severity = seve.HINT})

        if error ~= 0 then
          table.insert(result, {text = "  " .. error, link = "DiagnosticError"})
        end

        if warning ~= 0 then
          table.insert(result, {text = "  " .. warning, link = "DiagnosticWarn"})
        end

        if hint ~= 0 then
          table.insert(result, {text = "  " .. hint, link = "DiagnosticHint"})
        end

        if info ~= 0 then
          table.insert(result, {text = "  " .. info, link = "DiagnosticInfo"})
        end
        return result
      end,
    }
  },
  highlights = {
    -- 通用背景（匹配 tokyonight-moon 背景色）
    fill = {
      bg = "#24283b",
    },
    -- 非活动标签
    background = {
      gui = "rounded,nocombine",
    },
    -- 活动标签（选中的标签）
    buffer_selected = {
      bold = true,
      italic = true,
      gui = "rounded,bold,nocombine",
    },
  },
})
