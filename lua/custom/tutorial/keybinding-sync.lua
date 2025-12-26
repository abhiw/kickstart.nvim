-- Keybinding synchronization module
-- Auto-extracts keybindings from config files and detects changes

local M = {}

-- Cache file for storing last known keybindings
local function get_cache_file()
  local state_dir = vim.fn.stdpath('state')
  return state_dir .. '/tutorial-keybindings-cache.json'
end

-- Extract all keymaps from Neovim
local function get_all_keymaps()
  local keymaps = {}
  local modes = { 'n', 'i', 'v', 'x', 't', 'o', 'c' }

  for _, mode in ipairs(modes) do
    local maps = vim.api.nvim_get_keymap(mode)

    for _, map in ipairs(maps) do
      -- Only include keymaps that have descriptions (likely user-defined)
      if map.desc and map.desc ~= '' then
        table.insert(keymaps, {
          mode = mode,
          lhs = map.lhs,
          desc = map.desc,
          rhs = map.rhs or '',
        })
      end
    end
  end

  return keymaps
end

-- Load cached keybindings
local function load_cache()
  local file_path = get_cache_file()
  local file = io.open(file_path, 'r')

  if not file then
    return nil
  end

  local content = file:read('*all')
  file:close()

  if content == '' then
    return nil
  end

  local ok, data = pcall(vim.json.decode, content)
  if not ok then
    return nil
  end

  return data
end

-- Save keybindings to cache
local function save_cache(keymaps)
  local file_path = get_cache_file()
  local file = io.open(file_path, 'w')

  if not file then
    return false
  end

  local json = vim.json.encode(keymaps)
  file:write(json)
  file:close()

  return true
end

-- Compare two keymap sets and detect changes
local function compare_keymaps(old_maps, new_maps)
  if not old_maps then
    return true -- First run, consider it changed
  end

  -- Quick check: different count means changes
  if #old_maps ~= #new_maps then
    return true
  end

  -- Create lookup tables
  local old_lookup = {}
  for _, map in ipairs(old_maps) do
    local key = string.format('%s:%s', map.mode, map.lhs)
    old_lookup[key] = map
  end

  local new_lookup = {}
  for _, map in ipairs(new_maps) do
    local key = string.format('%s:%s', map.mode, map.lhs)
    new_lookup[key] = map
  end

  -- Check for differences
  for key, old_map in pairs(old_lookup) do
    local new_map = new_lookup[key]

    if not new_map or new_map.desc ~= old_map.desc then
      return true
    end
  end

  for key in pairs(new_lookup) do
    if not old_lookup[key] then
      return true
    end
  end

  return false
end

-- Check if keybindings have changed since last sync
function M.check_changes()
  local current_maps = get_all_keymaps()
  local cached_maps = load_cache()

  return compare_keymaps(cached_maps, current_maps)
end

-- Sync keybindings (update cache)
function M.sync()
  local current_maps = get_all_keymaps()
  save_cache(current_maps)
end

-- Get keybindings organized by category
function M.get_categorized_keybindings()
  local keymaps = get_all_keymaps()
  local categories = {
    core = {},
    telescope = {},
    lsp = {},
    debug = {},
    git = {},
    file_tree = {},
    cpp = {},
    other = {},
  }

  for _, map in ipairs(keymaps) do
    local lhs = map.lhs
    local desc = map.desc:lower()

    -- Categorize based on leader prefix and description
    if desc:match('telescope') or desc:match('search') or desc:match('find') then
      table.insert(categories.telescope, map)
    elseif desc:match('lsp') or lhs:match('^gr') or desc:match('definition') or desc:match('reference') or desc:match('rename') then
      table.insert(categories.lsp, map)
    elseif desc:match('debug') or desc:match('breakpoint') or lhs:match('^<F[1-7]>') then
      table.insert(categories.debug, map)
    elseif desc:match('git') or desc:match('hunk') or desc:match('blame') or desc:match('diff') then
      table.insert(categories.git, map)
    elseif desc:match('neo') or desc:match('tree') or desc:match('file') and desc:match('buffer') then
      table.insert(categories.file_tree, map)
    elseif desc:match('c%+%+') or desc:match('cpp') or desc:match('compile') then
      table.insert(categories.cpp, map)
    elseif lhs:match('^<C%-[hjkl]>') or desc:match('window') or desc:match('format') or desc:match('diagnostic') then
      table.insert(categories.core, map)
    else
      table.insert(categories.other, map)
    end
  end

  return categories
end

-- Detect conflicts (same keybinding with different descriptions)
function M.detect_conflicts()
  local keymaps = get_all_keymaps()
  local conflicts = {}
  local seen = {}

  for _, map in ipairs(keymaps) do
    local key = string.format('%s:%s', map.mode, map.lhs)

    if seen[key] then
      -- Conflict detected
      table.insert(conflicts, {
        keys = map.lhs,
        mode = map.mode,
        mappings = {
          seen[key],
          map,
        },
      })
    else
      seen[key] = map
    end
  end

  return conflicts
end

return M
