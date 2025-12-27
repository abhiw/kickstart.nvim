return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  config = function()
    require('catppuccin').setup {}
    -- All flavors are available to switch between:
    -- :colorscheme catppuccin-latte (light)
    -- :colorscheme catppuccin-frappe
    -- :colorscheme catppuccin-macchiato
    -- :colorscheme catppuccin-mocha (default)
    vim.cmd.colorscheme 'catppuccin-mocha'
  end,
}
