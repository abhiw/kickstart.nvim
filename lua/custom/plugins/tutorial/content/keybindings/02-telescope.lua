-- Telescope Keybindings Tutorial
-- Fuzzy finding for files, text, and more

return {
  metadata = {
    id = 'keybindings-telescope',
    title = 'Telescope - Fuzzy Finding',
    category = 'keybindings',
    difficulty = 'beginner',
    estimated_time = '15 minutes',
    prerequisites = {},
    description = 'Master Telescope fuzzy finding: search files, text, help, keymaps, and more',
  },

  lessons = {
    {
      title = 'Telescope Overview & Common Keybindings',
      content = [[
# Telescope - Fuzzy Finder

Telescope is your gateway to finding anything in Neovim.

All Telescope commands use `<leader>s*` pattern (Space + s + key):

**Most Important (Learn These First)**
- `<leader>sf` → [S]earch [F]iles
- `<leader>sg` → [S]earch by [G]rep (live grep)
- `<leader>sh` → [S]earch [H]elp
- `<leader><leader>` → Find existing buffers

**Other Useful Searches**
- `<leader>sk` → [S]earch [K]eymaps
- `<leader>sw` → [S]earch current [W]ord
- `<leader>sd` → [S]earch [D]iagnostics
- `<leader>sr` → [S]earch [R]esume (last search)
- `<leader>s.` → [S]earch recent files
- `<leader>sn` → [S]earch [N]eovim config files

**In-Buffer Searches**
- `<leader>/` → Fuzzy search in current buffer
- `<leader>s/` → [S]earch in open files

## Telescope UI Navigation

When Telescope opens:
- Type to filter results (fuzzy matching)
- `Ctrl-n` / `Down` → Next result
- `Ctrl-p` / `Up` → Previous result
- `Enter` → Select and open
- `Ctrl-x` → Open in horizontal split
- `Ctrl-v` → Open in vertical split
- `Ctrl-t` → Open in new tab
- `Esc` or `Ctrl-c` → Close telescope

## Fuzzy Matching

Telescope uses smart fuzzy matching:
- `fbr` matches "FooBarBaz"
- `init.l` matches "init.lua"
- `tescope` matches "telescope" (typo-tolerant)

## Pro Tips

- `<leader>s` is the search namespace - easy to remember
- All commands follow mnemonic pattern: s + first letter
- Start typing immediately - no need to wait
- Fuzzy matching is very forgiving
      ]],
      practice = {
        type = 'reference',
        instructions = [[
Practice basic Telescope usage:

1. Press Space + s + f to search files
2. Type partial filename to filter
3. Use Ctrl-n/Ctrl-p or arrow keys to navigate
4. Press Enter to open file
5. Try Space + s + g to search for text
6. Type a word to grep for it across files

Get comfortable with the UI first!
        ]],
        hints = {
          'Space + s is the search prefix',
          'Fuzzy matching is very forgiving',
          'Enter opens, Esc closes',
          'Ctrl-x/v for splits, Ctrl-t for tab',
        },
      },
    },

    {
      title = 'File Finding',
      content = [[
# File Finding

Find and open files quickly:

- `<leader>sf` → [S]earch [F]iles

## How It Works

Opens Telescope with list of all files in project.
Respects .gitignore by default.

## Usage

1. Press `Space` + `s` + `f`
2. Start typing filename (fuzzy match)
3. Navigate with `Ctrl-n`/`Ctrl-p`
4. Press `Enter` to open

## Examples

Finding "user_controller.rb":
- Type `uc` or `user` or `controller`
- All will find it with fuzzy matching

Finding "src/components/Button.tsx":
- Type `button` or `btn` or `components/b`
- Fuzzy matching finds the right file

## Hidden Files

By default, hidden files (.*) are excluded.
To search hidden files, you may need to adjust telescope config.

## Pro Tips

- Fastest way to navigate codebase
- Don't type full names - use fuzzy shortcuts
- Works across entire project
- Respects .gitignore (won't show node_modules, etc.)
      ]],
      practice = {
        type = 'reference',
        instructions = [[
Practice file finding:

1. Space + s + f
2. Type part of a filename you know exists
3. Watch fuzzy matching narrow results
4. Open the file with Enter
5. Try very short queries (2-3 chars)
6. Notice how fast it is!

This should become your primary navigation method.
        ]],
        hints = {
          'Space + s + f finds files',
          'Fuzzy matching is smart - use short queries',
          'Respects .gitignore',
          'Much faster than :edit or file browser',
        },
      },
    },

    {
      title = 'Live Grep - Search Text',
      content = [[
# Live Grep - Search Across Files

Find text anywhere in your project:

- `<leader>sg` → [S]earch by [G]rep (live grep)

## How It Works

Search for text content across all files in project.
Uses ripgrep (rg) for lightning-fast searching.

## Usage

1. Press `Space` + `s` + `g`
2. Type text to search for
3. Results update as you type (live)
4. Navigate and open matching file

## What It Searches

- All files in project
- Respects .gitignore
- Excludes binary files
- Case-insensitive by default (configurable)

## Compared to File Search

- `<leader>sf` → Search file NAMES
- `<leader>sg` → Search file CONTENTS

## Use Cases

- Find where function is called
- Find TODO comments
- Find specific error messages
- Search for any text across codebase

## Pro Tips

- Very fast even in large projects
- Supports regex patterns
- Results show context (line around match)
- Can preview file in telescope pane
      ]],
      practice = {
        type = 'reference',
        instructions = [[
Practice live grep:

1. Space + s + g
2. Type a word that appears in multiple files
3. Watch results appear instantly
4. Notice file paths and line numbers
5. Navigate to a result and press Enter
6. Try searching for "function" or "TODO"

This is incredibly powerful for code navigation!
        ]],
        hints = {
          'Space + s + g searches text content',
          'Live results as you type',
          'Uses ripgrep (super fast)',
          'Shows file, line number, and context',
        },
      },
    },

    {
      title = 'Search Current Word',
      content = [[
# Search Current Word

Search for word under cursor:

- `<leader>sw` → [S]earch current [W]ord

## How It Works

Automatically greps for the word under cursor.
Like `<leader>sg` but pre-filled with current word.

## Usage

1. Put cursor on a word (variable, function, etc.)
2. Press `Space` + `s` + `w`
3. Telescope opens with results for that word

## Common Workflow

Reading code and see a variable:
```
let userName = "John";
```

Cursor on `userName`, press `<leader>sw`:
- Instantly see all occurrences across project
- Jump to any usage

## Comparison with LSP

- LSP `grr` (references) → Language-aware, same symbol
- `<leader>sw` → Text-based, any occurrence

Use LSP for precise language features.
Use `<leader>sw` for quick text search.

## Pro Tips

- Much faster than manually typing in live grep
- Great for quick "where is this used?" searches
- Works on any word, even non-code
- Combine with word motions: `w` to next word, `<leader>sw`
      ]],
      practice = {
        type = 'reference',
        instructions = [[
Practice searching current word:

1. Open a code file
2. Put cursor on a variable or function name
3. Press Space + s + w
4. See all occurrences instantly
5. Jump to one with Enter
6. Try on different words

Very handy for quick searches!
        ]],
        hints = {
          'Space + s + w searches word under cursor',
          'Faster than typing in live grep',
          'Text-based (not language-aware like LSP)',
          'Works on any word',
        },
      },
    },

    {
      title = 'Help & Keymaps',
      content = [[
# Searching Help and Keymaps

Discover Neovim features:

- `<leader>sh` → [S]earch [H]elp
- `<leader>sk` → [S]earch [K]eymaps

## Search Help

`<leader>sh` searches Neovim's help documentation:

Examples:
- Search "telescope" → Find telescope.nvim help
- Search "lsp" → Find LSP documentation
- Search "autocmd" → Find autocmd help

Usage:
1. `Space` + `s` + `h`
2. Type topic
3. Select help tag
4. Opens help in split window

## Search Keymaps

`<leader>sk` lists all configured keybindings:

Shows:
- Keymap
- Mode (n, i, v, etc.)
- Description
- Which plugin/config set it

Usage:
1. `Space` + `s` + `k`
2. Type to filter (e.g., "telescope", "lsp")
3. See keymap and description
4. Great for discovering keybindings!

## Learning Workflow

New to a feature?
1. `<leader>sh` to search help
2. Read documentation
3. `<leader>sk` to find related keymaps
4. Practice!

## Pro Tips

- Help search is fuzzy - approximate topic works
- Keymap search shows ALL keymaps, even custom ones
- Great for discovering features you didn't know existed
- Help files are comprehensive - use them!
      ]],
      practice = {
        type = 'reference',
        instructions = [[
Practice help and keymap search:

1. Space + s + h
2. Search for "telescope"
3. Open a help tag and read
4. Close help with :q
5. Space + s + k
6. Search for "leader" to see all leader keymaps
7. Explore what's available!

These are great learning tools.
        ]],
        hints = {
          'Space + s + h searches help docs',
          'Space + s + k searches keymaps',
          'Great for learning and discovering features',
          'Help docs are very comprehensive',
        },
      },
    },

    {
      title = 'Other Telescope Searches',
      content = [[
# Additional Telescope Searches

More specialized searches:

## Buffer List

- `<leader><leader>` → Find existing buffers

List all open buffers with fuzzy finding.
Faster than `:buffers` or `:ls`.

Usage:
- `Space` twice
- Type buffer name/partial path
- Jump to buffer

## Recent Files

- `<leader>s.` → [S]earch recent files ("." for oldfiles)

Lists recently opened files (from session history).

Great for returning to recently edited files.

## Resume Last Search

- `<leader>sr` → [S]earch [R]esume

Reopens last telescope search with same query.

Use case:
- Did a search, opened file
- Want to open another result from same search
- `<leader>sr` brings it back

## Search Diagnostics

- `<leader>sd` → [S]earch [D]iagnostics

Lists all LSP diagnostics (errors/warnings) with telescope.

Alternative to `<leader>q` (quickfix).
Telescope UI often nicer for browsing.

## Search Neovim Config

- `<leader>sn` → [S]earch [N]eovim config files

Scoped to your `~/.config/nvim` directory.

Quick way to edit config files.

## In-Buffer Search

- `<leader>/` → Fuzzy search in current buffer

Like `/` search but with telescope UI and fuzzy matching.

## Search in Open Files

- `<leader>s/` → [S]earch in open files

Live grep but only in currently open buffers.

## Pro Tips

- `<leader><leader>` (double leader) is super fast for buffer switching
- Use `<leader>sr` to avoid re-typing searches
- Each has its use case - experiment to find favorites
      ]],
      practice = {
        type = 'reference',
        instructions = [[
Practice other searches:

1. Open multiple files
2. Space + Space (double leader) to list buffers
3. Switch to another buffer
4. Space + s + . to see recent files
5. Space + s + r to resume last search
6. Space + s + n to search config files

Each search has its sweet spot - find yours!
        ]],
        hints = {
          'Double Space lists buffers',
          'Space + s + . for recent files',
          'Space + s + r resumes last search',
          'Space + s + n searches neovim config',
        },
      },
    },
  },
}
