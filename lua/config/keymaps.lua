-- define common options
local opts = {
  noremap = true,      -- non-recursive
  silent = true,       -- show message
}


local function switch_to_buffer()
  local char = vim.fn.getchar()
  local num = char - 48

  -- 获取所有buffer
  local bufs = vim.fn.getbufinfo({ buflisted = 1 })
  if #bufs == 0 then
    vim.notify('没有打开的 buffer', vim.log.levels.WARN)
    return
  end
  local buf_ids = {}

  for _, buf in ipairs(bufs) do
    table.insert(buf_ids, buf.bufnr)
  end
  table.sort(buf_ids)


  if num >= 1 and num <= 9 then
    if num > #buf_ids then
      vim.notify('Buffer ' .. num .. ' 不存在 (当前只有 ' .. #buf_ids .. ' 个buffer)', vim.log.levels.WARN)
      return
    end
    local target_buf = buf_ids[num]
    local ok, _ = pcall(vim.cmd, 'buffer ' .. target_buf)
    if not ok then
      vim.notify('Buffer ' .. num .. ' 不存在', vim.log.levels.ERROR)
    end
  else
    vim.notify('请输入数字 1 - 9', vim.log.levels.WARN)
  end
end


-- 1. 基础设置：将空格设为主键（Leader 键）
-- 禁用空格键在正常模式下的默认功能（移动光标）
vim.keymap.set('n', '<space>', '<Nop>', { noremap = true, silent = true, desc = '主键前缀' })

-- 设置全局 Leader 键为空格（供插件和自定义快捷键使用）
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '  -- 局部 Leader 键（用于缓冲区相关操作）


-----------------
-- Normal mode --
-----------------

-- NvimTree 快捷键（结合之前的简化命令）
vim.keymap.set('n', '<leader>tr', '<cmd>NvimTreeOpen<CR>', { noremap = true, silent = true, desc = '打开/关闭文件树' })

-- 缓冲区操作
vim.keymap.set('n', '<leader>bn', '<cmd>bnext<CR>', { noremap = true, silent = true, desc = '下一个缓冲区' })
vim.keymap.set('n', '<leader>bp', '<cmd>bprevious<CR>', { noremap = true, silent = true, desc = '上一个缓冲区' })
vim.keymap.set('n', '<leader>bd', function()
  -- 先获取当前 buffer 编号
  local current_buf = vim.api.nvim_get_current_buf()
  -- 关闭当前 buffer（bdelete! 强制关闭，不提示）
  vim.cmd("bdelete! " .. current_buf)
  -- 自动切换到上一个 buffer（避免关闭后无窗口）
  vim.cmd("bprevious")
end, { noremap = true, silent = true, desc = '删除当前缓冲区' })
vim.keymap.set('n', '<leader>ba', switch_to_buffer, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>boc', function ()
  local current_buf = vim.api.nvim_get_current_buf()
  local bufs = vim.api.nvim_list_bufs()
  for _, buf in ipairs(bufs) do
    if buf ~= current_buf and vim.api.nvim_buf_is_loaded(buf) then
      vim.cmd("bdelete! " ..  buf)
    end
  end
end, { noremap = true, silent = true, desc = '只保留当前缓冲区' })

-- 快速跳转（屏幕滚动）
vim.keymap.set('n', '<leader>d', '<C-d>zz', opts) -- 向下滚动半屏并居中
vim.keymap.set('n', '<leader>u', '<C-u>zz', opts) -- 向上滚动半屏并居中

-- 在不同面板间快速移动焦点
vim.keymap.set('n', '<leader>h', '<C-w>h', opts)
vim.keymap.set('n', '<leader>j', '<C-w>j', opts)
vim.keymap.set('n', '<leader>k', '<C-w>k', opts)
vim.keymap.set('n', '<leader>l', '<C-w>l', opts)

-- 窗口
vim.keymap.set('n', '<leader>sv', '<C-w>v', opts) -- 垂直分割窗口
vim.keymap.set('n', '<leader>sh', '<C-w>s', opts) -- 水平分割窗口
vim.keymap.set('n', '<leader>se', '<C-w>=', opts) -- 使所有窗口等宽等高
vim.keymap.set('n', '<leader>sc', '<C-w>c', opts) -- 关闭当前窗口
vim.keymap.set('n', '<leader>so', '<C-w>o', opts) -- 关闭其他窗口

-- 窗口大小调整
vim.keymap.set('n', '<UP>', ':resize +2<CR>', opts) -- 增加窗口高度
vim.keymap.set('n', '<DOWN>', ':resize -2<CR>', opts) -- 减少窗口高度
vim.keymap.set('n', '<LEFT>', ':vertical resize -2<CR>', opts) -- 减少窗口宽度
vim.keymap.set('n', '<RIGHT>', ':vertical resize +2<CR>', opts) -- 增加窗口宽度

-- 标签页
vim.keymap.set('n', '<leader>to', ':tabnew<CR>', opts) -- 打开新的标签页
vim.keymap.set('n', '<leader>tc', ':tabclose<CR>', opts) -- 关闭当前标签页
vim.keymap.set('n', '<leader>tn', ':tabn<CR>', opts) -- 切换到下一个标签页
vim.keymap.set('n', '<leader>tp', ':tabp<CR>', opts) -- 切换到上一个标签页

-- 文件操作
vim.keymap.set('n', '<leader>w', ':w<CR>', opts) --保存
vim.keymap.set('n', '<leader>q', ':q<CR>', opts) --关闭
vim.keymap.set('n', '<leader>Q', ':q!<CR>', opts) --不保存退出
vim.keymap.set('n', '<leader>x', ':x<CR>', opts) --不保存退出

-- telescope
vim.keymap.set('n', '<leader>ff', ':Telescope find_files<CR>', { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fb', ':Telescope buffers<CR>', { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fg', ':Telescope live_grep<CR>', { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fh', ':Telescope help_tags<CR>', { desc = 'Telescope help tags' })
vim.keymap.set('n', '<leader>fo', ':Telescope oldfiles<CR>', { desc = 'Telescope old files' })
vim.keymap.set('n', '<leader>fc', ':Telescope commands<CR>', { desc = 'Telescope commands' })
vim.keymap.set('n', '<leader>fcw', ':Telescope grep_string<CR>', { desc = 'Telescope current string' })

-- overseer 任务运行
vim.keymap.set('n', '<leader>or', '<cmd>OverseerRun<CR>', opts)
vim.keymap.set('n', '<leader>ot', '<cmd>OverseerToggle<CR>', opts)
vim.keymap.set('n', '<leader>ok', '<cmd>OverseerToggle<CR>', opts)

-- Terminal mode - 退出 terminal 并关闭 overseer 面板
vim.keymap.set('t', 'jk', '<C-\\><C-n>', opts) -- 在 terminal 模式下按 jk 退出到 normal 模式
vim.keymap.set('t', 'qq', '<C-\\><C-n>', opts) -- 在 terminal 模式下按 jk 退出到 normal 模式

-- 9. notice history
vim.keymap.set("n", "<leader>nl", function()
  require("noice").cmd("last")
end)
vim.keymap.set("n", "<leader>nh", function()
  require("noice").cmd("history")
end)

vim.keymap.set("n", "gd", vim.lsp.buf.declaration, opts)
vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

vim.keymap.set("n", "x", "\"_x", opts) -- 在 normal 模式下按 x 删除字符但不复制到剪贴板

-----------------
-- Visual mode --
-----------------

-- v mode 控制缩进（执行后保持选中状态）
vim.keymap.set("v", "<Tab>", ">gv", opts)
vim.keymap.set("v", "<S-Tab>", "<gv", opts) -- Shift+Tab 减少缩进

-------------
-- Command --
-------------

-- 搜索计数（先 /搜索内容，再按 <leader>sm 统计匹配数量）
vim.keymap.set('n', '<leader>sn', '<Cmd>%s///gn<CR>', { noremap = true, silent = true, desc = 'Count matches for last search' })

