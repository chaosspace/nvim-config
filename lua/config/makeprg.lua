-- Auto set makeprg based on filetype
-- Use BufEnter with defer_fn to override LSP defaults (rust_analyzer sets rustc)
vim.api.nvim_create_autocmd({ "FileType", "BufEnter" }, {
  group = vim.api.nvim_create_augroup("makeprg", { clear = true }),
  callback = function(args)
    vim.defer_fn(function()
      local ft = vim.bo.filetype
      local makeprg_map = {
        c = "gcc -Wall -g % -o %<",
        cpp = "g++ -Wall -g % -o %<",
        java = "javac %",
        python = "python %",
        go = "go build -o %< .",
        rust = "cargo build",
        javascript = "node %",
        typescript = "tsc %",
        ruby = "ruby %",
        lua = "luac -p %",
        sh = "bash %",
        zsh = "zsh %",
      }
      if makeprg_map[ft] then
        vim.opt.makeprg = makeprg_map[ft]
      end
    end, 50)
  end,
})
