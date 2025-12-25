-- ~/.config/nvim/lua/custom/plugins/cpp.lua
return {

  ---------------------------------------------------------------------------
  -- Treesitter: make sure C/C++ parsers are installed
  ---------------------------------------------------------------------------
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      -- ensure_installed can be a list or "all"; extend it safely
      opts.ensure_installed = opts.ensure_installed or {}
      local ensure = opts.ensure_installed
      local function add(lang)
        if type(ensure) == 'table' then
          if not vim.tbl_contains(ensure, lang) then
            table.insert(ensure, lang)
          end
        end
      end
      add 'c'
      add 'cpp'
    end,
  },

  ---------------------------------------------------------------------------
  -- LSP: clangd for C/C++
  ---------------------------------------------------------------------------
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        clangd = {
          cmd = { 'clangd', '--background-index', '--clang-tidy' },
        },
      },
    },
  },

  ---------------------------------------------------------------------------
  -- Formatting: clang-format via conform.nvim (or any formatter plugin you prefer)
  ---------------------------------------------------------------------------
  {
    'stevearc/conform.nvim',
    optional = true, -- kickstart may already include it; keep this if you only want to extend
    opts = {
      formatters_by_ft = {
        c = { 'clang_format' },
        cpp = { 'clang_format' },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
  },

  ---------------------------------------------------------------------------
  -- Debugging: Add C/C++ support via codelldb
  ---------------------------------------------------------------------------
  {
    'jay-babu/mason-nvim-dap.nvim',
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, 'codelldb')
    end,
  },

  -- Add C/C++ debug configuration after DAP is loaded
  {
    'mfussenegger/nvim-dap',
    optional = true,
    config = function()
      -- Configure C/C++ debugging
      local dap = require 'dap'

      -- Configure codelldb adapter for C/C++
      dap.adapters.codelldb = {
        type = 'server',
        port = '${port}',
        executable = {
          command = vim.fn.exepath('codelldb'), -- Use full path from PATH
          args = { '--port', '${port}' },
        },
      }

      -- C/C++ debug configurations
      dap.configurations.cpp = {
        {
          name = 'Launch file',
          type = 'codelldb',
          request = 'launch',
          program = function()
            -- Try to find executable automatically
            local cwd = vim.fn.getcwd()
            local current_file = vim.fn.expand('%:t:r') -- filename without extension

            -- List of paths to check
            local candidates = {
              cwd .. '/a.out',
              cwd .. '/' .. current_file,
              cwd .. '/build/' .. current_file,
              cwd .. '/bin/' .. current_file,
              cwd .. '/out/' .. current_file,
            }

            -- Check each candidate
            for _, path in ipairs(candidates) do
              if vim.fn.filereadable(path) == 1 then
                vim.notify('Found executable: ' .. path, vim.log.levels.INFO)
                return path
              end
            end

            -- Debug: show what we looked for
            vim.notify('No executable found in: ' .. table.concat(candidates, ', '), vim.log.levels.WARN)

            -- Fall back to prompt
            return vim.fn.input('Path to executable: ', cwd .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
        },
      }
      dap.configurations.c = dap.configurations.cpp

      -- Additional debug keybindings for C/C++
      vim.keymap.set('n', '<F6>', function() require('dap').terminate() end, { desc = 'Debug: Terminate' })
    end,
  },

  -- Compile keybindings for C/C++
  {
    'nvim-treesitter/nvim-treesitter',
    optional = true,
    config = function()
      -- Keybindings for C/C++ compilation
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'c', 'cpp' },
        callback = function()
          local buf = vim.api.nvim_get_current_buf()

          -- F9: Compile current file with debug symbols
          vim.keymap.set('n', '<F9>', function()
            local file = vim.fn.expand '%'
            local output = vim.fn.expand '%:r'
            local compiler = vim.bo.filetype == 'cpp' and 'g++' or 'gcc'
            vim.cmd('write')
            vim.cmd(string.format('!%s -g "%s" -o "%s"', compiler, file, output))
          end, { buffer = buf, desc = 'Compile with debug symbols' })

          -- F4: Compile and run
          vim.keymap.set('n', '<F4>', function()
            local file = vim.fn.expand '%'
            local output = vim.fn.expand '%:r'
            local compiler = vim.bo.filetype == 'cpp' and 'g++' or 'gcc'
            vim.cmd('write')
            vim.cmd(string.format('!%s -g "%s" -o "%s" && "./%s"', compiler, file, output, output))
          end, { buffer = buf, desc = 'Compile and run' })

          -- Leader+r: Run executable (without recompiling)
          vim.keymap.set('n', '<leader>r', function()
            local output = vim.fn.expand '%:r'
            if vim.fn.filereadable(output) == 1 then
              vim.cmd(string.format('!"./%s"', output))
            else
              vim.notify('Executable not found: ' .. output, vim.log.levels.ERROR)
            end
          end, { buffer = buf, desc = '[R]un executable' })
        end,
      })
    end,
  },
}
