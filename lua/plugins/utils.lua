return {
  -- 快速搜索文件
  {
    "nvim-telescope/telescope.nvim",
    opts = {
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
      },
    },
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
  -- notice
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
      stages = "fade"
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    }
  },
}