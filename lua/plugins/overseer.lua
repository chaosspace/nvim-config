return {
  "stevearc/overseer.nvim",
  cmd = { "OverseerRun", "OverseerToggle", "OverseerQuickAction" },
  opts = {
    tasks = {
      -- TypeScript/JavaScript (使用 bun)
      ["typescript:run"] = {
        name = "TypeScript: Run",
        builder = function()
          return {
            cmd = { "bun", "run", vim.fn.expand("%") },
            name = "bun " .. vim.fn.expand("%:t"),
            cwd = vim.fn.expand("%:p:h"),
          }
        end,
      },
      ["javascript:run"] = {
        name = "JavaScript: Run",
        builder = function()
          return {
            cmd = { "bun", "run", vim.fn.expand("%") },
            name = "bun " .. vim.fn.expand("%:t"),
            cwd = vim.fn.expand("%:p:h"),
          }
        end,
      },
      ["typescript:build"] = {
        name = "TypeScript: Build",
        builder = function()
          return {
            cmd = { "bun", "build", "--bun", vim.fn.expand("%"), "-o", vim.fn.expand("%:t:r") },
            name = "bun build",
            cwd = vim.fn.expand("%:p:h"),
          }
        end,
      },
      -- Go
      ["go:run"] = {
        name = "Go: Run",
        builder = function()
          return {
            cmd = { "go", "run", "." },
            name = "go run .",
            cwd = vim.fn.getcwd(),
          }
        end,
      },
      ["go:build"] = {
        name = "Go: Build",
        builder = function()
          return {
            cmd = { "go", "build", "-o", vim.fn.expand("%:t:r"), "." },
            name = "go build",
            cwd = vim.fn.getcwd(),
          }
        end,
      },
      ["go:test"] = {
        name = "Go: Test",
        builder = function()
          return {
            cmd = { "go", "test", "./..." },
            name = "go test",
            cwd = vim.fn.getcwd(),
          }
        end,
      },
      -- Rust
      ["rust:run"] = {
        name = "Rust: Run",
        builder = function()
          return {
            cmd = { "cargo", "run" },
            name = "cargo run",
            cwd = vim.fn.getcwd(),
          }
        end,
      },
      ["rust:build"] = {
        name = "Rust: Build",
        builder = function()
          return {
            cmd = { "cargo", "build" },
            name = "cargo build",
            cwd = vim.fn.getcwd(),
          }
        end,
      },
      ["rust:test"] = {
        name = "Rust: Test",
        builder = function()
          return {
            cmd = { "cargo", "test" },
            name = "cargo test",
            cwd = vim.fn.getcwd(),
          }
        end,
      },
      -- Lua
      ["lua:run"] = {
        name = "Lua: Run",
        builder = function()
          return {
            cmd = { "lua", vim.fn.expand("%") },
            name = "lua " .. vim.fn.expand("%:t"),
            cwd = vim.fn.expand("%:p:h"),
          }
        end,
      },
    },
  },
}
