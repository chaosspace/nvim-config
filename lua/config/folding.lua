-- 代码折叠快捷键配置
-- 使用 Treesitter 折叠（已在 treesitter.lua 中配置）

-- 折叠显示美化
vim.opt.foldcolumn = "1"  -- 显示折叠列
vim.opt.foldtext = [[substitute(getline(v:foldstart), '^\\s*', '', '') . ' ... ' . (v:foldend - v:foldstart + 1) . ' lines']]

-- 快捷键绑定
local opts = { noremap = true, silent = true }

-- 折叠操作
vim.keymap.set('n', '<leader>z', 'za', vim.tbl_extend('force', opts, { desc = '切换当前折叠' }))
vim.keymap.set('n', '<leader>Z', 'zA', vim.tbl_extend('force', opts, { desc = '切换所有嵌套折叠' }))

-- 折叠级别控制
vim.keymap.set('n', 'zR', 'zR', vim.tbl_extend('force', opts, { desc = '展开所有折叠' }))
vim.keymap.set('n', 'zM', 'zM', vim.tbl_extend('force', opts, { desc = '折叠所有' }))
vim.keymap.set('n', 'zr', 'zr', vim.tbl_extend('force', opts, { desc = '减少折叠级别' }))
vim.keymap.set('n', 'zm', 'zm', vim.tbl_extend('force', opts, { desc = '增加折叠级别' }))

-- 折叠导航
vim.keymap.set('n', '[z', '[z', vim.tbl_extend('force', opts, { desc = '上一个折叠' }))
vim.keymap.set('n', ']z', ']z', vim.tbl_extend('force', opts, { desc = '下一个折叠' }))

-- Visual 模式下折叠选中区域
vim.keymap.set('v', '<leader>zf', 'zf', vim.tbl_extend('force', opts, { desc = '折叠选中区域' }))
