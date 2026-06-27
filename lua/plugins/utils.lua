return {
  -- 快速搜索文件
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
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
    end,
  },
  -- 显示左侧文件夹
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFocus", "NvimTreeFindFile" },
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    init = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      vim.opt.termguicolors = true
    end,
    opts = {
      sort = {
        sorter = "case_sensitive",
      },
      view = {
        width = 30,
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = true,
      },
    },
    config = function(_, opts)
      require("nvim-tree").setup(opts)
    end,
  },
  --显示空格
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    ---@module "ibl"
    ---@type ibl.config
    opts = {
      scope = {
        enabled = true,
        show_start = true,
        show_end = false,
        injected_languages = false,
        highlight = { "Function", "Label" },
        priority = 500,
      },
    },
  },
  -- 平滑滚动
  {
    "karb94/neoscroll.nvim",
    opts = {},
    keys = {
      {
        "<leader>dv",
        function()
          require("neoscroll").ctrl_d({ duration = 250 })
          vim.defer_fn(function()
            require("neoscroll").zz({ half_win_duration = 180 })
          end, 260)
        end,
        desc = "向下平滑滚动半屏并居中",
      },
      {
        "<leader>uv",
        function()
          require("neoscroll").ctrl_u({ duration = 250 })
          vim.defer_fn(function()
            require("neoscroll").zz({ half_win_duration = 180 })
          end, 260)
        end,
        desc = "向上平滑滚动半屏并居中",
      },
    },
  },
  -- 重新打开文件时恢复上次位置
  {
    "nxhung2304/lastplace.nvim",
    opts = {},
  },
  -- 折叠标记显示在 sign column
  {
    "netmute/foldsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      { "netmute/foldchanged.nvim", lazy = true },
    },
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
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      cmdline = {
        view = "cmdline_popup",
      },
      presets = {
        bottom_search = false,
        command_palette = false,
        long_message_to_split = false,
        inc_rename = false,
      },
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
    lazy = true,
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
