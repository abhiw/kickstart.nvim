-- Beginner Vim Motions Tutorial
-- Learn the foundational movement commands in Vim

return {
  metadata = {
    id = 'vim-motions-beginner',
    title = 'Vim Motions - Beginner',
    category = 'vim-motions',
    difficulty = 'beginner',
    estimated_time = '20 minutes',
    prerequisites = {},
    description = 'Master the essential Vim movements: hjkl, word motions, line navigation, and character finding',
  },

  lessons = {
    -- Lesson 1: hjkl Navigation
    {
      title = 'hjkl - The Home Row Movement',
      content = [[
# hjkl Navigation

The foundation of Vim's efficient navigation is the hjkl keys:

- `h` → Move LEFT (←)
- `j` → Move DOWN (↓)
- `k` → Move UP (↑)
- `l` → Move RIGHT (→)

## Why hjkl?

These keys keep your fingers on the home row, eliminating the need to reach for arrow keys.
This might feel awkward at first, but with practice, it becomes second nature.

## Mnemonic

- Think of `h` and `l` as left and right (h is on the left, l is on the right)
- Think of `j` as pointing down (it has a descender)
- Think of `k` as pointing up (it's like an arrow ^)

## Pro Tips

1. Disable arrow keys in your config to force learning (optional but effective)
2. Start slow - accuracy over speed
3. Practice for 5-10 minutes daily for a week
      ]],
      practice = {
        type = 'interactive',
        instructions = 'Practice navigating this buffer using only h, j, k, l keys. No arrow keys!',
        setup = function()
          local buf = vim.api.nvim_create_buf(false, true)
          local lines = {
            '──── hjkl Practice ────',
            '',
            'Move RIGHT with l →  TARGET  → TARGET  → TARGET',
            'Move LEFT with h  ←  TARGET  ← TARGET  ← TARGET',
            '',
            'Move UP with k      ↑',
            'TARGET at top',
            'TARGET in middle',
            'TARGET at bottom',
            'Move DOWN with j    ↓',
            '',
            'Combine movements to reach each TARGET word above.',
            'Notice how your fingers stay on the home row!',
            '',
            '───────────────────────',
          }
          vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
          return buf
        end,
        hints = {
          'Keep your right hand on the home row: h j k l',
          'Start with small movements, build muscle memory',
          'Arrow keys are your old habit - break it!',
        },
      },
    },

    -- Lesson 2: Word Motions
    {
      title = 'w/b/e - Word-Based Movement',
      content = [[
# Word Motions

Moving by characters is slow. Move by words instead:

- `w` → Move to the beginning of the NEXT **w**ord
- `b` → Move **b**ackward to the beginning of the previous word
- `e` → Move to the **e**nd of the current/next word

## Word vs WORD

Vim has two concepts:
- **word**: Delimited by non-keyword characters (e.g., `hello-world` is 3 words)
- **WORD**: Delimited by whitespace (e.g., `hello-world` is 1 WORD)

Use `W`, `B`, `E` for WORD motions (usually faster, less precise).

## When to Use What

- `w` - Most common, great for code navigation
- `b` - Undo a `w` movement or go back
- `e` - Less common, useful for editing at end of words

## Efficiency

Moving 5 words forward: `5w` is faster than `wwwww` or 20+ `l` presses!
      ]],
      practice = {
        type = 'interactive',
        instructions = 'Use w, b, and e to navigate between words. Try reaching each CAPITAL word.',
        setup = function()
          local buf = vim.api.nvim_create_buf(false, true)
          local lines = {
            '──── Word Motion Practice ────',
            '',
            'The QUICK brown FOX jumps OVER the LAZY dog.',
            '',
            'function calculate_sum(a, b) {',
            '  return a + b;',
            '}',
            '',
            'Navigate to each CAPITALIZED word using only w and b.',
            'Try using `e` to land on the end of words.',
            '',
            'Pro tip: Try 3w to move forward 3 words at once!',
            '',
            '────────────────────────────────',
          }
          vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
          return buf
        end,
        hints = {
          'w moves to the START of next word',
          'b moves to the START of previous word',
          'e moves to the END of current/next word',
          'Use counts: 3w moves forward 3 words',
        },
      },
    },

    -- Lesson 3: Line Motions
    {
      title = '0/$/^ - Line Navigation',
      content = [[
# Line Motions

Efficiently navigate within a line:

- `0` → Move to the beginning of the line (column 0)
- `^` → Move to the first non-blank character of the line
- `$` → Move to the end of the line

## When to Use Each

- `0` - Rare, use when you need the absolute beginning (includes indentation)
- `^` - Very common, goes to where code actually starts
- `$` - Very common, go to end of line to append

## Editing Combos

These are powerful with operators:
- `d$` → Delete from cursor to end of line
- `d^` → Delete from cursor to first non-blank character
- `c$` or `C` → Change to end of line (delete and enter insert mode)

## Remember

Think of `^` as "caret" in regex (start of line content)
Think of `$` as "end" in regex (end of line)
      ]],
      practice = {
        type = 'interactive',
        instructions = 'Practice jumping to start, first character, and end of lines.',
        setup = function()
          local buf = vim.api.nvim_create_buf(false, true)
          local lines = {
            '──── Line Motion Practice ────',
            '',
            '    const greeting = "Hello, World!";',
            '        let counter = 0;',
            'function process(data) {',
            '  return data.map(x => x * 2);',
            '}',
            '',
            'Try this:',
            '1. Press ^ to jump to first non-blank char',
            '2. Press $ to jump to end of line',
            '3. Press 0 to jump to column 0',
            '',
            '───────────────────────────────',
          }
          vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
          return buf
        end,
        hints = {
          '0 = absolute start (column 0)',
          '^ = first non-whitespace character',
          '$ = end of line',
          'Use with operators: d$ deletes to end',
        },
      },
    },

    -- Lesson 4: File Motions
    {
      title = 'gg/G - File Navigation',
      content = [[
# File-Level Motions

Jump around the file quickly:

- `gg` → Go to the first line of the file
- `G` → Go to the last line of the file
- `{number}G` or `:{number}` → Go to specific line number

## Examples

- `gg` → Top of file (line 1)
- `G` → Bottom of file (last line)
- `50G` or `:50` → Go to line 50
- `42G` → Go to line 42

## Common Workflows

1. `gg=G` → Format entire file (go to top, format to bottom)
2. `ggVG` → Select entire file visually
3. `ggdG` → Delete entire file content
4. `G` then `o` → Add new line at end of file

## Pro Tips

- Use `:set number` or `:set relativenumber` to see line numbers
- Ctrl-g shows current line number/position
- Most editors show line numbers in status line
      ]],
      practice = {
        type = 'interactive',
        instructions = 'Practice jumping to top, bottom, and specific lines.',
        setup = function()
          local buf = vim.api.nvim_create_buf(false, true)
          local lines = {
            '1  ──── Line 1: TOP OF FILE ────',
            '2',
            '3  Try these commands:',
            '4  • Press G to go to the last line',
            '5  • Press gg to come back here',
            '6  • Press 10G to go to line 10',
            '7',
            '8  More content here',
            '9  And here',
            '10 TARGET LINE 10',
            '11',
            '12 Even more content',
            '13 Keep scrolling',
            '14 Almost there',
            '15 ──── Line 15: BOTTOM OF FILE ────',
          }
          vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
          return buf
        end,
        hints = {
          'gg takes you to line 1',
          'G takes you to the last line',
          '10G or :10 takes you to line 10',
          'Useful for navigating to error messages showing line numbers',
        },
      },
    },

    -- Lesson 5: Find Character
    {
      title = 'f/F/t/T - Find Character on Line',
      content = [[
# Character Finding

Find and jump to characters on the current line:

- `f{char}` → Find next occurrence of {char} (inclusive)
- `F{char}` → Find previous occurrence of {char} (inclusive)
- `t{char}` → Till next occurrence (stop before {char})
- `T{char}` → Till previous occurrence (stop before {char})

After using f/F/t/T:
- `;` → Repeat the last find in the same direction
- `,` → Repeat the last find in the opposite direction

## f vs t

- `f` lands ON the character (inclusive)
- `t` lands BEFORE the character (till)

## When to Use

- `f` - Most common, use for navigation and deletion
- `t` - Great with change operator: `ct"` change till quote
- `;` - Super useful to repeat the search

## Examples

Line: `const name = "John";`

- `f"` → Jump to first quote
- `f;` → Jump to semicolon
- `t=` → Jump till equals sign (cursor before =)
- `dt"` → Delete till first quote
      ]],
      practice = {
        type = 'interactive',
        instructions = 'Use f, F, t, T to find characters. Use ; and , to repeat.',
        setup = function()
          local buf = vim.api.nvim_create_buf(false, true)
          local lines = {
            '──── Find Character Practice ────',
            '',
            'const result = calculate(a, b, c);',
            '',
            'Exercises:',
            '1. From start of line, try: fc (find c)',
            '2. Then press ; to find next c',
            '3. Try: f( to find opening paren',
            '4. Try: t; to move till semicolon',
            '',
            'let x = 42, y = 100, z = 999;',
            '',
            'More practice:',
            '- Find each comma with f,',
            '- Repeat with ; to find next comma',
            '- Use F to search backwards',
            '',
            '──────────────────────────────────',
          }
          vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
          return buf
        end,
        hints = {
          'f{char} finds the character (cursor ON it)',
          't{char} finds till character (cursor BEFORE it)',
          '; repeats the search forward',
          ', repeats the search backward',
          'These are SUPER fast for line-local navigation',
        },
      },
    },

    -- Lesson 6: Count-Based Motions
    {
      title = 'Count Prefix - Motion Multipliers',
      content = [[
# Using Counts with Motions

Multiply any motion with a count prefix:

- `5j` → Move down 5 lines
- `3w` → Move forward 3 words
- `2$` → Move to end of next line
- `4k` → Move up 4 lines
- `10l` → Move right 10 characters

## How It Works

Format: `{count}{motion}`

The count tells Vim how many times to repeat the motion.

## Efficiency Examples

Instead of `wwwww` → Use `5w`
Instead of `jjjj` → Use `4j`
Instead of `llllllll` → Use `8l` (or better, use `w`)

## With Relative Numbers

If you use `:set relativenumber`:
- Line shows "5" → Type `5j` to jump directly there
- Line shows "3" above → Type `3k` to jump there

## Pro Tip

Don't overthink counts - approximate is fine!
`7j` is better than `jjjjjjj` even if it's actually 6 lines.
You can always press `j` or `k` to adjust.
      ]],
      practice = {
        type = 'interactive',
        instructions = 'Practice using count prefixes with motions for efficient navigation.',
        setup = function()
          local buf = vim.api.nvim_create_buf(false, true)
          local lines = {
            '──── Count-Based Motion Practice ────',
            '',
            'Line 3  - Try: 5j to jump to line 8',
            'Line 4',
            'Line 5',
            'Line 6',
            'Line 7',
            'Line 8  - TARGET',
            'Line 9',
            'Line 10 - Try: 3k to jump up 3 lines',
            '',
            'The quick brown fox jumps over lazy dog',
            'Try: 3w to move 3 words forward',
            '',
            'a b c d e f g h i j k l m n o p',
            'Try: 5w to jump 5 words',
            '',
            'Efficiency: 10j is better than jjjjjjjjjj',
            '',
            '──────────────────────────────────────',
          }
          vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
          return buf
        end,
        hints = {
          'Count comes BEFORE the motion: 5j, 3w, 10l',
          'With relativenumber, just type the line number + j/k',
          "Don't worry about exact counts - close enough is fine!",
          'Combine with any motion: 2$, 4w, 3fz, etc.',
        },
      },
    },
  },
}
