-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
    { '<leader>fb', ':Neotree buffers reveal<CR>', desc = 'NeoTree [F]ile [B]uffers', silent = true },
  },
  opts = {
    sources = { 'filesystem', 'buffers' },
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
          [']'] = 'next_source',
          ['['] = 'prev_source',
        },
      },
    },
    buffers = {
      follow_current_file = {
        enabled = true,
      },
      window = {
        mappings = {
          ['\\'] = 'close_window',
          [']'] = 'next_source',
          ['['] = 'prev_source',
          ['d'] = 'buffer_delete',
        },
      },
    },
  },
}
