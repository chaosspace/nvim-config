local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end


-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    (vim.hl or vim.highlight).on_yank()
  end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup("resize_splits"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("last_loc"),
  callback = function(event)
    local exclude = { "gitcommit" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
      return
    end
    vim.b[buf].lazyvim_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Shared indentation overrides
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("common_indent"),
  pattern = { "python", "javascript", "javascriptreact", "typescript", "typescriptreact", "lua", "json", "rust", "css", "scss", "html" },
  callback = function()
    vim.bo.shiftwidth = 2
    vim.bo.softtabstop = 2
    vim.bo.tabstop = 2
    vim.bo.expandtab = true
  end,
})

-- Rust format on save with tab_spaces=2
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup("rust_format"),
  pattern = "*.rs",
  callback = function()
    local file = vim.api.nvim_buf_get_name(0)
    if file == "" then return end
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local content = table.concat(lines, "\n") .. "\n"
    local formatted = vim.fn.system({ "rustfmt", "--config", "tab_spaces=2", "--emit", "stdout" }, content)
    if vim.v.shell_error ~= 0 then return end
    if formatted ~= content then
      local new_lines = vim.split(formatted:gsub("\n$", ""), "\n")
      vim.api.nvim_buf_set_lines(0, 0, -1, false, new_lines)
    end
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = augroup("auto_create_dir"),
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = augroup("lsp_attach"),
  callback = function(event)
    -- 默认关闭 inlay hints，用 <leader>th 切换
    vim.lsp.inlay_hint.enable(false, { bufnr = event.buf })

    local map = function(keys, func, desc, mode)
      mode = mode or "n"
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
    end

    map('<leader>rn', vim.lsp.buf.rename, "Rename")
    map('<leader>th', function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }), { bufnr = event.buf })
    end, "Toggle Inlay Hints")
  end,
})