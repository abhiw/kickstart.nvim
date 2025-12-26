-- Interactive practice validator similar to Vim's :Tutor
-- Validates user actions and provides real-time feedback

local M = {}

-- Namespace for extmarks
local ns_id = vim.api.nvim_create_namespace('tutorial_validator')

-- State for current practice session
local state = {
  tasks = {},
  current_task_index = 1,
  practice_buf = nil,
  instruction_buf = nil,
  practice_win = nil,
  instruction_win = nil,
  on_complete_callback = nil,
  verification_marks = {}, -- Track verification extmarks
}

-- Validate cursor position
local function validate_cursor_position(expected_line, expected_col)
  local pos = vim.api.nvim_win_get_cursor(state.practice_win)
  local line, col = pos[1], pos[2] + 1 -- Convert to 1-indexed
  return line == expected_line and col == expected_col
end

-- Validate cursor on word
local function validate_cursor_on_word(word)
  local pos = vim.api.nvim_win_get_cursor(state.practice_win)
  local line = vim.api.nvim_buf_get_lines(state.practice_buf, pos[1] - 1, pos[1], false)[1]
  local col = pos[2]

  -- Get word under cursor
  local word_start = col
  local word_end = col

  while word_start > 0 and line:sub(word_start, word_start):match('[%w_]') do
    word_start = word_start - 1
  end
  word_start = word_start + 1

  while word_end <= #line and line:sub(word_end + 1, word_end + 1):match('[%w_]') do
    word_end = word_end + 1
  end

  local current_word = line:sub(word_start, word_end)
  return current_word == word
end

-- Validate buffer content
local function validate_buffer_content(expected_lines)
  local lines = vim.api.nvim_buf_get_lines(state.practice_buf, 0, -1, false)
  if #lines ~= #expected_lines then
    return false
  end

  for i, line in ipairs(lines) do
    if line ~= expected_lines[i] then
      return false
    end
  end

  return true
end

-- Validate buffer line
local function validate_line_content(line_num, expected_content)
  local lines = vim.api.nvim_buf_get_lines(state.practice_buf, line_num - 1, line_num, false)
  return lines[1] == expected_content
end

-- Check if current task is complete
local function check_task_completion()
  local task = state.tasks[state.current_task_index]
  if not task or not task.validate then
    return false
  end

  -- Call validation function
  local ok, result = pcall(task.validate)
  return ok and result
end

-- Update instruction window with current task
local function update_instructions()
  if not state.instruction_buf or not vim.api.nvim_buf_is_valid(state.instruction_buf) then
    return
  end

  local task = state.tasks[state.current_task_index]
  if not task then
    return
  end

  local lines = {
    string.format('╔═══ Step %d/%d ═══╗', state.current_task_index, #state.tasks),
    '',
  }

  -- Task instruction
  local instruction_lines = vim.split(task.instruction, '\n')
  for _, line in ipairs(instruction_lines) do
    table.insert(lines, line)
  end

  table.insert(lines, '')

  -- Hint if available
  if task.hint then
    table.insert(lines, '💡 Hint: ' .. task.hint)
    table.insert(lines, '')
  end

  -- Controls
  table.insert(lines, '────────────────────────')
  table.insert(lines, 'v = Verify | n = Next step | p = Previous step | q = Quit')
  table.insert(lines, '╚═══════════════════════╝')

  vim.bo[state.instruction_buf].modifiable = true
  vim.api.nvim_buf_set_lines(state.instruction_buf, 0, -1, false, lines)
  vim.bo[state.instruction_buf].modifiable = false
end

-- Clear all verification marks
local function clear_verification_marks()
  if state.practice_buf and vim.api.nvim_buf_is_valid(state.practice_buf) then
    vim.api.nvim_buf_clear_namespace(state.practice_buf, ns_id, 0, -1)
  end
  state.verification_marks = {}
end

-- Show visual feedback for verification
local function show_verification_feedback(is_correct, line)
  if not state.practice_buf or not vim.api.nvim_buf_is_valid(state.practice_buf) then
    return
  end

  -- Clear previous marks
  clear_verification_marks()

  -- Determine line to mark (use cursor line if not specified)
  local mark_line = line
  if not mark_line then
    local pos = vim.api.nvim_win_get_cursor(state.practice_win)
    mark_line = pos[1] - 1 -- Convert to 0-indexed
  else
    mark_line = mark_line - 1 -- Convert to 0-indexed
  end

  -- Ensure line is valid
  local line_count = vim.api.nvim_buf_line_count(state.practice_buf)
  if mark_line < 0 or mark_line >= line_count then
    mark_line = 0
  end

  -- Create visual feedback
  if is_correct then
    -- Green checkmark
    local mark_id = vim.api.nvim_buf_set_extmark(state.practice_buf, ns_id, mark_line, 0, {
      virt_text = { { '  ✓', 'DiagnosticOk' } },
      virt_text_pos = 'eol',
    })
    table.insert(state.verification_marks, mark_id)
  else
    -- Red cross
    local mark_id = vim.api.nvim_buf_set_extmark(state.practice_buf, ns_id, mark_line, 0, {
      virt_text = { { '  ✗', 'DiagnosticError' } },
      virt_text_pos = 'eol',
    })
    table.insert(state.verification_marks, mark_id)
  end
end

-- Manually verify current task
local function verify_task()
  local task = state.tasks[state.current_task_index]
  if not task then
    return
  end

  -- If no validation function, just provide encouragement
  if not task.validate then
    vim.notify('Keep practicing! Move to the next step when ready.', vim.log.levels.INFO)
    return
  end

  local is_correct = check_task_completion()

  -- Show visual feedback
  local feedback_line = task.feedback_line -- Optional: specific line to mark
  show_verification_feedback(is_correct, feedback_line)

  if is_correct then
    vim.notify('✓ Correct! Well done!', vim.log.levels.INFO)
  else
    vim.notify('✗ Not quite. Try again or check the hint.', vim.log.levels.WARN)
  end
end

-- Move to next step
local function next_step()
  if state.current_task_index >= #state.tasks then
    vim.notify('This is the last step. Press q to exit.', vim.log.levels.INFO)
    return
  end

  -- Clear verification marks when moving to next step
  clear_verification_marks()

  state.current_task_index = state.current_task_index + 1
  update_instructions()

  -- Run setup for new task if available
  local task = state.tasks[state.current_task_index]
  if task.setup then
    pcall(task.setup)
  end
end

-- Move to previous step
local function prev_step()
  if state.current_task_index <= 1 then
    vim.notify('This is the first step.', vim.log.levels.INFO)
    return
  end

  -- Clear verification marks when moving to previous step
  clear_verification_marks()

  state.current_task_index = state.current_task_index - 1
  update_instructions()

  -- Run setup for new task if available
  local task = state.tasks[state.current_task_index]
  if task.setup then
    pcall(task.setup)
  end
end

-- Close practice mode
local function close_practice()
  if state.instruction_win and vim.api.nvim_win_is_valid(state.instruction_win) then
    vim.api.nvim_win_close(state.instruction_win, true)
  end
  if state.practice_win and vim.api.nvim_win_is_valid(state.practice_win) then
    vim.api.nvim_win_close(state.practice_win, true)
  end

  if state.on_complete_callback then
    vim.schedule(state.on_complete_callback)
  end

  -- Reset state
  state = {
    tasks = {},
    current_task_index = 1,
    practice_buf = nil,
    instruction_buf = nil,
    practice_win = nil,
    instruction_win = nil,
    on_complete_callback = nil,
  }
end

-- Start validated practice session
function M.start(config)
  state.tasks = config.tasks or {}
  state.on_complete_callback = config.on_close

  if #state.tasks == 0 then
    vim.notify('No tasks defined for this practice', vim.log.levels.ERROR)
    return
  end

  -- Create practice buffer
  state.practice_buf = vim.api.nvim_create_buf(false, true)

  -- Set initial content
  if config.initial_content then
    vim.api.nvim_buf_set_lines(state.practice_buf, 0, -1, false, config.initial_content)
  end

  vim.bo[state.practice_buf].buftype = 'nofile'
  vim.bo[state.practice_buf].bufhidden = 'wipe'

  -- Create instruction buffer
  state.instruction_buf = vim.api.nvim_create_buf(false, true)
  vim.bo[state.instruction_buf].modifiable = false
  vim.bo[state.instruction_buf].buftype = 'nofile'

  -- Create split layout
  vim.cmd('split')
  state.practice_win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(state.practice_win, state.practice_buf)

  vim.cmd('aboveleft split')
  state.instruction_win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(state.instruction_win, state.instruction_buf)

  -- Update instructions
  update_instructions()

  -- Resize instruction window
  local instruction_height = #vim.api.nvim_buf_get_lines(state.instruction_buf, 0, -1, false) + 1
  vim.api.nvim_win_set_height(state.instruction_win, instruction_height)

  -- Focus practice window
  vim.api.nvim_set_current_win(state.practice_win)

  -- Run first task setup if available
  local first_task = state.tasks[1]
  if first_task.setup then
    pcall(first_task.setup)
  end

  -- Set keymaps for practice buffer
  local opts = { buffer = state.practice_buf, nowait = true, silent = true }
  vim.keymap.set('n', 'v', verify_task, opts)
  vim.keymap.set('n', 'n', next_step, opts)
  vim.keymap.set('n', 'p', prev_step, opts)
  vim.keymap.set('n', 'q', close_practice, opts)
  vim.keymap.set('n', '<Esc>', close_practice, opts)

  -- Set keymaps for instruction buffer
  local inst_opts = { buffer = state.instruction_buf, nowait = true, silent = true }
  vim.keymap.set('n', 'v', verify_task, inst_opts)
  vim.keymap.set('n', 'n', next_step, inst_opts)
  vim.keymap.set('n', 'p', prev_step, inst_opts)
  vim.keymap.set('n', 'q', close_practice, inst_opts)
  vim.keymap.set('n', '<Esc>', close_practice, inst_opts)
end

-- Validate multiple lines and show per-line feedback
local function validate_lines_with_feedback(line_validations)
  if not state.practice_buf or not vim.api.nvim_buf_is_valid(state.practice_buf) then
    return false
  end

  clear_verification_marks()

  local all_correct = true
  for _, validation in ipairs(line_validations) do
    local line_num = validation.line
    local expected = validation.expected
    local actual_lines = vim.api.nvim_buf_get_lines(state.practice_buf, line_num - 1, line_num, false)
    local actual = actual_lines[1] or ''

    local is_correct = (actual == expected)
    all_correct = all_correct and is_correct

    -- Show feedback for this line
    local mark_id
    if is_correct then
      mark_id = vim.api.nvim_buf_set_extmark(state.practice_buf, ns_id, line_num - 1, 0, {
        virt_text = { { '  ✓', 'DiagnosticOk' } },
        virt_text_pos = 'eol',
      })
    else
      mark_id = vim.api.nvim_buf_set_extmark(state.practice_buf, ns_id, line_num - 1, 0, {
        virt_text = { { '  ✗', 'DiagnosticError' } },
        virt_text_pos = 'eol',
      })
    end
    table.insert(state.verification_marks, mark_id)
  end

  return all_correct
end

-- Export validation helpers for use in task definitions
M.validators = {
  cursor_position = validate_cursor_position,
  cursor_on_word = validate_cursor_on_word,
  buffer_content = validate_buffer_content,
  line_content = validate_line_content,
  lines_with_feedback = validate_lines_with_feedback,
}

-- Export visual feedback function for custom validators
M.show_feedback = show_verification_feedback
M.clear_marks = clear_verification_marks

return M
