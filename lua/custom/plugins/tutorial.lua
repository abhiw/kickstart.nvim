-- Interactive tutorial system for Vim motions and custom keybindings
-- Provides progressive learning with practice exercises and progress tracking

return {
  'nvim-telescope/telescope.nvim',
  optional = true,
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  keys = {
    { '<leader>st', '<cmd>Tutorials<cr>', desc = '[S]earch [T]utorials' },
    { '<leader>tp', '<cmd>TutorialProgress<cr>', desc = '[T]utorial [P]rogress' },
  },
  config = function()
    -- Load the tutorial module
    local tutorial = require('custom.plugins.tutorial')

    -- Register commands
    vim.api.nvim_create_user_command('Tutorials', function()
      tutorial.open_browser()
    end, { desc = 'Open tutorial browser' })

    vim.api.nvim_create_user_command('Tutorial', function(opts)
      tutorial.open_tutorial(opts.args)
    end, {
      nargs = 1,
      complete = function()
        return tutorial.get_tutorial_ids()
      end,
      desc = 'Open specific tutorial by ID',
    })

    vim.api.nvim_create_user_command('TutorialProgress', function()
      tutorial.show_progress()
    end, { desc = 'Show tutorial progress dashboard' })

    vim.api.nvim_create_user_command('TutorialKeybindingSync', function()
      tutorial.sync_keybindings()
      vim.notify('Tutorial keybindings synced successfully!', vim.log.levels.INFO)
    end, { desc = 'Manually sync keybindings from config' })

    -- Auto-sync keybindings on startup
    vim.api.nvim_create_autocmd('VimEnter', {
      callback = function()
        tutorial.check_and_sync_keybindings()
      end,
      desc = 'Auto-sync tutorial keybindings on startup',
    })

    -- Register which-key groups if available
    local ok, which_key = pcall(require, 'which-key')
    if ok then
      which_key.add({
        { '<leader>t', group = '[T]oggle/[T]utorial' },
      })
    end
  end,
}
