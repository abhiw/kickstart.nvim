-- Intermediate Vim Motions Tutorial
-- Advanced navigation: text objects, marks, jumps, and search

return {
  metadata = {
    id = 'vim-motions-intermediate',
    title = 'Vim Motions - Intermediate',
    category = 'vim-motions',
    difficulty = 'intermediate',
    estimated_time = '30 minutes',
    prerequisites = { 'vim-motions-beginner' },
    description = 'Learn text objects, marks, jumps, search patterns, and advanced navigation techniques',
  },

  lessons = {
    -- Lesson 1: Text Objects
    {
      title = 'Text Objects - iw, aw, i", a), etc.',
      content = [[
# Text Objects

Text objects let you operate on semantic units of text:

## Inner vs Around

- `i{object}` → **i**nner: without surrounding whitespace/delimiters
- `a{object}` → **a**round: including surrounding whitespace/delimiters

## Common Text Objects

Words:
- `iw` → inner word
- `aw` → a word (includes trailing space)

Sentences/Paragraphs:
- `is` → inner sentence
- `as` → a sentence
- `ip` → inner paragraph
- `ap` → a paragraph

Quotes:
- `i"` → inside double quotes
- `a"` → around double quotes (includes quotes)
- `i'` → inside single quotes
- `a'` → around single quotes

Brackets:
- `i(` or `i)` → inside parentheses
- `a(` or `a)` → around parentheses
- `i{` or `i}` → inside braces
- `a{` or `a}` → around braces
- `i[` or `i]` → inside square brackets
- `a[` or `a]` → around square brackets

Tags (HTML/XML):
- `it` → inside tag
- `at` → around tag

## Usage with Operators

- `diw` → **d**elete **i**nner **w**ord
- `ci"` → **c**hange text **i**nside **"**quotes
- `yap` → **y**ank **a** **p**aragraph
- `vi{` → **v**isually select **i**nside **{**braces

## Pro Tips

Text objects are cursor-position independent within the object!
You don't need to be at the start - anywhere inside works.
      ]],
      practice = {
        type = 'interactive',
        instructions = 'Practice using text objects with operators.',
        initial_content = {
          '──── Text Object Practice ────',
          '',
          'Delete this unnecessary word here',
          '',
          'const message = "replace this text";',
          '',
          'function example(param1, param2) {',
          '  return param1 + param2;',
          '}',
          '',
          'array[remove] = value;',
          '',
          '──────────────────────────────',
        },
        tasks = {
          {
            instruction = [[Step 1: Delete a word using 'diw'

Position your cursor anywhere on the word "unnecessary" in line 3.
Text objects work from ANY position within the object!

1. Move cursor anywhere on "unnecessary"
2. Press diw (delete inner word)

The line should read: "Delete this word here"
Press 'v' to verify.]],
            hint = 'Position anywhere on "unnecessary", then: diw',
            validate = function()
              local validator = require('custom.tutorial.ui.practice-validator').validators
              return validator.lines_with_feedback({
                { line = 3, expected = 'Delete this word here' },
              })
            end,
          },
          {
            instruction = [[Step 2: Change text inside quotes using 'ci"'

Position your cursor ANYWHERE inside the quotes on line 5.
You don't need to be at the beginning!

1. Cursor anywhere between the quotes
2. Press ci" (change inside quotes)
3. Type: updated content
4. Press Esc

The line should read: const message = "updated content";
Press 'v' to verify.]],
            hint = 'Cursor anywhere in quotes, then: ci" type text <Esc>',
            validate = function()
              local validator = require('custom.tutorial.ui.practice-validator').validators
              return validator.lines_with_feedback({
                { line = 5, expected = 'const message = "updated content";' },
              })
            end,
          },
          {
            instruction = [[Step 3: Delete inside braces using 'di{'

Position your cursor anywhere inside the curly braces (lines 7-9).
You can be on line 7, 8, or 9 - text objects find the container!

1. Cursor anywhere inside the { }
2. Press di{ (delete inside braces)

The function should become an empty block: { }
Press 'v' to check.]],
            hint = 'Cursor anywhere inside braces, then: di{',
            validate = function()
              local validator = require('custom.tutorial.ui.practice-validator').validators
              return validator.lines_with_feedback({
                { line = 7, expected = 'function example(param1, param2) {' },
                { line = 8, expected = '}' },
              })
            end,
          },
          {
            instruction = [[Step 4: Delete inside brackets using 'di['

Position your cursor anywhere inside the square brackets on line 11.

1. Cursor anywhere between [ and ]
2. Press di[ (delete inside brackets)

The line should read: array[] = value;
Press 'v' to verify. Great job mastering text objects!]],
            hint = 'Cursor anywhere inside [ ], then: di[',
            validate = function()
              local validator = require('custom.tutorial.ui.practice-validator').validators
              return validator.lines_with_feedback({
                { line = 11, expected = 'array[] = value;' },
              })
            end,
          },
        },
        hints = {
          'Text objects work from ANYWHERE inside the object',
          'i = inner (without delimiters), a = around (with delimiters)',
          'Combine with d(delete), c(change), y(yank), v(visual)',
          'Most powerful Vim feature - master these!',
        },
      },
    },

    -- Lesson 2: Paragraph Motions
    {
      title = '{} - Paragraph Navigation',
      content = [[
# Paragraph Motions

Navigate by paragraphs (blocks separated by blank lines):

- `{` → Jump to previous paragraph (block)
- `}` → Jump to next paragraph (block)

## What is a Paragraph?

In Vim, a paragraph is text separated by blank lines.
In code, this usually means:
- Function definitions
- Code blocks
- Comment blocks
- Logical sections

## Usage

- `{` → Great for jumping up through functions/blocks
- `}` → Great for jumping down through functions/blocks
- `d}` → Delete from cursor to next paragraph
- `v{` → Visually select to previous paragraph

## Pro Tips

- Combine with text objects: `dap` deletes entire paragraph
- Use `{` and `}` for quick navigation in code
- Works great with relative positioning in source code
      ]],
      practice = {
        type = 'interactive',
        instructions = 'Use { and } to jump between paragraphs/code blocks.',
        initial_content = {
          '──── Paragraph Navigation ────',
          '',
          'function first() {',
          '  console.log("First");',
          '}',
          '',
          'function second() {',
          '  console.log("Second");',
          '}',
          '',
          'function third() {',
          '  console.log("Third");',
          '}',
          '',
          'function fourth() {',
          '  console.log("Fourth");',
          '}',
          '',
          '───────────────────────────────',
        },
        tasks = {
          {
            instruction = [[Step 1: Jump forward to next paragraph with '}'

Position your cursor on line 3 (the line with "function first").

1. Press } to jump FORWARD to the next blank line

You should land on line 6 (the blank line after first()).
Press 'v' to verify your position.]],
            hint = '} jumps forward to next paragraph (blank line)',
            validate = function()
              local pos = vim.api.nvim_win_get_cursor(0)
              return pos[1] == 6
            end,
          },
          {
            instruction = [[Step 2: Jump forward again with '}'

From line 6, press } again to jump to the next paragraph.

You should land on line 10 (blank line after second()).
Press 'v' to check.]],
            hint = 'Press } to continue jumping forward',
            validate = function()
              local pos = vim.api.nvim_win_get_cursor(0)
              return pos[1] == 10
            end,
          },
          {
            instruction = [[Step 3: Jump backward with '{'

Now let's go backward. Press { to jump to the PREVIOUS paragraph.

You should land on line 6 (blank line before second()).
Press 'v' to verify.]],
            hint = '{ jumps backward to previous paragraph',
            validate = function()
              local pos = vim.api.nvim_win_get_cursor(0)
              return pos[1] == 6
            end,
          },
          {
            instruction = [[Step 4: Practice jumping through all functions

Starting from your current position:
1. Press } twice to skip over second() and third()
2. You should reach line 14 (after third())

Then press { to jump back.
When comfortable, press 'v' to continue.]],
            hint = 'Use } to jump forward, { to jump back',
            validate = function()
              -- Just return true for free practice
              return true
            end,
          },
        },
        hints = {
          '{ jumps backward to previous paragraph',
          '} jumps forward to next paragraph',
          'Blank lines define paragraph boundaries',
          'Super useful for navigating code',
        },
      },
    },

    -- Lesson 3: Marks
    {
      title = 'Marks - Bookmarks in Your File',
      content = [[
# Marks

Set bookmarks to jump back to specific locations:

## Setting Marks

- `m{a-z}` → Set a local mark (file-specific)
- `m{A-Z}` → Set a global mark (across files)

## Jumping to Marks

- `'{mark}` → Jump to line of mark
- backtick `{mark}` → Jump to exact position of mark

## Special Marks (Auto-set by Vim)

- `'` → Jump to position before latest jump
- `".` → Jump to last change
- `'^` → Jump to last insert position
- `'[` → Jump to start of last change/yank
- `']` → Jump to end of last change/yank

## Examples

```
ma          " Set mark 'a' at current position
(move around)
'a          " Jump back to line of mark a
`a          " Jump back to exact position of mark a
```

## Use Cases

1. Mark a location before searching: `ma`, `/pattern`, then `'a` to return
2. Mark multiple locations while refactoring
3. Use global marks for frequently-visited files

## Pro Tips

- Lowercase marks (a-z): per-file bookmarks
- Uppercase marks (A-Z): cross-file bookmarks
- `:marks` shows all marks
- `:delmarks a` deletes mark 'a'
      ]],
      practice = {
        type = 'interactive',
        instructions = 'Practice setting marks and jumping between them.',
        initial_content = {
          '──── Marks Practice ────',
          '',
          'Line 3: MARK A - Set mark here with ma',
          '',
          'Some content in between',
          'More content here',
          'Even more content',
          '',
          'Line 9: MARK B - Set mark here with mb',
          '',
          'Additional content',
          'More lines',
          '',
          'Line 14: MARK C - Set mark here with mc',
          '',
          'You can jump to marks with \'a \'b \'c',
          '',
          '─────────────────────────────',
        },
        tasks = {
          {
            instruction = [[Step 1: Set mark 'a' at line 3

Navigate to line 3 (the line saying "MARK A").

1. Use 3G or navigate with j/k to line 3
2. Press ma to set mark 'a' at this position

Mark 'a' is now set! You won't see any visual change.
Press 'v' when ready to continue.]],
            hint = 'Go to line 3, then press: ma',
            validate = function()
              -- For marks, we just verify they're on the right line
              -- The actual mark setting will be tested when they jump
              local pos = vim.api.nvim_win_get_cursor(0)
              return pos[1] == 3
            end,
          },
          {
            instruction = [[Step 2: Set mark 'b' at line 9

Navigate to line 9 (the line saying "MARK B").

1. Use 9G or navigate to line 9
2. Press mb to set mark 'b'

Press 'v' when ready.]],
            hint = 'Go to line 9, then press: mb',
            validate = function()
              local pos = vim.api.nvim_win_get_cursor(0)
              return pos[1] == 9
            end,
          },
          {
            instruction = [[Step 3: Jump to mark 'a' using 'a

Now test jumping to a mark!

1. Press 'a (apostrophe followed by a)

You should jump back to line 3 where you set mark 'a'.
Press 'v' to verify you're on line 3.]],
            hint = 'Press: \'a (apostrophe + a)',
            validate = function()
              local pos = vim.api.nvim_win_get_cursor(0)
              return pos[1] == 3
            end,
          },
          {
            instruction = [[Step 4: Jump to mark 'b' using 'b

Now jump to mark 'b'.

1. Press 'b

You should jump to line 9 where you set mark 'b'.
Press 'v' to check. Great job learning marks!]],
            hint = 'Press: \'b',
            validate = function()
              local pos = vim.api.nvim_win_get_cursor(0)
              return pos[1] == 9
            end,
          },
        },
        hints = {
          'm{letter} sets a mark at current position',
          '\'{letter} jumps to the line of that mark',
          'Use :marks to see all your marks',
          'Very useful for navigating while editing',
        },
      },
    },

    -- Lesson 4: Jump List
    {
      title = 'Ctrl-o / Ctrl-i - Jump List Navigation',
      content = [[
# Jump List

Vim remembers your jump history:

- `Ctrl-o` → Jump to previous location (older)
- `Ctrl-i` or `Tab` → Jump to next location (newer)

## What Counts as a Jump?

Jumps are created by:
- `G`, `gg`, `{line}G` (line jumps)
- `/`, `?` (searches)
- `n`, `N` (search repeat)
- `%` (matching bracket)
- `'`, backtick (marks)
- File switches

Regular motions (h, j, k, l, w, b) do NOT create jumps.

## Usage

Think of it like web browser back/forward:
- `Ctrl-o` = back button
- `Ctrl-i` = forward button

## Commands

- `:jumps` → Show jump list
- `:clearjumps` → Clear jump list

## Common Workflow

```
1. Search for a function: /myFunction
2. Jump to definition: gd
3. Look around
4. Press Ctrl-o Ctrl-o to go back to where you started
```

## Pro Tips

- Jump list is per-window
- Very useful when navigating unfamiliar code
- Combine with tags/LSP for powerful navigation
      ]],
      practice = {
        type = 'interactive',
        instructions = 'Practice using Ctrl-o and Ctrl-i to navigate through jumps.',
        initial_content = {
          '──── Jump List Practice ────',
          '',
          'Line 3  - TOP MARKER',
          'Line 4',
          'Line 5',
          'Line 6',
          'Line 7  - MIDDLE MARKER',
          'Line 8',
          'Line 9',
          'Line 10',
          'Line 11 - BOTTOM MARKER',
          '',
          'The word "jump" appears here.',
          'Another jump here.',
          'Final jump here.',
          '',
          '─────────────────────────────',
        },
        tasks = {
          {
            instruction = [[Step 1: Create jumps by navigating

Jumps are created by large movements, not hjkl!

Starting from line 3, create jumps by:
1. Press G to jump to last line (creates jump)
2. Press gg to jump to first line (creates jump)
3. Press 7G to jump to line 7 (creates jump)

You should now be on line 7.
Press 'v' to verify.]],
            hint = 'G, gg, and {number}G create jumps',
            validate = function()
              local pos = vim.api.nvim_win_get_cursor(0)
              return pos[1] == 7
            end,
          },
          {
            instruction = [[Step 2: Jump backward with Ctrl-o

Press Ctrl-o to go BACK to your previous location.

Think of it like the browser "back" button!
You should jump back to line 1 (from gg).

Press 'v' to check you're on line 1.]],
            hint = 'Ctrl-o = older location (back button)',
            validate = function()
              local pos = vim.api.nvim_win_get_cursor(0)
              return pos[1] == 1
            end,
          },
          {
            instruction = [[Step 3: Jump forward with Ctrl-i

Press Ctrl-i to go FORWARD through your jumps.

This is like the browser "forward" button.
You should jump forward to line 7 again.

Press 'v' to verify you're on line 7.]],
            hint = 'Ctrl-i = newer location (forward button)',
            validate = function()
              local pos = vim.api.nvim_win_get_cursor(0)
              return pos[1] == 7
            end,
          },
          {
            instruction = [[Step 4: Practice with searches

Searches also create jumps!

1. Type /jump and press Enter (jumps to line 13)
2. Press n to find next (jumps to line 14)
3. Press Ctrl-o twice to go back through jumps
4. Press Ctrl-i to go forward

When comfortable with Ctrl-o and Ctrl-i, press 'v'.

Remember: Ctrl-o = back, Ctrl-i = forward]],
            hint = 'Searches with /, ?, n, N all create jumps',
            validate = function()
              return true
            end,
          },
        },
        hints = {
          'Ctrl-o goes back in jump history',
          'Ctrl-i goes forward in jump history',
          ':jumps shows your jump history',
          'Think of it like browser back/forward buttons',
        },
      },
    },

    -- Lesson 5: Search
    {
      title = '/ ? n N - Search and Navigate',
      content = [[
# Search in Vim

Find text in your file:

- `/pattern` → Search forward for pattern
- `?pattern` → Search backward for pattern
- `n` → Next match (same direction)
- `N` → Previous match (opposite direction)

## Search Features

Case sensitivity:
- `/word` → Case-sensitive by default
- `/word\c` → Force case-insensitive
- Use `:set ignorecase` for default case-insensitive

Whole word:
- `/\<word\>` → Match whole word only

## Useful Settings

```vim
set incsearch     " Show matches as you type
set hlsearch      " Highlight all matches
set ignorecase    " Case-insensitive search
set smartcase     " Case-sensitive if uppercase used
```

## Clear Highlights

- `:noh` or `:nohlsearch` → Clear search highlights
- Many configs map this to `Esc`

## Search History

- `/` then `↑` → Previous searches
- `q/` → Open search history window

## Pro Tips

- Use `*` to search for word under cursor (forward)
- Use `#` to search for word under cursor (backward)
- `gd` → Go to local definition of word under cursor
- `gD` → Go to global definition
      ]],
      practice = {
        type = 'interactive',
        instructions = 'Practice searching forward and backward, using n and N.',
        initial_content = {
          '──── Search Practice ────',
          '',
          'The word "target" appears multiple times.',
          'First target here.',
          'Second target here.',
          'Third target here.',
          '',
          'Some other content',
          'More text without the word',
          '',
          'Fourth target here.',
          'Fifth target here.',
          'Last target here.',
          '',
          '──────────────────────────',
        },
        tasks = {
          {
            instruction = [[Step 1: Search forward for "target"

Position your cursor at the top of the file (line 1).

1. Press gg to go to top
2. Type /target and press Enter

Your cursor should jump to the first occurrence of "target" on line 3.
Press 'v' to verify you're on line 3.]],
            hint = 'gg to go to top, then: /target <Enter>',
            validate = function()
              local pos = vim.api.nvim_win_get_cursor(0)
              return pos[1] == 3
            end,
          },
          {
            instruction = [[Step 2: Find next match with 'n'

After searching, press 'n' to go to the NEXT match.

1. Press n (lowercase)

You should jump to line 4 (the second "target").
Press 'v' to check.]],
            hint = 'Press: n (next match)',
            validate = function()
              local pos = vim.api.nvim_win_get_cursor(0)
              return pos[1] == 4
            end,
          },
          {
            instruction = [[Step 3: Continue with 'n' to third match

Press 'n' again to find the next occurrence.

You should land on line 5 (third "target").
Press 'v' to verify.]],
            hint = 'Press: n again',
            validate = function()
              local pos = vim.api.nvim_win_get_cursor(0)
              return pos[1] == 5
            end,
          },
          {
            instruction = [[Step 4: Go back with 'N'

Press 'N' (capital N) to go to the PREVIOUS match.

1. Press N (shift + n)

You should jump back to line 4.
Press 'v' to check. Great work mastering search!]],
            hint = 'Press: N (previous match)',
            validate = function()
              local pos = vim.api.nvim_win_get_cursor(0)
              return pos[1] == 4
            end,
          },
        },
        hints = {
          '/ searches forward, ? searches backward',
          'n repeats search in same direction',
          'N repeats search in opposite direction',
          '* searches for word under cursor',
          ':noh clears search highlighting',
        },
      },
    },

    -- Lesson 6: Matching Brackets
    {
      title = '% - Jump to Matching Bracket',
      content = [[
# Matching Bracket Navigation

Jump between matching pairs:

- `%` → Jump to matching bracket/paren/brace

## What It Matches

- `(` and `)`
- `{` and `}`
- `[` and `]`
- HTML/XML tags: `<div>` and `</div>`
- `#if` and `#endif` (C preprocessor)

## Usage

Position cursor on any bracket and press `%`:
- On `(` → jumps to matching `)`
- On `)` → jumps to matching `(`
- On `{` → jumps to matching `}`

## With Operators

- `d%` → Delete from cursor to matching bracket
- `v%` → Visually select to matching bracket
- `c%` → Change to matching bracket

## Finding Brackets

- `[(` → Jump to previous unmatched `(`
- `])` → Jump to next unmatched `)`
- `[{` → Jump to previous unmatched `{`
- `]}` → Jump to next unmatched `}`

## Pro Tips

- Install matchit plugin for better matching (included in Vim)
- Use with text objects: `di(` delete inside parens
- Great for navigating nested code
      ]],
      practice = {
        type = 'interactive',
        instructions = 'Position cursor on brackets and use % to jump to matching pair.',
        initial_content = {
          '──── Bracket Matching ────',
          '',
          'function nested(a, b) {',
          '  if (a > b) {',
          '    return Math.max(a, b);',
          '  } else {',
          '    return Math.min(a, b);',
          '  }',
          '}',
          '',
          'const array = [1, 2, [3, 4], 5];',
          '',
          '───────────────────────────',
        },
        tasks = {
          {
            instruction = [[Step 1: Jump to matching brace with '%'

Position your cursor on the opening '{' on line 3 (after "nested(a, b)").

1. Navigate to line 3
2. Move cursor to the '{' character
3. Press %

You should jump to the matching '}' on line 9.
Press 'v' to verify you're on line 9.]],
            hint = 'Position on opening {, then press: %',
            validate = function()
              local pos = vim.api.nvim_win_get_cursor(0)
              return pos[1] == 9
            end,
          },
          {
            instruction = [[Step 2: Jump back with '%'

The % command toggles between matching pairs!
Press % again to jump back.

You should return to line 3 (the opening '{').
Press 'v' to check.]],
            hint = 'Press % again to jump back',
            validate = function()
              local pos = vim.api.nvim_win_get_cursor(0)
              return pos[1] == 3
            end,
          },
          {
            instruction = [[Step 3: Match nested parentheses

Position your cursor on the '(' in "if (a > b)" on line 4.

1. Navigate to line 4
2. Position on the '(' character
3. Press %

You should jump to the matching ')' on the same line.
Press 'v' to verify you're still on line 4.]],
            hint = 'Line 4, position on (, then: %',
            validate = function()
              local pos = vim.api.nvim_win_get_cursor(0)
              return pos[1] == 4
            end,
          },
          {
            instruction = [[Step 4: Match square brackets

Position your cursor on the first '[' in line 11 (the array).

1. Go to line 11
2. Position on the first '['
3. Press %

You should jump to the matching ']' at the end of the line.
Press 'v' to check. Excellent work!]],
            hint = 'Line 11, first [, then: %',
            validate = function()
              local pos = vim.api.nvim_win_get_cursor(0)
              local line = vim.api.nvim_buf_get_lines(0, pos[1] - 1, pos[1], false)[1]
              -- Check we're on line 11 and on a ] character
              return pos[1] == 11 and line:sub(pos[2] + 1, pos[2] + 1) == ']'
            end,
          },
        },
        hints = {
          '% jumps between matching brackets',
          'Works on ( ) { } [ ] and more',
          'Press % again to jump back',
          'Combine with operators: d%, v%, c%',
          'Great for navigating nested code',
        },
      },
    },
  },
}
