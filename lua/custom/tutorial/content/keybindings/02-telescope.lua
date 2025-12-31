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
        type = 'interactive',
        instructions = 'Learn Telescope fuzzy finder basics.',
        initial_content = {
          '──── Telescope Overview ────',
          '',
          'Pattern: <leader>s* (Space + s + key)',
          '',
          'Essential commands:',
          '• Space + s + f - [S]earch [F]iles',
          '• Space + s + g - [S]earch by [G]rep',
          '• Space + s + h - [S]earch [H]elp',
          '• Space + Space - Find buffers',
          '',
          'Navigation in Telescope:',
          '• Type to filter (fuzzy matching)',
          '• Ctrl-n/Down - Next result',
          '• Ctrl-p/Up - Previous result',
          '• Enter - Open',
          '• Esc - Close',
          '',
          'Opening options:',
          '• Ctrl-x - Horizontal split',
          '• Ctrl-v - Vertical split',
          '• Ctrl-t - New tab',
          '',
          '────────────────────────────',
        },
        tasks = {
          {
            instruction = [[Telescope Fuzzy Finder Overview

Telescope is your primary tool for finding anything in Neovim.

All commands start with <leader>s (Space + s):
• Space + s + f = Search Files
• Space + s + g = Search by Grep (text in files)
• Space + s + h = Search Help documentation
• Space + Space = Find open buffers

The pattern is mnemonic: s + first letter of what you're searching.

Fuzzy matching means you don't need exact text:
• "fbr" matches "FooBarBaz"
• "init.l" matches "init.lua"

Press 'v' when you understand this workflow.]],
            hint = 'Space + s is the search prefix for all Telescope commands',
            validate = function()
              return true
            end,
          },
        },
        hints = {
          'Space + s is the search namespace',
          'Mnemonic: s + first letter (sf=files, sg=grep)',
          'Fuzzy matching is very forgiving',
          'Ctrl-n/p to navigate, Enter to open',
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
        type = 'interactive',
        instructions = 'Learn file finding with Telescope.',
        initial_content = {
          '──── File Finding ────',
          '',
          'Keybinding: <leader>sf (Space + s + f)',
          '',
          'What it does:',
          '• Opens list of all files in project',
          '• Respects .gitignore by default',
          '• Uses fuzzy matching for filtering',
          '',
          'Workflow:',
          '1. Space + s + f',
          '2. Type part of filename',
          '3. Ctrl-n/p to navigate',
          '4. Enter to open',
          '',
          'Fuzzy examples:',
          '• "uc" finds "user_controller.rb"',
          '• "btn" finds "Button.tsx"',
          '• "comp/b" finds "components/Button"',
          '',
          '──────────────────────────',
        },
        tasks = {
          {
            instruction = [[File Finding with Telescope

<leader>sf (Space + s + f) is the fastest way to navigate files.

It searches ALL files in your project and uses fuzzy matching:
• Don't type full names - use shortcuts
• "uc" can find "user_controller.rb"
• "btn" can find "Button.tsx"

Respects .gitignore so you won't see:
• node_modules/
• .git/
• build artifacts

This should become your primary file navigation method.
Much faster than :edit or file trees!

Press 'v' when you understand this workflow.]],
            hint = 'Space + s + f = fastest file navigation',
            validate = function()
              return true
            end,
          },
        },
        hints = {
          'Space + s + f finds files',
          'Fuzzy matching - use 2-3 char shortcuts',
          'Respects .gitignore automatically',
          'Fastest navigation method',
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
        type = 'interactive',
        instructions = 'Learn live grep for searching text.',
        initial_content = {
          '──── Live Grep ────',
          '',
          'Keybinding: <leader>sg (Space + s + g)',
          '',
          'What it does:',
          '• Searches TEXT CONTENT across all files',
          '• Uses ripgrep (extremely fast)',
          '• Results update as you type (live)',
          '• Respects .gitignore',
          '',
          'Comparison:',
          '• Space + s + f = Search file NAMES',
          '• Space + s + g = Search file CONTENTS',
          '',
          'Use cases:',
          '• Find where function is called',
          '• Search for TODO comments',
          '• Find error messages',
          '• Grep any text in codebase',
          '',
          '──────────────────────────',
        },
        tasks = {
          {
            instruction = [[Live Grep - Search File Contents

<leader>sg (Space + s + g) searches TEXT inside files.

How it works:
• Type any text to search for
• Results appear instantly as you type
• Shows: filename, line number, and context
• Navigate with Ctrl-n/p, Enter to open

Uses ripgrep which is incredibly fast:
• Can search millions of lines in seconds
• Respects .gitignore automatically
• Supports regex patterns

Essential for:
• Finding function usages
• Searching for TODOs
• Debugging error messages
• Code archaeology

Press 'v' when you understand this powerful tool.]],
            hint = 'Space + s + g = grep text across entire project',
            validate = function()
              return true
            end,
          },
        },
        hints = {
          'Space + s + g searches file contents',
          'Live results with ripgrep',
          'Shows context around matches',
          'Essential for code navigation',
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
        type = 'interactive',
        instructions = 'Learn to search word under cursor.',
        initial_content = {
          '──── Search Current Word ────',
          '',
          'Keybinding: <leader>sw (Space + s + w)',
          '',
          'What it does:',
          '• Greps for word under cursor',
          '• Pre-fills search with current word',
          '• Shows all occurrences in project',
          '',
          'Workflow:',
          '1. Put cursor on any word',
          '2. Space + s + w',
          '3. Telescope opens with results',
          '',
          'Comparison:',
          '• LSP grr - Language-aware references',
          '• <leader>sw - Text-based search',
          '',
          'Use LSP for precise code navigation.',
          'Use <leader>sw for quick text searches.',
          '',
          '──────────────────────────',
        },
        tasks = {
          {
            instruction = [[Search Current Word

<leader>sw (Space + s + w) searches for the word under cursor.

How to use:
1. Position cursor on any word (variable, function, etc.)
2. Press Space + s + w
3. Telescope opens showing all occurrences

Difference from LSP:
• LSP (grr) - Language-aware, finds symbol references
• <leader>sw - Text-based, finds any matching text

Benefits:
• Much faster than manually typing in grep
• Great for "where is this word used?"
• Works on ANY word, even comments
• No LSP required

Perfect for quick searches!

Press 'v' when you understand.]],
            hint = 'Space + s + w = grep word under cursor',
            validate = function()
              return true
            end,
          },
        },
        hints = {
          'Space + s + w searches word under cursor',
          'Text-based search (not language-aware)',
          'Faster than manual grep',
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
        type = 'interactive',
        instructions = 'Learn help and keymap search.',
        initial_content = {
          '──── Help & Keymaps Search ────',
          '',
          'Two essential discovery tools:',
          '',
          '<leader>sh (Space + s + h)',
          '• [S]earch [H]elp documentation',
          '• Find help on any Neovim topic',
          '• Opens help in split window',
          '',
          '<leader>sk (Space + s + k)',
          '• [S]earch [K]eymaps',
          '• Lists ALL configured keybindings',
          '• Shows mode and description',
          '• Discover what keys do',
          '',
          'Learning workflow:',
          '1. Search help for topic',
          '2. Read documentation',
          '3. Search keymaps to find shortcuts',
          '4. Practice!',
          '',
          '───────────────────────────────',
        },
        tasks = {
          {
            instruction = [[Help and Keymap Discovery

Two commands for learning:

<leader>sh (Space + s + h) - Search Help
• Searches Neovim's comprehensive help system
• Example: search "telescope" for telescope help
• Opens help documentation in split window

<leader>sk (Space + s + k) - Search Keymaps
• Lists ALL your configured keybindings
• Filter by typing (e.g., "telescope", "lsp")
• Shows mode, key, and description
• Perfect for discovering what keys you have

These are your learning tools!
Use them whenever you want to:
• Learn a new feature
• Remember a forgotten keybinding
• Discover what's possible

Press 'v' when ready.]],
            hint = 'sh=help docs, sk=keymap list',
            validate = function()
              return true
            end,
          },
        },
        hints = {
          'Space + s + h searches help',
          'Space + s + k lists all keymaps',
          'Essential for learning and discovery',
          'Help docs are comprehensive',
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
        type = 'interactive',
        instructions = 'Learn additional Telescope searches.',
        initial_content = {
          '──── Other Telescope Searches ────',
          '',
          'Quick reference of other useful searches:',
          '',
          '<leader><leader> (Space twice)',
          '• Find existing buffers',
          '• Fastest buffer switching',
          '',
          '<leader>s. (Space + s + .)',
          '• Search recent files (oldfiles)',
          '• Return to recently edited files',
          '',
          '<leader>sr (Space + s + r)',
          '• Resume last search',
          '• Brings back previous search query',
          '',
          '<leader>sd (Space + s + d)',
          '• Search diagnostics',
          '• Alternative to quickfix list',
          '',
          '<leader>sn (Space + s + n)',
          '• Search Neovim config files',
          '• Quick config editing',
          '',
          '<leader>/ (Space + /)',
          '• Fuzzy search in current buffer',
          '',
          '───────────────────────────────────',
        },
        tasks = {
          {
            instruction = [[Additional Telescope Searches

More specialized searches for specific workflows:

<leader><leader> - Buffer List
• Double tap Space to list all open buffers
• Fastest way to switch between files
• Much better than :buffers

<leader>s. - Recent Files
• Shows recently opened files (oldfiles)
• Great for returning to yesterday's work

<leader>sr - Resume Last Search
• Brings back your previous telescope search
• Perfect when you need multiple results from same search

<leader>sd - Search Diagnostics
• Lists all errors/warnings with Telescope UI
• Alternative to quickfix (<leader>q)

<leader>sn - Search Config
• Scoped to ~/.config/nvim directory
• Quick way to edit your config

<leader>/ - In-Buffer Search
• Fuzzy search within current file
• Better UI than regular / search

Each has its use case - experiment to find your favorites!

Press 'v' when ready.]],
            hint = 'Many specialized searches - use what fits your workflow',
            validate = function()
              return true
            end,
          },
        },
        hints = {
          'Double Space = buffers (most used!)',
          's. = recent, sr = resume, sd = diagnostics',
          'sn = config files, / = in-buffer search',
          'Experiment to find your favorites',
        },
      },
    },
  },
}
