-- define common options
local opts = {
  noremap = true,      -- non-recursive
  silent = false,       -- show message
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
vim.keymap.set('n', '<leader>d', '<C-d>', { noremap = true, silent = true, desc = '向下滚动半屏' })
vim.keymap.set('n', '<leader>u', '<C-u>', { noremap = true, silent = true, desc = '向上滚动半屏' })

-- 在不同面板间快速移动焦点
vim.keymap.set('n', '<leader>h', '<C-w>h', opts)
vim.keymap.set('n', '<leader>j', '<C-w>j', opts)
vim.keymap.set('n', '<leader>k', '<C-w>k', opts)
vim.keymap.set('n', '<leader>l', '<C-w>l', opts)

-- 文件操作
vim.keymap.set('n', '<leader>w', ':w<CR>', opts) --保存
vim.keymap.set('n', '<leader>q', ':q<CR>', opts) --关闭
vim.keymap.set('n', '<leader>Q', ':q!<CR>', opts) --不保存退出
vim.keymap.set('n', '<leader>x', ':x<CR>', opts) --不保存退出

-- telescope
vim.keymap.set('n', '<leader>ff', ':Telescope find_files<CR>', { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fb', ':Telescope buffers<CR>', { desc = 'Telescope buffers' })

-- 9. notice history
vim.keymap.set("n", "<leader>nl", function()
  require("noice").cmd("last")
end)
vim.keymap.set("n", "<leader>nh", function()
  require("noice").cmd("history")
end)

-----------------
-- Visual mode --
-----------------

-- v mode 控制缩进（执行后保持选中状态）
vim.keymap.set("v", "<Tab>", ">gv", opts)
vim.keymap.set("v", "<S-Tab>", "<gv", opts) -- Shift+Tab 减少缩进

-------------
-- Command --
-------------

