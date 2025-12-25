-- Tutorial system module initialization
-- Provides public API for tutorial system

local M = {}

-- Lazy-load submodules
local progress = nil
local keybinding_sync = nil
local ui_telescope = nil
local ui_float = nil

-- Get all tutorials from content directory
function M.get_all_tutorials()
  local tutorials = {}

  -- Load Vim motions tutorials
  local vim_motion_files = {
    '01-beginner',
    '02-intermediate',
    '03-advanced',
  }

  for _, file in ipairs(vim_motion_files) do
    local ok, tutorial = pcall(require, 'custom.plugins.tutorial.content.vim-motions.' .. file)
    if ok then
      table.insert(tutorials, tutorial)
    end
  end

  -- Load keybinding tutorials
  local keybinding_files = {
    '01-core',
    '02-telescope',
    '03-lsp',
    '04-debug',
    '05-git',
    '06-file-tree',
    '07-cpp',
  }

  for _, file in ipairs(keybinding_files) do
    local ok, tutorial = pcall(require, 'custom.plugins.tutorial.content.keybindings.' .. file)
    if ok then
      table.insert(tutorials, tutorial)
    end
  end

  return tutorials
end

-- Get list of all tutorial IDs
function M.get_tutorial_ids()
  local tutorials = M.get_all_tutorials()
  local ids = {}

  for _, tutorial in ipairs(tutorials) do
    table.insert(ids, tutorial.metadata.id)
  end

  return ids
end

-- Find tutorial by ID
function M.find_tutorial_by_id(id)
  local tutorials = M.get_all_tutorials()

  for _, tutorial in ipairs(tutorials) do
    if tutorial.metadata.id == id then
      return tutorial
    end
  end

  return nil
end

-- Open tutorial browser (Telescope picker)
function M.open_browser(opts)
  if not ui_telescope then
    ui_telescope = require('custom.plugins.tutorial.ui.telescope-picker')
  end

  ui_telescope.open(opts or {})
end

-- Open specific tutorial by ID
function M.open_tutorial(id)
  local tutorial = M.find_tutorial_by_id(id)

  if not tutorial then
    vim.notify('Tutorial not found: ' .. id, vim.log.levels.ERROR)
    return
  end

  if not ui_float then
    ui_float = require('custom.plugins.tutorial.ui.floating-window')
  end

  ui_float.open(tutorial)
end

-- Show progress dashboard
function M.show_progress()
  if not progress then
    progress = require('custom.plugins.tutorial.progress')
  end

  local dashboard = progress.get_dashboard()

  -- Create a buffer to show the progress
  local buf = vim.api.nvim_create_buf(false, true)
  local lines = {}

  table.insert(lines, '╔════════════════════════════════════════════════╗')
  table.insert(lines, '║         Tutorial Progress Dashboard           ║')
  table.insert(lines, '╚════════════════════════════════════════════════╝')
  table.insert(lines, '')

  for _, item in ipairs(dashboard) do
    local status_icon = item.status == 'completed' and '✓' or
                       item.status == 'in_progress' and '◐' or '○'
    local completion = item.completion_percentage or 0

    table.insert(lines, string.format('%s [%s] %s', status_icon, item.category, item.title))
    table.insert(lines, string.format('   Progress: %d%% | Lessons: %d/%d',
      completion, item.lessons_completed or 0, item.total_lessons or 0))

    if item.time_spent_seconds and item.time_spent_seconds > 0 then
      local minutes = math.floor(item.time_spent_seconds / 60)
      table.insert(lines, string.format('   Time spent: %d minutes', minutes))
    end

    table.insert(lines, '')
  end

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false
  vim.bo[buf].buftype = 'nofile'
  vim.bo[buf].bufhidden = 'wipe'

  -- Open in floating window
  local width = 60
  local height = #lines + 2
  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = math.min(height, vim.o.lines - 4),
    col = math.floor((vim.o.columns - width) / 2),
    row = math.floor((vim.o.lines - height) / 2),
    style = 'minimal',
    border = 'rounded',
    title = ' Progress ',
    title_pos = 'center',
  })

  -- Set keymaps to close
  vim.keymap.set('n', 'q', function()
    vim.api.nvim_win_close(win, true)
  end, { buffer = buf, nowait = true })

  vim.keymap.set('n', '<Esc>', function()
    vim.api.nvim_win_close(win, true)
  end, { buffer = buf, nowait = true })
end

-- Sync keybindings from config
function M.sync_keybindings()
  if not keybinding_sync then
    keybinding_sync = require('custom.plugins.tutorial.keybinding-sync')
  end

  keybinding_sync.sync()
end

-- Check and sync keybindings on startup (with notification)
function M.check_and_sync_keybindings()
  if not keybinding_sync then
    keybinding_sync = require('custom.plugins.tutorial.keybinding-sync')
  end

  local changed = keybinding_sync.check_changes()

  if changed then
    keybinding_sync.sync()
    vim.notify('Tutorial keybindings updated to match config', vim.log.levels.INFO)
  end
end

return M
