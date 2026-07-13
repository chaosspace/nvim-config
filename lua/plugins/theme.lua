return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    "sphamba/smear-cursor.nvim",
    event = "VeryLazy",
    opts = {
      time_interval = 17,  -- 60fps (1000ms / 60 ≈ 17ms)
      smear_insert_mode = true,
      stiffness = 0.45,
      trailing_stiffness = 0.35,
      never_draw_over_target = false,
      distance_stop_animating = 0.35,
    },
  },
}
