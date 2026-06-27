-- DAP (Debug Adapter Protocol) Configuration
-- 用于调试 Rust、Go 等语言

return {
  {
    'nvim-telescope/telescope-dap.nvim',
    lazy = true,
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'mfussenegger/nvim-dap',
    },
  },
  {
    'mfussenegger/nvim-dap',
    cmd = {
      'DapContinue',
      'DapLoadLaunchJSON',
      'DapPause',
      'DapRestartFrame',
      'DapRunLast',
      'DapShowLog',
      'DapStepInto',
      'DapStepOut',
      'DapStepOver',
      'DapTerminate',
      'DapToggleBreakpoint',
      'DapToggleRepl',
    },
    dependencies = {
      -- 调试 UI
      'rcarriga/nvim-dap-ui',
      -- 虚拟文本显示变量
      'theHamsta/nvim-dap-virtual-text',
      -- Mason 安装调试适配器
      'jay-babu/mason-nvim-dap.nvim',
      -- 依赖 nvim-neotest/nvim-nio
      'nvim-neotest/nvim-nio',
    },
    config = function()
      local dap = require('dap')
      local dapui = require('dapui')

      -- ==================== DAP UI 配置 ====================
      dapui.setup({
        icons = { expanded = '', collapsed = '', current_frame = '' },
        mappings = {
          expand = { '<CR>', '<2-LeftMouse>' },
          open = 'o',
          remove = 'd',
          edit = 'e',
          repl = 'r',
          toggle = 't',
        },
        element_mappings = {},
        expand_lines = vim.fn.has('nvim-0.7') == 1,
        layouts = {
          {
            elements = {
              { id = 'scopes', size = 0.25 },
              { id = 'breakpoints', size = 0.25 },
              { id = 'stacks', size = 0.25 },
              { id = 'watches', size = 0.25 },
            },
            size = 40,
            position = 'left',
          },
          {
            elements = {
              { id = 'repl', size = 0.5 },
              { id = 'console', size = 0.5 },
            },
            size = 10,
            position = 'bottom',
          },
        },
        controls = {
          enabled = vim.fn.has('nvim-0.8') == 1,
          element = 'repl',
          icons = {
            pause = '',
            play = '',
            step_into = '',
            step_over = '',
            step_out = '',
            step_back = '',
            run_last = '',
            terminate = '',
            disconnect = '',
          },
        },
        floating = {
          max_height = nil,
          max_width = nil,
          border = 'rounded',
          mappings = {
            close = { 'q', '<Esc>' },
          },
        },
        windows = { indent = 1 },
        render = {
          max_type_length = nil,
          max_value_lines = 100,
        },
      })

      -- ==================== 虚拟文本配置 ====================
      require('nvim-dap-virtual-text').setup({
        enabled = true,
        enabled_commands = true,
        highlight_changed_variables = true,
        highlight_new_as_changed = true,
        show_stop_reason = true,
        commented = false,
        only_first_definition = true,
        all_references = false,
        filter_references_pattern = '<module',
        virt_text_pos = 'eol',
        all_frames = false,
        virt_lines = false,
        virt_text_win_col = nil,
      })

      -- ==================== Mason DAP 配置 ====================
      require('mason-nvim-dap').setup({
        ensure_installed = {
          'codelldb',  -- Rust/C/C++ 调试器
        },
        automatic_installation = true,
        handlers = {},
      })

      -- ==================== Rust 调试配置 ====================
      -- codelldb 配置
      dap.adapters.codelldb = {
        type = 'server',
        port = '${port}',
        executable = {
          -- Mason 安装的 codelldb 路径
          command = vim.fn.stdpath('data') .. '/mason/bin/codelldb',
          args = { '--port', '${port}' },
        },
      }

      dap.configurations.rust = {
        {
          name = 'Launch',
          type = 'codelldb',
          request = 'launch',
          program = function()
            -- 自动构建并选择二进制文件
            vim.fn.jobstart('cargo build', {
              on_exit = function(_, code)
                if code ~= 0 then
                  vim.notify('Build failed!', vim.log.levels.ERROR)
                end
              end,
            })
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
          args = {},
          runInTerminal = false,
        },
        {
          name = 'Launch (with args)',
          type = 'codelldb',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
          args = function()
            local args_string = vim.fn.input('Arguments: ')
            return vim.split(args_string, ' ')
          end,
          runInTerminal = false,
        },
        {
          name = 'Attach to process',
          type = 'codelldb',
          request = 'attach',
          pid = require('dap.utils').pick_process,
          args = {},
        },
      }

      -- ==================== 自动打开/关闭 UI ====================
      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close()
      end

      -- ==================== 断点样式 ====================
      vim.fn.sign_define('DapBreakpoint', { text = ' ', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
      vim.fn.sign_define('DapBreakpointCondition', { text = ' ', texthl = 'DapBreakpointCondition', linehl = '', numhl = '' })
      vim.fn.sign_define('DapLogPoint', { text = ' ', texthl = 'DapLogPoint', linehl = '', numhl = '' })
      vim.fn.sign_define('DapStopped', { text = ' ', texthl = 'DapStopped', linehl = 'DapStoppedLine', numhl = '' })
      vim.fn.sign_define('DapBreakpointRejected', { text = ' ', texthl = 'DapBreakpointRejected', linehl = '', numhl = '' })

      -- 高亮颜色
      vim.api.nvim_set_hl(0, 'DapBreakpoint', { fg = '#f38ba8' })
      vim.api.nvim_set_hl(0, 'DapBreakpointCondition', { fg = '#f9e2af' })
      vim.api.nvim_set_hl(0, 'DapLogPoint', { fg = '#89b4fa' })
      vim.api.nvim_set_hl(0, 'DapStopped', { fg = '#a6e3a1' })
      vim.api.nvim_set_hl(0, 'DapStoppedLine', { bg = '#2d3343' })
    end,
  },
}
