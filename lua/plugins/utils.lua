return {
  -- 快速搜索文件
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-dap.nvim",
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          sorting_strategy = "ascending",
          layout_strategy = "flex",
          layout_config = {
            horizontal = { preview_cutoff = 80, preview_width = 0.55 },
            vertical = { mirror = true, preview_cutoff = 25 },
            prompt_position = "top",
            width = 0.87,
            height = 0.80,
          },
          file_ignore_patterns = {
            "node_modules",
            ".git/",
            ".venv",
            "target/",
            "dist/",
            "build/",
            "__pycache__/",
            "%.o$",
            "%.pyc$",
            "%.class$",
          },
          mappings = {
            i = {
              ["<C-j>"] = "move_selection_next",
              ["<C-k>"] = "move_selection_previous",
              ["<C-l>"] = "select_default",
            },
          },
        },
        pickers = {
          find_files = {
            hidden = true,
          },
          live_grep = {
            additional_args = function()
              return { "--hidden" }
            end,
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      })
      -- 加载 DAP 扩展
      telescope.load_extension('dap')
    end,
  },
  -- 显示左侧文件夹
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup {}
    end,
  },
  --显示空格
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
  },
  -- 平滑滚动
  {
    "karb94/neoscroll.nvim",
    opts = {},
  },
  -- 重新打开文件时恢复上次位置
  {
    "nxhung2304/lastplace.nvim",
    opts = {},
  },
  -- notice
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {
      -- 通知使用 nvim-notify
      notify = {
        view = "notify",
      },
      -- 消息视图
      views = {
        mini = {},
        notify = {},
      },
    },
  },
  -- nvim-notify 单独配置（淡出效果）
  {
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup({
        stages = "fade",
        timeout = 3000,
      })
    end,
  },
  {
    -- Highlight todo, notes, etc in comments
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },
}
