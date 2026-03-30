return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    "sphamba/smear-cursor.nvim",

    opts = {
      time_interval = 4,
      smear_insert_mode = true,
      stiffness = 0.4,
      trailing_stiffness = 0.3,
      never_draw_over_target = false,
      distance_stop_animating = 0.3,
    },
  },
}
