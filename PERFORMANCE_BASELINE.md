# Neovim 性能基准记录

**测试时间**: 2026-07-14
**Neovim版本**: NVIM v0.12.2

## 启动时间

- **总启动时间**: 105.44ms
- LazyStart: 1.03ms
- LazyDone: 21.79ms (+20.76ms)
- UIEnter: 105.44ms (+83.65ms)

## 各阶段耗时

### 1. lazy.nvim (7.39ms)
- module: 2.33ms
- config: 0.38ms
- spec: 3.21ms

### 2. startup (14.22ms)
- tokyonight.nvim: 1.7ms
- bufferline.nvim: 0.81ms
- lastplace.nvim: 2.42ms
- which-key.nvim: 0.46ms
- mini.starter: 2.23ms

### 3. VimEnter (4.38ms)
- todo-comments.nvim: 4.35ms

### 4. VeryLazy (11.9ms)
- noice.nvim: 5.62ms
- smear-cursor.nvim: 2.57ms
- nvim-surround: 1.59ms

### 5. BufReadPre (47.15ms) ⚠️ 最大瓶颈
- gitsigns.nvim: 14.91ms
- nvim-lspconfig: 25.82ms
  - mason-lspconfig.nvim: 6.78ms
  - mason.nvim: 5.59ms
  - cmp-nvim-lsp: 1.65ms
- nvim-colorizer.lua: 6.29ms

### 6. BufReadPost (14.22ms)
- nvim-treesitter: 7.11ms
- indent-blankline.nvim: 3.65ms
- foldsigns.nvim: 3.23ms

## 优化目标

- 总启动时间: 105ms → ~60-70ms
- BufReadPre: 47ms → ~15ms
