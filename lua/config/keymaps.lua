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

-- 2. 窗口管理快捷键（空格 + 方向键调整大小）
local resize_step = 5
vim.keymap.set('n', '<leader><up>', function()
  vim.cmd('resize +' .. resize_step)
end, { noremap = true, silent = true, desc = '增加窗口高度' })

vim.keymap.set('n', '<leader><down>', function()
  vim.cmd('resize -' .. resize_step)
end, { noremap = true, silent = true, desc = '减少窗口高度' })

vim.keymap.set('n', '<leader><right>', function()
  vim.cmd('vertical resize +' .. resize_step)
end, { noremap = true, silent = true, desc = '增加窗口宽度' })

vim.keymap.set('n', '<leader><left>', function()
  vim.cmd('vertical resize -' .. resize_step)
end, { noremap = true, silent = true, desc = '减少窗口宽度' })


-- 4. NvimTree 快捷键（结合之前的简化命令）
vim.keymap.set('n', '<leader>tr', '<cmd>NvimTreeOpen<CR>', { noremap = true, silent = true, desc = '打开/关闭文件树' })

-- 5. 缓冲区操作
vim.keymap.set('n', '<leader>bn', '<cmd>bnext<CR>', { noremap = true, silent = true, desc = '下一个缓冲区' })
vim.keymap.set('n', '<leader>bp', '<cmd>bprevious<CR>', { noremap = true, silent = true, desc = '上一个缓冲区' })
vim.keymap.set('n', '<leader>bd', '<cmd>bdelete<CR>', { noremap = true, silent = true, desc = '删除当前缓冲区' })
vim.keymap.set('n', '<leader>ba', switch_to_buffer, { noremap = true, silent = true })

-- 6. 快速跳转（屏幕滚动）
vim.keymap.set('n', '<leader>d', '<C-d>', { noremap = true, silent = true, desc = '向下滚动半屏' })
vim.keymap.set('n', '<leader>u', '<C-u>', { noremap = true, silent = true, desc = '向上滚动半屏' })

-- Hint: see `:h vim.map.set()`
-- 在不同面板间快速移动焦点
vim.keymap.set('n', '<leader>h', '<C-w>h', opts)
vim.keymap.set('n', '<leader>j', '<C-w>j', opts)
vim.keymap.set('n', '<leader>k', '<C-w>k', opts)
vim.keymap.set('n', '<leader>l', '<C-w>l', opts)

-- 7. 文件操作
vim.keymap.set('n', '<leader>w', ':w<CR>', opts) --保存
vim.keymap.set('n', '<leader>q', ':q<CR>', opts) --关闭
vim.keymap.set('n', '<leader>Q', ':q!<CR>', opts) --不保存退出
vim.keymap.set('n', '<leader>x', ':x<CR>', opts) --不保存退出

-- 8. telescope
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

