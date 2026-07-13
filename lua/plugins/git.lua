return {
  {
    "NeogitOrg/neogit",
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required

      -- Only one of these is needed.
      "sindrets/diffview.nvim",        -- optional

      -- Only one of these is needed.
      "nvim-telescope/telescope.nvim", -- optional
    },
    cmd = "Neogit",
    keys = {
      { "<leader>gg", "<cmd>Neogit<cr>", desc = "Show Neogit UI" }
    }
  },
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },  -- gitsigns需要提前加载
    config = function()
      -- 当 gitsigns 更新时刷新 lualine
      vim.api.nvim_create_autocmd('User', {
        pattern = 'GitSignsUpdate',
        callback = function()
          require('lualine').refresh()
        end,
      })

      require('gitsigns').setup {
        signs = {
          add          = { text = 'A' },
          change       = { text = 'M' },
          delete       = { text = 'D' },
          topdelete    = { text = 'D' },
          changedelete = { text = 'D' },
          untracked    = { text = 'U' },
        },
        signs_staged = {
          add          = { text = 'A' },
          change       = { text = 'M' },
          delete       = { text = 'D' },
          topdelete    = { text = 'D' },
          changedelete = { text = 'D' },
          untracked    = { text = 'U' },
        },
        signs_staged_enable = true,
        signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
        numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir = {
          follow_files = true
        },
        auto_attach = true,
        attach_to_untracked = false,
        current_line_blame = true, -- 启用 blame 以填充字典供 lualine 使用
        current_line_blame_opts = {
          virt_text = false, -- 不显示行尾虚拟文本
          delay = 100, -- 100ms 延迟，更快响应
          ignore_whitespace = false,
        },
        current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil, -- Use default
        max_file_length = 40000, -- Disable if file is longer than this (in lines)
        preview_config = {
          -- Options passed to nvim_open_win
          style = 'minimal',
          relative = 'cursor',
          row = 0,
          col = 1
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          local function map(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
          end

          -- 查看当前航的Git历史
          map('gh', gs.preview_hunk, 'Preview git hunk')
          -- 暂存当前块
          map('gs', gs.stage_hunk, 'Stage git hunk')
          -- 重置当前块，避免覆盖 LSP references 的 gr
          map('<leader>gr', gs.reset_hunk, 'Reset git hunk')
        end
      }

      -- 手动触发 current_line_blame 的初始化
      vim.defer_fn(function()
        local clb = require('gitsigns.current_line_blame')
        if clb and clb.refresh then
          clb.refresh()
        end
      end, 100)
    end
  }
}
