return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    event = { "BufReadPost", "BufNewFile" },
    build = ":TSUpdate",
    config = function()
      require("config.treesitter")
    end,
    -- 性能优化：不自动安装，按需手动安装
    opts = {
      ensure_installed = {},
      sync_install = false,
      auto_install = false,
      ignore_install = {},
    },
  },
}
