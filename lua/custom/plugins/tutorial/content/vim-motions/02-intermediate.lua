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
        instructions = 'Practice using text objects with operators. Try diw, ci", va{, etc.',
        setup = function()
          local buf = vim.api.nvim_create_buf(false, true)
          local lines = {
            '──── Text Object Practice ────',
            '',
            'Try: Position cursor anywhere in "word" below, then use diw',
            'Delete this word entirely',
            '',
            'const message = "Hello, World!";',
            'Try: cursor inside quotes, then ci" to change the text',
            '',
            'function calculate(a, b) {',
            '  return a + b;',
            '}',
            'Try: cursor inside braces, then di{ to delete function body',
            '',
            'array[0] = getValue(param);',
            'Try: di[ to delete inside brackets, da( for parens',
            '',
            '──────────────────────────────',
          }
          vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
          vim.bo[buf].modifiable = true
          return buf
        end,
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
        setup = function()
          local buf = vim.api.nvim_create_buf(false, true)
          local lines = {
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
            'Try: Press } to jump to next blank line',
            'Try: Press { to jump to previous blank line',
            '',
            '───────────────────────────────',
          }
          vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
          return buf
        end,
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
        type = 'reference',
        instructions = [[
Practice setting and using marks:

1. Move to line 5, press ma (set mark a)
2. Move to line 15
3. Press 'a to jump back to line 5
4. Set multiple marks (mb, mc) at different locations
5. Jump between them with 'b, 'c
6. Check all marks with :marks
        ]],
        hints = {
          'm{letter} sets a mark',
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
        type = 'reference',
        instructions = [[
Practice using the jump list:

1. Use gg to jump to top (creates a jump)
2. Use G to jump to bottom (creates a jump)
3. Search for a word: /word (creates a jump)
4. Press Ctrl-o to go back through jumps
5. Press Ctrl-i to go forward
6. Use :jumps to see your jump history
        ]],
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
        setup = function()
          local buf = vim.api.nvim_create_buf(false, true)
          local lines = {
            '──── Search Practice ────',
            '',
            'The word "target" appears multiple times.',
            'First target here.',
            'Second target here.',
            'Third target here.',
            '',
            'Try: /target to search forward',
            'Press n to go to next match',
            'Press N to go to previous match',
            '',
            'More target instances below:',
            'Fourth target',
            'Fifth target',
            'Last target',
            '',
            'Try: ?target to search backward',
            '',
            '──────────────────────────',
          }
          vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
          return buf
        end,
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
        setup = function()
          local buf = vim.api.nvim_create_buf(false, true)
          local lines = {
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
            'Try:',
            '1. Put cursor on opening { and press %',
            '2. Put cursor on ( and press %',
            '3. Put cursor on [ and press %',
            '',
            '───────────────────────────',
          }
          vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
          return buf
        end,
        hints = {
          '% jumps between matching brackets',
          'Works on ( ) { } [ ] and more',
          'Combine with operators: d%, v%, c%',
          'Great for navigating nested code',
        },
      },
    },
  },
}
