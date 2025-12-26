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
        initial_content = {
          '──── hjkl Practice ────',
          '',
          'apple banana cherry date elderberry',
          '',
          'First move RIGHT using l',
          'Then move LEFT using h',
          'Then move DOWN using j',
          'Finally move UP using k',
          '',
          'grape honeydew kiwi lemon mango',
          '',
          '───────────────────────',
        },
        tasks = {
          {
            instruction = [[Step 1: Move right using 'l'

Starting from the first character 'a', press 'l' once to move right.
Your cursor should be on the second character.

When ready, press 'v' to verify your position.]],
            hint = 'Just press l once',
            validate = function()
              local validator = require('custom.tutorial.ui.practice-validator').validators
              return validator.cursor_position(3, 2)
            end,
          },
          {
            instruction = [[Step 2: Reach the word "banana"

From where you are, press 'l' several times to reach "banana".
You can press 'l' repeatedly, or use '5l' to move 5 characters at once.

Press 'v' to check if you're on the word "banana".]],
            hint = 'Try 5l to move 5 characters forward at once',
            validate = function()
              local validator = require('custom.tutorial.ui.practice-validator').validators
              return validator.cursor_on_word('banana')
            end,
          },
          {
            instruction = [[Step 3: Move left using 'h'

Now practice moving LEFT. Use 'h' to move back to the word "apple".
You can use 'h' multiple times, or try '6h' to move left faster.

Press 'v' to verify you're back on "apple".]],
            hint = 'h moves left, the opposite of l',
            validate = function()
              local validator = require('custom.tutorial.ui.practice-validator').validators
              return validator.cursor_on_word('apple')
            end,
          },
          {
            instruction = [[Step 4: Move down using 'j'

Press 'j' to move DOWN to line 10 (the line with "grape").
You can press 'j' multiple times, or use '7j' to jump down 7 lines.

Press 'v' to check if you're on line 10.]],
            hint = 'j moves down. Think of j as having a descender pointing down',
            validate = function()
              local pos = vim.api.nvim_win_get_cursor(0)
              return pos[1] == 10
            end,
          },
          {
            instruction = [[Step 5: Move up using 'k'

Finally, press 'k' to move UP back to line 3.
You can press 'k' repeatedly, or use '7k' to jump up 7 lines.

Press 'v' to verify you're on line 3.
Great job! You've learned hjkl navigation.]],
            hint = 'k moves up. Think of k as pointing up like an arrow ^',
            validate = function()
              local pos = vim.api.nvim_win_get_cursor(0)
              return pos[1] == 3
            end,
          },
        },
        hints = {
          'Keep your right hand on the home row: h j k l',
          'Start with small movements, build muscle memory',
          'Arrow keys are your old habit - break it!',
        },
      },
    },

    -- Lesson 1.5: Deletion Practice (Edit-based with visual feedback)
    {
      title = 'x - Delete Character',
      content = [[
# Delete Character

Learn to delete characters efficiently:

- `x` → Delete the character under the cursor
- `X` → Delete the character before the cursor

## Practice Makes Perfect

The best way to learn is by doing. In the practice section, you'll delete
specific characters and see visual feedback showing if you did it correctly.
      ]],
      practice = {
        type = 'interactive',
        instructions = 'Delete specific characters from the lines below',
        initial_content = {
          '──── Deletion Practice ────',
          '',
          'Remove the X: HelloXWorld',
          'Remove the X: VimXEditor',
          'Remove the X: PracticeXMakes',
          '',
          'Instructions:',
          '1. Position cursor on the X',
          '2. Press x to delete it',
          '3. Press v to verify',
          '',
          '───────────────────────',
        },
        tasks = {
          {
            instruction = [[Step 1: Delete the 'X' from all three lines

Move to each line and delete the X character using 'x'.
The result should be:
  - HelloWorld
  - VimEditor
  - PracticeMakes

Press 'v' to see which lines are correct (✓) and which aren't (✗).]],
            hint = 'Position cursor on X, then press x to delete',
            validate = function()
              local validator = require('custom.tutorial.ui.practice-validator').validators
              return validator.lines_with_feedback({
                { line = 3, expected = 'Remove the X: HelloWorld' },
                { line = 4, expected = 'Remove the X: VimEditor' },
                { line = 5, expected = 'Remove the X: PracticeMakes' },
              })
            end,
          },
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
        instructions = 'Use w, b, and e to navigate between words.',
        initial_content = {
          '──── Word Motion Practice ────',
          '',
          'apple banana cherry date elderberry fig grape',
          '',
          'function calculate_sum(a, b) {',
          '  return a + b;',
          '}',
          '',
          '────────────────────────────────',
        },
        tasks = {
          {
            instruction = [[Step 1: Move forward with 'w'

Starting from the beginning of line 3, press 'w' to move to "banana".
The 'w' command moves to the start of the next word.

Press 'v' to verify you're on "banana".]],
            hint = 'w moves to the START of the next word',
            validate = function()
              local validator = require('custom.tutorial.ui.practice-validator').validators
              return validator.cursor_on_word('banana')
            end,
          },
          {
            instruction = [[Step 2: Move forward 3 words using '3w'

From "banana", use the count prefix: type '3w' to jump 3 words forward.
You should land on "elderberry".

Press 'v' to check your position.]],
            hint = 'Count comes before motion: 3w means "3 times w"',
            validate = function()
              local validator = require('custom.tutorial.ui.practice-validator').validators
              return validator.cursor_on_word('elderberry')
            end,
          },
          {
            instruction = [[Step 3: Move backward with 'b'

Now use 'b' to move BACKWARD to the previous word.
You should land on "date".

Press 'v' to verify.]],
            hint = 'b moves to the START of the previous word',
            validate = function()
              local validator = require('custom.tutorial.ui.practice-validator').validators
              return validator.cursor_on_word('date')
            end,
          },
          {
            instruction = [[Step 4: Jump to end of word with 'e'

Press 'e' to move to the END of the current word.
Your cursor should be on the 'e' in "date".

Press 'v' to check.]],
            hint = 'e moves to the END of the current/next word',
            validate = function()
              local pos = vim.api.nvim_win_get_cursor(0)
              local line = vim.api.nvim_buf_get_lines(0, pos[1] - 1, pos[1], false)[1]
              -- Check if on line 3 and on the last character of "date"
              return pos[1] == 3 and line:sub(pos[2] + 1, pos[2] + 1) == 'e' and line:sub(pos[2], pos[2] + 3) == 'date'
            end,
          },
        },
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
        initial_content = {
          '──── Line Motion Practice ────',
          '',
          '    const greeting = "Hello, World!";',
          '        let counter = 0;',
          'function process(data) {',
          '  return data.map(x => x * 2);',
          '}',
          '',
          '───────────────────────────────',
        },
        tasks = {
          {
            instruction = [[Step 1: Jump to first non-blank character with '^'

Position yourself on line 3 (the one with "const greeting").
Press '^' to jump to the first non-whitespace character (the 'c' in "const").

Press 'v' to verify your position.]],
            hint = '^ jumps to first non-blank character, skipping indentation',
            validate = function()
              local pos = vim.api.nvim_win_get_cursor(0)
              -- Line 3, column should be at 'c' of const (after 4 spaces)
              return pos[1] == 3 and pos[2] == 4
            end,
          },
          {
            instruction = [[Step 2: Jump to end of line with '$'

Now press '$' to jump to the END of the current line.
Your cursor should be on the semicolon ';' at the end.

Press 'v' to check.]],
            hint = '$ takes you to the last character of the line',
            validate = function()
              local pos = vim.api.nvim_win_get_cursor(0)
              local line = vim.api.nvim_buf_get_lines(0, pos[1] - 1, pos[1], false)[1]
              -- Should be at the end of line 3
              return pos[1] == 3 and pos[2] == #line - 1
            end,
          },
          {
            instruction = [[Step 3: Jump to column 0 with '0'

Press '0' to jump to the absolute beginning (column 0).
Your cursor should be at the first space/indentation.

Press 'v' to verify.]],
            hint = '0 goes to column 0, including indentation',
            validate = function()
              local pos = vim.api.nvim_win_get_cursor(0)
              return pos[1] == 3 and pos[2] == 0
            end,
          },
          {
            instruction = [[Step 4: Practice on different lines

Move to line 5 ("function process...") and use these motions:
1. Press '^' - should go to 'f' in "function"
2. Press '$' - should go to the '{' at end
3. Press '0' - should go to column 0

Try these on your own, then press 'v'.]],
            hint = 'Navigate to line 5 using j or 5G',
            validate = function()
              -- Just check they are on line 5
              local pos = vim.api.nvim_win_get_cursor(0)
              return pos[1] == 5
            end,
          },
        },
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
        initial_content = {
          '──── Line 1: TOP OF FILE ────',
          '',
          'Try these commands:',
          '• Press G to go to the last line',
          '• Press gg to come back here',
          '• Press 10G to go to line 10',
          '',
          'More content here',
          'And here',
          'TARGET LINE 10',
          '',
          'Even more content',
          'Keep scrolling',
          'Almost there',
          '──── Line 15: BOTTOM OF FILE ────',
        },
        tasks = {
          {
            instruction = [[Step 1: Jump to bottom with 'G'

Press 'G' (capital G) to jump to the LAST line of the file.
You should land on line 15 (the bottom).

Press 'v' to verify you're on the last line.]],
            hint = 'G takes you to the last line of the file',
            validate = function()
              local pos = vim.api.nvim_win_get_cursor(0)
              local total_lines = vim.api.nvim_buf_line_count(0)
              return pos[1] == total_lines
            end,
          },
          {
            instruction = [[Step 2: Jump to top with 'gg'

Press 'gg' to jump to the FIRST line of the file.
You should land on line 1.

Press 'v' to check.]],
            hint = 'gg takes you to line 1 (top of file)',
            validate = function()
              local pos = vim.api.nvim_win_get_cursor(0)
              return pos[1] == 1
            end,
          },
          {
            instruction = [[Step 3: Jump to specific line with '10G'

Type '10G' to jump directly to line 10.
This is the "TARGET LINE 10" line.

Press 'v' to verify you're on line 10.]],
            hint = 'Type the line number followed by G: 10G',
            validate = function()
              local pos = vim.api.nvim_win_get_cursor(0)
              return pos[1] == 10
            end,
          },
          {
            instruction = [[Step 4: Practice jumping around

Try these on your own:
1. Press 'gg' to go to line 1
2. Press '7G' to go to line 7
3. Press 'G' to go to the last line

When you're comfortable, press 'v'.]],
            hint = 'gg = top, G = bottom, {number}G = specific line',
            validate = function()
              -- Just return true since this is free practice
              return true
            end,
          },
        },
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
        initial_content = {
          '──── Find Character Practice ────',
          '',
          'const result = calculate(a, b, c);',
          '',
          'let x = 42, y = 100, z = 999;',
          '',
          '──────────────────────────────────',
        },
        tasks = {
          {
            instruction = [[Step 1: Find character with 'f'

Position yourself at the beginning of line 3.
Type 'fc' to FIND the letter 'c'. Your cursor should land on the first 'c' in "const".

Press 'v' to verify.]],
            hint = 'f followed by a character finds that character forward',
            validate = function()
              local pos = vim.api.nvim_win_get_cursor(0)
              local line = vim.api.nvim_buf_get_lines(0, pos[1] - 1, pos[1], false)[1]
              -- Should be on line 3, on the 'c' in "const"
              return pos[1] == 3 and line:sub(pos[2] + 1, pos[2] + 1) == 'c' and pos[2] == 0
            end,
          },
          {
            instruction = [[Step 2: Repeat find with ';'

Press ';' to find the NEXT occurrence of 'c'.
Your cursor should jump to the 'c' in "calculate".

Press 'v' to check.]],
            hint = '; repeats the last f/F/t/T search in the same direction',
            validate = function()
              local pos = vim.api.nvim_win_get_cursor(0)
              local line = vim.api.nvim_buf_get_lines(0, pos[1] - 1, pos[1], false)[1]
              -- Should be on 'c' in "calculate" (around column 16)
              return pos[1] == 3 and line:sub(pos[2] + 1, pos[2] + 1) == 'c' and pos[2] >= 15 and pos[2] <= 17
            end,
          },
          {
            instruction = [[Step 3: Find backwards with 'F'

Type 'F=' to find the '=' character BACKWARDS.
Your cursor should move left to the '=' sign.

Press 'v' to verify.]],
            hint = 'F searches backwards (opposite of f)',
            validate = function()
              local pos = vim.api.nvim_win_get_cursor(0)
              local line = vim.api.nvim_buf_get_lines(0, pos[1] - 1, pos[1], false)[1]
              return pos[1] == 3 and line:sub(pos[2] + 1, pos[2] + 1) == '='
            end,
          },
          {
            instruction = [[Step 4: Find 'till' character with 't'

Move to line 5 and position at the beginning.
Type 't,' to move TILL (before) the first comma.

Press 'v' to check.]],
            hint = 't stops BEFORE the character (till), not on it',
            validate = function()
              local pos = vim.api.nvim_win_get_cursor(0)
              local line = vim.api.nvim_buf_get_lines(0, pos[1] - 1, pos[1], false)[1]
              -- Should be on line 5, one character before the first comma
              return pos[1] == 5 and line:sub(pos[2] + 2, pos[2] + 2) == ','
            end,
          },
        },
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
        initial_content = {
          '──── Count-Based Motion Practice ────',
          '',
          'Line 3  - Start here',
          'Line 4',
          'Line 5',
          'Line 6',
          'Line 7',
          'Line 8  - TARGET',
          'Line 9',
          'Line 10',
          '',
          'The quick brown fox jumps over the lazy dog',
          '',
          'a b c d e f g h i j k l m n o p',
          '',
          '──────────────────────────────────────',
        },
        tasks = {
          {
            instruction = [[Step 1: Move down 5 lines with '5j'

Position yourself on line 3 (the line saying "Start here").
Type '5j' to move down 5 lines. You should land on line 8 (TARGET).

Press 'v' to verify.]],
            hint = 'Count comes BEFORE the motion: 5j',
            validate = function()
              local pos = vim.api.nvim_win_get_cursor(0)
              return pos[1] == 8
            end,
          },
          {
            instruction = [[Step 2: Move up 3 lines with '3k'

From line 8, type '3k' to move UP 3 lines.
You should land on line 5.

Press 'v' to check.]],
            hint = 'k moves up, so 3k moves up 3 lines',
            validate = function()
              local pos = vim.api.nvim_win_get_cursor(0)
              return pos[1] == 5
            end,
          },
          {
            instruction = [[Step 3: Move forward 3 words with '3w'

Navigate to line 12 ("The quick brown...").
Position at the beginning and type '3w' to move 3 words forward.
You should land on "fox".

Press 'v' to verify.]],
            hint = 'Move to line 12 first, then use 3w',
            validate = function()
              local validator = require('custom.tutorial.ui.practice-validator').validators
              return validator.cursor_on_word('fox')
            end,
          },
          {
            instruction = [[Step 4: Move right 10 characters with '10l'

On line 14 (the alphabet line), start at 'a'.
Type '10l' to move right 10 characters.
You should land on 'k'.

Press 'v' to check.]],
            hint = 'l moves right one character, 10l moves right 10',
            validate = function()
              local pos = vim.api.nvim_win_get_cursor(0)
              local line = vim.api.nvim_buf_get_lines(0, pos[1] - 1, pos[1], false)[1]
              return pos[1] == 14 and line:sub(pos[2] + 1, pos[2] + 1) == 'k'
            end,
          },
        },
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
