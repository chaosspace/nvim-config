return {
  "ray-x/go.nvim",
  dependencies = {
    "ray-x/guihua.lua",
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
  },
  ft = { "go", "gomod" },
  build = ':lua require("go.install").update_all_sync()',
  opts = {},
  config = function(_, opts)
    if vim.lsp.codelens and not vim.lsp.codelens.enable then
      vim.lsp.codelens.enable = function(enable, codelens_opts)
        codelens_opts = codelens_opts or {}
        if enable then
          vim.lsp.codelens.refresh(codelens_opts)
        else
          vim.lsp.codelens.clear(nil, codelens_opts.bufnr)
        end
      end
    end

    require("go").setup(opts)
    local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*.go",
      group = format_sync_grp,
      callback = function()
        require("go.format").goimports()
      end,
    })
  end,
}
