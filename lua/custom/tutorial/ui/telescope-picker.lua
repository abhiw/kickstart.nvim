-- Telescope picker for browsing tutorials

local M = {}

function M.open(opts)
  opts = opts or {}

  -- Check if telescope is available
  local has_telescope, telescope = pcall(require, 'telescope')
  if not has_telescope then
    vim.notify('Telescope is required for tutorial browser', vim.log.levels.ERROR)
    return
  end

  local pickers = require('telescope.pickers')
  local finders = require('telescope.finders')
  local conf = require('telescope.config').values
  local actions = require('telescope.actions')
  local action_state = require('telescope.actions.state')
  local previewers = require('telescope.previewers')

  local tutorial_module = require('custom.tutorial')
  local progress_module = require('custom.tutorial.progress')
  local tutorials = tutorial_module.get_all_tutorials()

  -- Filter tutorials based on options
  local filtered_tutorials = vim.tbl_filter(function(tutorial)
    if opts.category and tutorial.metadata.category ~= opts.category then
      return false
    end

    if opts.difficulty and tutorial.metadata.difficulty ~= opts.difficulty then
      return false
    end

    if opts.hide_completed then
      local status = progress_module.get_status(tutorial.metadata.id)
      if status == 'completed' then
        return false
      end
    end

    return true
  end, tutorials)

  pickers
    .new(opts, {
      prompt_title = 'Vim Tutorials',
      finder = finders.new_table {
        results = filtered_tutorials,
        entry_maker = function(entry)
          local status = progress_module.get_status(entry.metadata.id)
          local icon = status == 'completed' and '✓' or status == 'in_progress' and '◐' or '○'

          local difficulty_badge = string.format('[%s]', entry.metadata.difficulty:upper())
          local display = string.format('%s %s %s', icon, difficulty_badge, entry.metadata.title)

          return {
            value = entry,
            display = display,
            ordinal = entry.metadata.title .. ' ' .. entry.metadata.category,
          }
        end,
      },
      sorter = conf.generic_sorter(opts),
      previewer = previewers.new_buffer_previewer {
        title = 'Tutorial Preview',
        define_preview = function(self, entry)
          local tutorial = entry.value
          local lines = {}

          -- Metadata section
          -- Split title if it contains newlines
          local title_lines = vim.split(tutorial.metadata.title, '\n')
          table.insert(lines, '# ' .. title_lines[1])
          for i = 2, #title_lines do
            table.insert(lines, title_lines[i])
          end

          table.insert(lines, '')
          table.insert(lines, '**Category:** ' .. tutorial.metadata.category)
          table.insert(lines, '**Difficulty:** ' .. tutorial.metadata.difficulty)
          table.insert(lines, '**Estimated Time:** ' .. (tutorial.metadata.estimated_time or 'N/A'))
          table.insert(lines, '')

          -- Split description if it contains newlines
          local description = tutorial.metadata.description or ''
          local desc_lines = vim.split(description, '\n')
          for _, line in ipairs(desc_lines) do
            table.insert(lines, line)
          end

          table.insert(lines, '')
          table.insert(lines, '---')
          table.insert(lines, '')

          -- Lessons overview
          table.insert(lines, '## Lessons (' .. #tutorial.lessons .. ')')
          table.insert(lines, '')

          local progress = progress_module.get_tutorial_progress(tutorial.metadata.id)
          local completed_lessons = progress.lessons_completed or {}

          for i, lesson in ipairs(tutorial.lessons) do
            local is_completed = vim.tbl_contains(completed_lessons, i - 1)
            local lesson_icon = is_completed and '✓' or '•'
            -- Split lesson title if it contains newlines (use only first line for list)
            local lesson_title = vim.split(lesson.title, '\n')[1]
            table.insert(lines, string.format('%s Lesson %d: %s', lesson_icon, i, lesson_title))
          end

          table.insert(lines, '')
          table.insert(lines, '---')
          table.insert(lines, '')

          -- Progress summary
          local completion = progress_module.get_completion_percentage(tutorial.metadata.id, #tutorial.lessons)
          table.insert(lines, string.format('**Progress:** %d%% complete', completion))

          if progress.last_accessed then
            table.insert(lines, '**Last Accessed:** ' .. progress.last_accessed)
          end

          vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)

          -- Set filetype for syntax highlighting
          vim.bo[self.state.bufnr].filetype = 'markdown'
        end,
      },
      attach_mappings = function(prompt_bufnr)
        actions.select_default:replace(function()
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)

          -- Open the selected tutorial
          local ui_float = require('custom.tutorial.ui.floating-window')
          ui_float.open(selection.value)
        end)

        return true
      end,
    })
    :find()
end

return M
