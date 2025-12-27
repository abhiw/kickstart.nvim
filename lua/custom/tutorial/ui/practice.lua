-- Interactive practice mode for tutorials

local M = {}

-- Start practice for a specific lesson
function M.start(tutorial, lesson_index, on_close_callback)
  local lesson = tutorial.lessons[lesson_index + 1]

  if not lesson or not lesson.practice then
    vim.notify('No practice available', vim.log.levels.ERROR)
    return
  end

  -- If practice has validation tasks, use the validator
  if lesson.practice.tasks and #lesson.practice.tasks > 0 then
    local validator = require('custom.tutorial.ui.practice-validator')
    validator.start({
      tasks = lesson.practice.tasks,
      initial_content = lesson.practice.initial_content,
      on_close = on_close_callback,
    })
    return
  end

  -- Create practice buffer
  local practice_buf = vim.api.nvim_create_buf(false, true)

  -- Setup practice buffer if there's a setup function
  if lesson.practice.setup then
    local ok, result = pcall(lesson.practice.setup)
    if ok and result then
      practice_buf = result
    end
  else
    -- Default practice buffer with some sample text
    local practice_lines = {
      '─── Practice Area ───',
      '',
      'Use this buffer to practice the motions you just learned.',
      '',
      'The quick brown fox jumps over the lazy dog.',
      'Pack my box with five dozen liquor jugs.',
      '',
      'Try using the motions to navigate and edit this text efficiently.',
      '',
      'Press q to exit practice mode.',
      '',
      '─────────────────────',
    }

    vim.api.nvim_buf_set_lines(practice_buf, 0, -1, false, practice_lines)
  end

  vim.bo[practice_buf].buftype = 'nofile'
  vim.bo[practice_buf].bufhidden = 'wipe'

  -- Create instruction window
  local instruction_buf = vim.api.nvim_create_buf(false, true)
  local instruction_lines = {
    '╔═══ Practice Instructions ═══╗',
    '',
  }

  -- Split instructions if they contain newlines
  local instructions_text = lesson.practice.instructions or 'Practice the lesson content'
  local instructions_split = vim.split(instructions_text, '\n')
  for _, line in ipairs(instructions_split) do
    table.insert(instruction_lines, line)
  end

  table.insert(instruction_lines, '')

  if lesson.practice.hints then
    table.insert(instruction_lines, 'Hints:')
    for _, hint in ipairs(lesson.practice.hints) do
      -- Split hints if they contain newlines
      local hint_lines = vim.split(hint, '\n')
      for i, hint_line in ipairs(hint_lines) do
        if i == 1 then
          table.insert(instruction_lines, '  • ' .. hint_line)
        else
          table.insert(instruction_lines, '    ' .. hint_line)
        end
      end
    end
    table.insert(instruction_lines, '')
  end

  table.insert(instruction_lines, 'Press q to exit practice')
  table.insert(instruction_lines, '╚═══════════════════════════╝')

  vim.api.nvim_buf_set_lines(instruction_buf, 0, -1, false, instruction_lines)
  vim.bo[instruction_buf].modifiable = false
  vim.bo[instruction_buf].buftype = 'nofile'

  -- Split layout: instruction on top, practice on bottom
  vim.cmd('split')
  local practice_win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(practice_win, practice_buf)

  -- Create instruction window at top
  vim.cmd('aboveleft split')
  local instruction_win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(instruction_win, instruction_buf)
  vim.api.nvim_win_set_height(instruction_win, #instruction_lines + 2)

  -- Focus practice window
  vim.api.nvim_set_current_win(practice_win)

  -- Close function
  local function close_practice()
    if vim.api.nvim_win_is_valid(instruction_win) then
      vim.api.nvim_win_close(instruction_win, true)
    end
    if vim.api.nvim_win_is_valid(practice_win) then
      vim.api.nvim_win_close(practice_win, true)
    end

    -- Call callback to reopen tutorial
    if on_close_callback then
      vim.schedule(on_close_callback)
    end
  end

  -- Set keymaps to close
  vim.keymap.set('n', 'q', close_practice, { buffer = practice_buf, nowait = true })
  vim.keymap.set('n', 'q', close_practice, { buffer = instruction_buf, nowait = true })
end

return M
