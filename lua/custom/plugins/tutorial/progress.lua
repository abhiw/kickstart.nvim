-- Tutorial progress tracking system
-- Stores progress in JSON format at ~/.local/state/nvim/tutorial-progress.json

local M = {}

-- Get the progress file path
local function get_progress_file()
  local state_dir = vim.fn.stdpath('state')
  return state_dir .. '/tutorial-progress.json'
end

-- Load progress data from file
local function load_progress()
  local file_path = get_progress_file()
  local file = io.open(file_path, 'r')

  if not file then
    return {}
  end

  local content = file:read('*all')
  file:close()

  if content == '' then
    return {}
  end

  local ok, data = pcall(vim.json.decode, content)
  if not ok then
    vim.notify('Failed to parse tutorial progress file', vim.log.levels.WARN)
    return {}
  end

  return data
end

-- Save progress data to file
local function save_progress(data)
  local file_path = get_progress_file()
  local file = io.open(file_path, 'w')

  if not file then
    vim.notify('Failed to save tutorial progress', vim.log.levels.ERROR)
    return false
  end

  local json = vim.json.encode(data)
  file:write(json)
  file:close()

  return true
end

-- Get progress for a specific tutorial
function M.get_tutorial_progress(tutorial_id)
  local data = load_progress()
  return data[tutorial_id] or {
    status = 'not_started',
    lessons_completed = {},
    last_accessed = nil,
    practice_count = 0,
    time_spent_seconds = 0,
  }
end

-- Mark a lesson as completed
function M.mark_completed(tutorial_id, lesson_index)
  local data = load_progress()

  if not data[tutorial_id] then
    data[tutorial_id] = {
      status = 'not_started',
      lessons_completed = {},
      last_accessed = nil,
      practice_count = 0,
      time_spent_seconds = 0,
    }
  end

  -- Add lesson to completed list if not already there
  local completed = data[tutorial_id].lessons_completed or {}
  local already_completed = false

  for _, idx in ipairs(completed) do
    if idx == lesson_index then
      already_completed = true
      break
    end
  end

  if not already_completed then
    table.insert(completed, lesson_index)
    data[tutorial_id].lessons_completed = completed
  end

  -- Update status
  data[tutorial_id].status = 'in_progress'
  data[tutorial_id].last_accessed = os.date('%Y-%m-%dT%H:%M:%S')

  save_progress(data)
end

-- Mark entire tutorial as completed
function M.mark_tutorial_completed(tutorial_id)
  local data = load_progress()

  if not data[tutorial_id] then
    data[tutorial_id] = {
      lessons_completed = {},
      practice_count = 0,
      time_spent_seconds = 0,
    }
  end

  data[tutorial_id].status = 'completed'
  data[tutorial_id].last_accessed = os.date('%Y-%m-%dT%H:%M:%S')

  save_progress(data)
end

-- Update last accessed time
function M.update_accessed(tutorial_id)
  local data = load_progress()

  if not data[tutorial_id] then
    data[tutorial_id] = {
      status = 'not_started',
      lessons_completed = {},
      practice_count = 0,
      time_spent_seconds = 0,
    }
  end

  data[tutorial_id].last_accessed = os.date('%Y-%m-%dT%H:%M:%S')

  save_progress(data)
end

-- Increment practice count
function M.increment_practice_count(tutorial_id)
  local data = load_progress()

  if not data[tutorial_id] then
    data[tutorial_id] = {
      status = 'not_started',
      lessons_completed = {},
      practice_count = 0,
      time_spent_seconds = 0,
    }
  end

  data[tutorial_id].practice_count = (data[tutorial_id].practice_count or 0) + 1

  save_progress(data)
end

-- Add time spent
function M.add_time_spent(tutorial_id, seconds)
  local data = load_progress()

  if not data[tutorial_id] then
    data[tutorial_id] = {
      status = 'not_started',
      lessons_completed = {},
      practice_count = 0,
      time_spent_seconds = 0,
    }
  end

  data[tutorial_id].time_spent_seconds = (data[tutorial_id].time_spent_seconds or 0) + seconds

  save_progress(data)
end

-- Get status (not_started, in_progress, completed)
function M.get_status(tutorial_id)
  local progress = M.get_tutorial_progress(tutorial_id)
  return progress.status or 'not_started'
end

-- Get completion percentage
function M.get_completion_percentage(tutorial_id, total_lessons)
  local progress = M.get_tutorial_progress(tutorial_id)
  local completed_count = #(progress.lessons_completed or {})

  if total_lessons == 0 then
    return 0
  end

  return math.floor((completed_count / total_lessons) * 100)
end

-- Reset progress for a tutorial
function M.reset(tutorial_id)
  local data = load_progress()
  data[tutorial_id] = nil
  save_progress(data)
end

-- Reset all progress
function M.reset_all()
  save_progress({})
end

-- Get dashboard data (summary of all tutorials)
function M.get_dashboard()
  local tutorial_module = require('custom.plugins.tutorial')
  local tutorials = tutorial_module.get_all_tutorials()
  local dashboard = {}

  for _, tutorial in ipairs(tutorials) do
    local id = tutorial.metadata.id
    local progress = M.get_tutorial_progress(id)
    local total_lessons = #tutorial.lessons
    local completed_lessons = #(progress.lessons_completed or {})
    local completion = M.get_completion_percentage(id, total_lessons)

    table.insert(dashboard, {
      id = id,
      title = tutorial.metadata.title,
      category = tutorial.metadata.category,
      difficulty = tutorial.metadata.difficulty,
      status = progress.status or 'not_started',
      completion_percentage = completion,
      lessons_completed = completed_lessons,
      total_lessons = total_lessons,
      last_accessed = progress.last_accessed,
      practice_count = progress.practice_count or 0,
      time_spent_seconds = progress.time_spent_seconds or 0,
    })
  end

  return dashboard
end

return M
