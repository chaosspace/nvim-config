require("bufferline").setup({
  options = {
    -- 极简风格：去除圆角，用下划线标记当前 buffer
    separator_style = "thin",
    tab_size = 8,                  -- 缩小 tab 软上限
    max_name_length = 20,          -- 缓冲区名称最大长度
    max_prefix_length = 15,        -- 路径前缀最大长度
    truncate_names = true,         -- 截断长名称
    color_icons = false,                -- 关闭彩色图标
    show_buffer_icons = false,          -- 不显示 buffer 图标
    show_buffer_close_icons = false,    -- 关闭按钮只在 hover 时显示
    close_icon = "×",                   -- hover 时显示的关闭图标
    close_command = "bdelete %d",       -- 显式关闭命令
    show_tab_indicators = true,    -- 显示标签指示器
    persist_buffer_sort = true,    -- 持久化缓冲区排序
    always_show_bufferline = true, -- 始终显示 bufferline
    diagnostics = "none",          -- 不显示诊断信息
    diagnostics_update_in_insert = false, -- 插入模式下不更新诊断
    hover = {                      -- 悬浮提示
      enabled = true,
      delay = 200,
      reveal = { "close" },
    },
    offsets = {
      {
        filetype = "NvimTree",     -- 适配 NvimTree 侧边栏
        text = "File Explorer",
        text_align = "left",
        separator = true,
      },
    },
    view = {
      underline_enabled = true,         -- 当前 buffer 用下划线
      underline_hover_color = "auto",
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
          table.insert(result, {text = " " .. error, link = "DiagnosticError"})
        end
        if warning ~= 0 then
          table.insert(result, {text = " " .. warning, link = "DiagnosticWarn"})
        end
        if hint ~= 0 then
          table.insert(result, {text = " " .. hint, link = "DiagnosticHint"})
        end
        if info ~= 0 then
          table.insert(result, {text = " " .. info, link = "DiagnosticInfo"})
        end
        return result
      end,
    },
  },
  highlights = {
    -- 通用背景（比主题 bg 略深，形成层次感）
    fill = {
      bg = "#1f2335",
    },
    -- 非活动标签：去掉圆角
    background = {
      guifg = "#565f89",
      guibg = "#1f2335",
    },
    -- 当前标签：明显区分（背景对比 + 蓝色文字 + 斜体）
    buffer_selected = {
      bold = true,
      guifg = "#7aa2f7",
      guibg = "#414868",
      italic = true,
    },
    -- 修改过的 buffer（用 modified indicator）
    modified = {
      guifg = "#e0af68",
    },
  },
})