-- C++ setup for the competitive-programming repo (~/workspace/tle-therapy):
-- clangd (reads the repo's .clangd for GCC 16 headers), cpp treesitter,
-- and <leader>r to build + run the current file like the Makefile does.

local gxx = '/opt/homebrew/bin/g++-16'
local flags = { '-std=c++17', '-Wall', '-Wextra', '-Wshadow', '-Wconversion', '-Wfloat-equal', '-Wduplicated-cond', '-Wlogical-op', '-g' }

local function build_and_run()
  if vim.bo.filetype ~= 'cpp' then
    vim.notify('Not a C++ buffer', vim.log.levels.WARN)
    return
  end
  vim.cmd 'silent! write'
  local src = vim.fn.expand '%:p'
  local out = vim.fn.tempname()
  local cmd = table.concat({
    vim.fn.shellescape(gxx),
    table.concat(flags, ' '),
    vim.fn.shellescape(src),
    '-o',
    vim.fn.shellescape(out),
    '&&',
    vim.fn.shellescape(out),
  }, ' ')
  -- Terminal split so stdin works (paste sample input, then Ctrl-D).
  vim.cmd('botright 15split | terminal ' .. cmd)
  vim.cmd 'startinsert'
end

return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'cpp' } },
  },

  {
    -- Config-only spec: native LSP setup, no plugin to load.
    name = 'cpp-lsp',
    dir = vim.fn.stdpath 'config',
    config = function()
      vim.lsp.config('clangd', {
        cmd = { 'clangd', '--background-index', '--clang-tidy=false' },
        filetypes = { 'c', 'cpp' },
        root_markers = { '.clangd', 'compile_commands.json', 'compile_flags.txt', '.git' },
      })
      vim.lsp.enable 'clangd'

      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'cpp',
        callback = function(ev)
          vim.keymap.set('n', '<leader>r', build_and_run, { buffer = ev.buf, desc = '[R]un current C++ file' })
        end,
      })
    end,
  },

  {
    dir = vim.fn.expand '~/workspace/keyhint.nvim',
    name = 'keyhint.nvim',
    lazy = false,
    opts = {
      corner = 'bottom-right',
      items = {
        { 'Space r', 'build & run' },
        { 'Space s f', 'find files' },
        { 'Space s g', 'search text' },
        { 'g r d', 'go to definition' },
        { 'Shift+k', 'hover docs' },
        { '\\', 'file tree' },
      },
    },
  },
}
