-- Core Keybindings Tutorial
-- Essential keybindings for window navigation, diagnostics, and basic operations

return {
  metadata = {
    id = 'keybindings-core',
    title = 'Core Keybindings',
    category = 'keybindings',
    difficulty = 'beginner',
    estimated_time = '10 minutes',
    prerequisites = {},
    description = 'Learn essential keybindings for window navigation, diagnostics, formatting, and terminal mode',
  },

  lessons = {
    {
      title = 'Window Navigation',
      content = [[
# Window Navigation

Move focus between split windows efficiently:

- `Ctrl-h` → Move focus to LEFT window
- `Ctrl-j` → Move focus to DOWN window
- `Ctrl-k` → Move focus to UP window
- `Ctrl-l` → Move focus to RIGHT window

## Why These Keys?

These mirror the Vim motion keys (hjkl) with Ctrl modifier:
- Same directional logic as basic motions
- Easy to remember and execute
- Faster than :wincmd h/j/k/l

## Common Workflow

```
:split          " Horizontal split
Ctrl-j          " Move to lower window
:vsplit         " Vertical split
Ctrl-l          " Move to right window
Ctrl-h          " Move back to left window
```

## Creating Splits

- `:split` or `:sp` → Horizontal split
- `:vsplit` or `:vs` → Vertical split
- `:split filename` → Open file in new split
- `Ctrl-w s` → Horizontal split (same file)
- `Ctrl-w v` → Vertical split (same file)

## Other Window Commands

- `Ctrl-w q` → Close current window
- `Ctrl-w o` → Close all other windows
- `Ctrl-w =` → Make all windows equal size
- `Ctrl-w _` → Maximize current window height
- `Ctrl-w |` → Maximize current window width

## Pro Tips

- These bindings work across all splits
- Muscle memory from hjkl makes these natural
- Combine with :split/:vsplit for powerful layouts
      ]],
      practice = {
        type = 'reference',
        instructions = [[
Practice window navigation:

1. Open a split: :split
2. Press Ctrl-j to move to lower window
3. Press Ctrl-k to move back to upper window
4. Create vertical split: :vsplit
5. Use Ctrl-h and Ctrl-l to navigate
6. Close windows: Ctrl-w q

Try creating complex layouts and navigating between them.
        ]],
        hints = {
          'Ctrl-h/j/k/l mirrors Vim hjkl motions',
          'Works with any number of splits',
          ':split creates horizontal split',
          ':vsplit creates vertical split',
        },
      },
    },

    {
      title = 'Search Highlighting',
      content = [[
# Search Highlighting Control

Clear search highlights:

- `Esc` (in normal mode) → Clear search highlights

## Context

When you search with `/pattern`, Vim highlights all matches.
This is great while searching, but can be distracting afterward.

## Default Behavior

Without this keymap, you'd use:
- `:nohlsearch` or `:noh` → Clear highlights

## Your Config

Your config maps `Esc` to automatically clear highlights.
This is very convenient - just press Esc when done searching.

## Related Settings

Your config likely has:
```lua
vim.opt.hlsearch = true     -- Highlight search results
vim.opt.incsearch = true    -- Show matches as you type
```

## Pro Tips

- Highlights automatically clear when you press Esc
- Start new search with `/` anytime
- Use `n` and `N` to navigate without triggering new highlights
      ]],
      practice = {
        type = 'reference',
        instructions = [[
Practice search highlighting:

1. Search for a word: /word
2. Notice all matches are highlighted
3. Press n to jump to next match
4. Press Esc to clear highlights
5. Search for something else: /another
6. Press Esc again to clear

Clean and simple!
        ]],
        hints = {
          'Esc clears search highlights',
          '/pattern starts a new search',
          'n and N navigate without triggering highlights',
        },
      },
    },

    {
      title = 'Diagnostics Quick Fix',
      content = [[
# Diagnostics Quick Fix List

Open diagnostics in quickfix:

- `<leader>q` → Open diagnostic quickfix list

Remember: `<leader>` is Space in your config.

## What Are Diagnostics?

Diagnostics are issues found by LSP:
- Errors (red)
- Warnings (yellow)
- Info messages (blue)
- Hints (gray)

## Quickfix List

The quickfix list shows all diagnostics in current buffer.

After opening with `<leader>q`:
- `Enter` → Jump to diagnostic
- `:cn` or `:cnext` → Next item
- `:cp` or `:cprev` → Previous item
- `:cclose` → Close quickfix window

## Navigation Without Quickfix

- `]d` → Next diagnostic (if configured)
- `[d` → Previous diagnostic (if configured)
- `<leader>e` → Show diagnostic float (may be configured)

## Use Cases

1. **Review all errors** → `<leader>q` to see all at once
2. **Jump to errors** → Use quickfix to navigate
3. **Fix systematically** → Go through list, fix each

## Pro Tips

- Quickfix persists - close and reopen anytime
- Great for reviewing before committing code
- Combine with LSP code actions to fix issues
      ]],
      practice = {
        type = 'reference',
        instructions = [[
Practice diagnostic navigation:

1. Open a file with errors/warnings
2. Press Space then q to open quickfix
3. Navigate the list with j/k
4. Press Enter to jump to diagnostic
5. Use :cn and :cp to move between items
6. Close with :cclose

Very useful for code review workflow!
        ]],
        hints = {
          'Space + q opens diagnostic quickfix',
          'Enter jumps to diagnostic',
          ':cn next, :cp previous',
          ':cclose closes quickfix window',
        },
      },
    },

    {
      title = 'Terminal Mode Exit',
      content = [[
# Exiting Terminal Mode

Exit terminal mode quickly:

- `Esc Esc` (double Esc) → Exit terminal mode to normal mode

## Terminal Mode in Neovim

Neovim has built-in terminal emulator:
- `:terminal` or `:term` → Open terminal

In terminal mode:
- You can type commands normally
- Terminal receives all input
- Need to exit to use Vim commands

## Default Behavior

By default, you exit terminal mode with:
- `Ctrl-\ Ctrl-n` → Exit to normal mode

That's awkward and hard to remember!

## Your Config

Your config maps `Esc Esc` (double press) to exit.
Much more intuitive and faster.

## Once in Normal Mode

After pressing `Esc Esc`:
- Navigate with hjkl
- Scroll through terminal output
- Yank text from terminal
- `i` or `a` to go back to terminal mode

## Pro Tips

- `:term` opens terminal in current window
- `:split | term` opens in horizontal split
- `:vsplit | term` opens in vertical split
- Use window navigation (Ctrl-h/j/k/l) to leave terminal window
      ]],
      practice = {
        type = 'reference',
        instructions = [[
Practice terminal mode:

1. Open terminal: :terminal
2. Run a command: ls or dir
3. Press Esc Esc to exit terminal mode
4. Navigate terminal output with hjkl
5. Press i to go back to terminal mode
6. Exit terminal: type 'exit' or close window

Useful for quick shell commands without leaving Neovim!
        ]],
        hints = {
          ':term opens built-in terminal',
          'Esc Esc exits to normal mode',
          'i or a returns to terminal mode',
          'Close with :q or by exiting shell',
        },
      },
    },

    {
      title = 'Formatting',
      content = [[
# Code Formatting

Format current buffer:

- `<leader>f` → Format current buffer

Remember: `<leader>` is Space, so: Space + f

## What It Does

Runs the configured formatter for current filetype:
- JavaScript/TypeScript → Prettier
- Lua → Stylua
- C/C++ → clang-format
- Go → gofmt
- Python → black/autopep8
- etc.

## Your Config

You have conform.nvim configured for formatting.
It automatically selects the right formatter based on filetype.

## When to Use

- Before committing code
- After major edits
- When code style is messy
- To enforce consistent formatting

## Auto-Format on Save

Your config might have format-on-save enabled.
Check your conform.nvim setup in init.lua.

If not, you can enable it:
```lua
format_on_save = {
  timeout_ms = 500,
  lsp_fallback = true,
}
```

## LSP Formatting

If no formatter is configured, falls back to LSP formatting.

## Pro Tips

- `Space f` becomes muscle memory
- Run before every commit
- Combine with linting for clean code
- Visual mode: select text, then `<leader>f` to format selection
      ]],
      practice = {
        type = 'reference',
        instructions = [[
Practice formatting:

1. Open a code file
2. Make some formatting messy (bad indentation, etc.)
3. Press Space then f to format
4. Watch it auto-fix indentation and style
5. Try in visual mode: select code, Space f

Formatting should be effortless!
        ]],
        hints = {
          'Space + f formats current buffer',
          'Uses conform.nvim with configured formatters',
          'Falls back to LSP if no formatter found',
          'Can format selections in visual mode',
        },
      },
    },
  },
}
