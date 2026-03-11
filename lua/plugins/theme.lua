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
      time_interval = 7,
      smear_insert_mode = true,
      stiffness = 0.5,
      trailing_stiffness = 0.5,
      nerver_draw_over_target = false,
      distance_stop_animating = 0.5,
    },
  },
}
