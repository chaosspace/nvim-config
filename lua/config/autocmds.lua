local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

local rustfmt_running = {}

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

-- Rust format after save with tab_spaces=2 without blocking the write.
vim.api.nvim_create_autocmd("BufWritePost", {
  group = augroup("rust_format"),
  pattern = "*.rs",
  callback = function(event)
    if vim.fn.executable("rustfmt") == 0 then return end
    local buf = event.buf
    if rustfmt_running[buf] then return end
    local file = vim.api.nvim_buf_get_name(buf)
    if file == "" then return end

    local changedtick = vim.api.nvim_buf_get_changedtick(buf)
    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    local content = table.concat(lines, "\n") .. "\n"

    rustfmt_running[buf] = true
    vim.system({ "rustfmt", "--config", "tab_spaces=2", "--emit", "stdout" }, {
      stdin = content,
      text = true,
    }, vim.schedule_wrap(function(result)
      rustfmt_running[buf] = nil
      if result.code ~= 0 or not result.stdout or result.stdout == content then return end
      if not vim.api.nvim_buf_is_valid(buf) then return end
      if vim.api.nvim_buf_get_changedtick(buf) ~= changedtick or vim.bo[buf].modified then return end

      local view
      if buf == vim.api.nvim_get_current_buf() then
        view = vim.fn.winsaveview()
      end

      local new_lines = vim.split(result.stdout:gsub("\n$", ""), "\n")
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, new_lines)
      vim.api.nvim_buf_call(buf, function()
        vim.cmd("silent noautocmd write")
      end)

      if view and buf == vim.api.nvim_get_current_buf() then
        vim.fn.winrestview(view)
      end
    end))
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
    map('gd', vim.lsp.buf.declaration, "Go to Declaration")
    map('gt', vim.lsp.buf.type_definition, "Go to Type Definition")
    map('gr', vim.lsp.buf.references, "References")
    map('<leader>th', function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }), { bufnr = event.buf })
    end, "Toggle Inlay Hints")
  end,
})
