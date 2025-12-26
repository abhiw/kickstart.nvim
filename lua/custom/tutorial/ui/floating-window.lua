-- Floating window for interactive tutorial viewing

local M = {}

-- State for the current tutorial session
local state = {
  tutorial = nil,
  current_lesson_index = 0,
  win = nil,
  buf = nil,
  start_time = nil,
}

-- Format lesson content for display
local function format_lesson(tutorial, lesson_index)
  local lesson = tutorial.lessons[lesson_index + 1]
  if not lesson then
    return {}
  end

  local lines = {}

  -- Header
  table.insert(lines, '╔════════════════════════════════════════════════════════════════╗')
  table.insert(lines, string.format('║  %s', tutorial.metadata.title))
  table.insert(lines, string.format('║  Lesson %d/%d: %s', lesson_index + 1, #tutorial.lessons, lesson.title))
  table.insert(lines, '╚════════════════════════════════════════════════════════════════╝')
  table.insert(lines, '')

  -- Lesson content
  local content_lines = vim.split(lesson.content, '\n')
  for _, line in ipairs(content_lines) do
    table.insert(lines, line)
  end

  table.insert(lines, '')
  table.insert(lines, '────────────────────────────────────────────────────────────────')
  table.insert(lines, '')

  -- Practice section
  if lesson.practice then
    table.insert(lines, '## Practice')
    table.insert(lines, '')
    table.insert(lines, lesson.practice.instructions or '')
    table.insert(lines, '')

    if lesson.practice.type == 'interactive' then
      table.insert(lines, 'Press `i` to start interactive practice')
      table.insert(lines, 'Press `?` to show hints')
    end

    table.insert(lines, '')
  end

  -- Navigation help
  table.insert(lines, '────────────────────────────────────────────────────────────────')
  table.insert(lines, 'Navigation: n=Next | p=Previous | m=Mark Complete | q=Quit | i=Practice')

  return lines
end

-- Navigate to next lesson
local function next_lesson()
  if not state.tutorial then
    return
  end

  if state.current_lesson_index < #state.tutorial.lessons - 1 then
    state.current_lesson_index = state.current_lesson_index + 1
    M.refresh_content()
  else
    vim.notify('This is the last lesson', vim.log.levels.INFO)
  end
end

-- Navigate to previous lesson
local function prev_lesson()
  if not state.tutorial then
    return
  end

  if state.current_lesson_index > 0 then
    state.current_lesson_index = state.current_lesson_index - 1
    M.refresh_content()
  else
    vim.notify('This is the first lesson', vim.log.levels.INFO)
  end
end

-- Mark current lesson as complete
local function mark_complete()
  if not state.tutorial then
    return
  end

  local progress = require('custom.tutorial.progress')
  progress.mark_completed(state.tutorial.metadata.id, state.current_lesson_index)

  vim.notify('Lesson marked as complete!', vim.log.levels.INFO)

  -- Check if all lessons are complete
  local total = #state.tutorial.lessons
  local prog_data = progress.get_tutorial_progress(state.tutorial.metadata.id)
  local completed_count = #(prog_data.lessons_completed or {})

  if completed_count >= total then
    progress.mark_tutorial_completed(state.tutorial.metadata.id)
    vim.notify('Congratulations! Tutorial completed!', vim.log.levels.INFO)
  end

  M.refresh_content()
end

-- Show hints for current lesson
local function show_hints()
  if not state.tutorial then
    return
  end

  local lesson = state.tutorial.lessons[state.current_lesson_index + 1]
  if not lesson or not lesson.practice or not lesson.practice.hints then
    vim.notify('No hints available for this lesson', vim.log.levels.INFO)
    return
  end

  local hints = lesson.practice.hints
  local hint_text = table.concat(hints, '\n• ')

  -- Show hints in a small floating window
  local hint_buf = vim.api.nvim_create_buf(false, true)
  local hint_lines = { 'Hints:', '' }

  for _, hint in ipairs(hints) do
    table.insert(hint_lines, '• ' .. hint)
  end

  vim.api.nvim_buf_set_lines(hint_buf, 0, -1, false, hint_lines)

  local hint_win = vim.api.nvim_open_win(hint_buf, false, {
    relative = 'cursor',
    width = 50,
    height = #hint_lines,
    row = 1,
    col = 0,
    style = 'minimal',
    border = 'rounded',
  })

  -- Auto-close after 5 seconds or on any key
  vim.defer_fn(function()
    if vim.api.nvim_win_is_valid(hint_win) then
      vim.api.nvim_win_close(hint_win, true)
    end
  end, 5000)
end

-- Start practice mode
local function start_practice()
  if not state.tutorial then
    return
  end

  local lesson = state.tutorial.lessons[state.current_lesson_index + 1]
  if not lesson or not lesson.practice then
    vim.notify('No practice available for this lesson', vim.log.levels.INFO)
    return
  end

  -- Save current state
  local saved_tutorial = state.tutorial
  local saved_lesson_index = state.current_lesson_index

  -- Close tutorial window temporarily
  if state.win and vim.api.nvim_win_is_valid(state.win) then
    vim.api.nvim_win_close(state.win, true)
  end

  local practice_module = require('custom.tutorial.ui.practice')
  practice_module.start(state.tutorial, state.current_lesson_index, function()
    -- Callback to reopen tutorial when practice ends
    M.open(saved_tutorial, saved_lesson_index)
  end)

  -- Increment practice count
  local progress = require('custom.tutorial.progress')
  progress.increment_practice_count(state.tutorial.metadata.id)
end

-- Refresh the tutorial window content
function M.refresh_content()
  if not state.buf or not vim.api.nvim_buf_is_valid(state.buf) then
    return
  end

  local lines = format_lesson(state.tutorial, state.current_lesson_index)

  vim.bo[state.buf].modifiable = true
  vim.api.nvim_buf_set_lines(state.buf, 0, -1, false, lines)
  vim.bo[state.buf].modifiable = false
end

-- Close the tutorial window
local function close_window()
  if state.win and vim.api.nvim_win_is_valid(state.win) then
    vim.api.nvim_win_close(state.win, true)
  end

  -- Save time spent
  if state.start_time and state.tutorial then
    local elapsed = os.time() - state.start_time
    local progress = require('custom.tutorial.progress')
    progress.add_time_spent(state.tutorial.metadata.id, elapsed)
  end

  state = {
    tutorial = nil,
    current_lesson_index = 0,
    win = nil,
    buf = nil,
    start_time = nil,
  }
end

-- Open tutorial in floating window
function M.open(tutorial, lesson_index)
  lesson_index = lesson_index or 0

  -- Store state
  state.tutorial = tutorial
  state.current_lesson_index = lesson_index
  state.start_time = os.time()

  -- Update progress
  local progress = require('custom.tutorial.progress')
  progress.update_accessed(tutorial.metadata.id)

  -- Create buffer
  local buf = vim.api.nvim_create_buf(false, true)
  state.buf = buf

  -- Set buffer content
  local lines = format_lesson(tutorial, lesson_index)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  -- Buffer options
  vim.bo[buf].modifiable = false
  vim.bo[buf].buftype = 'nofile'
  vim.bo[buf].bufhidden = 'wipe'
  vim.bo[buf].filetype = 'markdown'

  -- Calculate window size
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)

  -- Open window
  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    col = math.floor((vim.o.columns - width) / 2),
    row = math.floor((vim.o.lines - height) / 2),
    style = 'minimal',
    border = 'rounded',
    title = ' ' .. tutorial.metadata.title .. ' ',
    title_pos = 'center',
  })

  state.win = win

  -- Set keymaps
  local opts = { buffer = buf, nowait = true, silent = true }

  vim.keymap.set('n', 'q', close_window, opts)
  vim.keymap.set('n', '<Esc>', close_window, opts)
  vim.keymap.set('n', 'n', next_lesson, opts)
  vim.keymap.set('n', 'p', prev_lesson, opts)
  vim.keymap.set('n', 'm', mark_complete, opts)
  vim.keymap.set('n', '?', show_hints, opts)
  vim.keymap.set('n', 'i', start_practice, opts)

  -- Auto-close on buffer delete
  vim.api.nvim_create_autocmd('BufDelete', {
    buffer = buf,
    callback = close_window,
    once = true,
  })
end

return M
