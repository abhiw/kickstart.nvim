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
Window navigation requires multiple windows to practice effectively.

Practice in your normal Neovim workflow:

1. Open a split: :split
2. Press Ctrl-j to move to lower window
3. Press Ctrl-k to move back to upper window
4. Create vertical split: :vsplit
5. Use Ctrl-h and Ctrl-l to navigate
6. Close windows: Ctrl-w q

Note: This is a reference lesson. Practice with real files for best results.
        ]],
        hints = {
          'Ctrl-h/j/k/l mirrors Vim hjkl motions',
          'Works with any number of splits',
          ':split creates horizontal split',
          ':vsplit creates vertical split',
          'Practice with real files for muscle memory',
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
        type = 'interactive',
        instructions = 'Learn the search highlighting workflow.',
        initial_content = {
          '──── Search Highlighting Practice ────',
          '',
          'The word practice appears multiple times.',
          'First practice occurrence.',
          'Second practice here.',
          'Third practice instance.',
          '',
          'Try: /practice to search',
          'Then: Esc to clear highlights',
          '',
          '───────────────────────────────────────',
        },
        tasks = {
          {
            instruction = [[Understanding Search Highlighting

When you search with /pattern, Vim highlights all matches.
Your config maps Esc to clear these highlights automatically.

Default command would be: :nohlsearch
Your config shortcut: just press Esc

This makes clearing highlights effortless!
Press 'v' when ready to continue.]],
            hint = 'Esc is mapped to clear search highlights',
            validate = function()
              return true
            end,
          },
        },
        hints = {
          'Esc clears search highlights',
          '/pattern starts a new search',
          'n and N navigate matches',
          'Much faster than :nohlsearch',
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
        type = 'interactive',
        instructions = 'Learn diagnostic quickfix workflow.',
        initial_content = {
          '──── Diagnostics Quickfix ────',
          '',
          'Keybinding: <leader>q (Space + q)',
          '',
          'What it does:',
          '• Opens quickfix list with all diagnostics',
          '• Shows errors, warnings, info, hints',
          '• Allows quick navigation to issues',
          '',
          'Quickfix navigation:',
          '• Enter - Jump to diagnostic',
          '• :cn - Next item',
          '• :cp - Previous item',
          '• :cclose - Close quickfix',
          '',
          '───────────────────────────────',
        },
        tasks = {
          {
            instruction = [[Diagnostic Quickfix Overview

<leader>q (Space + q) opens the diagnostic quickfix list.

This shows all LSP diagnostics in the current buffer:
• Errors (problems that prevent code from working)
• Warnings (potential issues)
• Info messages (suggestions)
• Hints (optimization tips)

Use quickfix to systematically review and fix issues.
Press 'v' when you understand this workflow.]],
            hint = 'Space + q opens diagnostic quickfix list',
            validate = function()
              return true
            end,
          },
        },
        hints = {
          'Space + q opens diagnostic quickfix',
          'Requires LSP to be running',
          'Great for reviewing all errors at once',
          'Use before committing code',
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
        type = 'interactive',
        instructions = 'Learn terminal mode navigation.',
        initial_content = {
          '──── Terminal Mode Exit ────',
          '',
          'Keybinding: Esc Esc (double press)',
          '',
          'What it does:',
          '• Exits terminal mode to normal mode',
          '• Allows you to navigate terminal output',
          '• Much easier than default Ctrl-\\ Ctrl-n',
          '',
          'Terminal workflow:',
          '1. :terminal - Open built-in terminal',
          '2. Run commands normally',
          '3. Esc Esc - Exit to normal mode',
          '4. Navigate with hjkl, yank text',
          '5. i or a - Return to terminal mode',
          '',
          '───────────────────────────────',
        },
        tasks = {
          {
            instruction = [[Terminal Mode Overview

Neovim has a built-in terminal emulator (:terminal).

When in terminal mode, all input goes to the shell.
To use Vim commands, you need to exit terminal mode.

Default exit: Ctrl-\\ Ctrl-n (awkward!)
Your config: Esc Esc (much better!)

After exiting to normal mode:
• Navigate terminal output with hjkl
• Yank text from terminal
• Press i/a to return to terminal mode

Press 'v' when you understand this.]],
            hint = 'Esc Esc exits terminal mode',
            validate = function()
              return true
            end,
          },
        },
        hints = {
          ':term opens built-in terminal',
          'Esc Esc exits to normal mode',
          'i or a returns to terminal mode',
          'Great for quick shell commands',
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
        type = 'interactive',
        instructions = 'Learn code formatting workflow.',
        initial_content = {
          '──── Code Formatting ────',
          '',
          'Keybinding: <leader>f (Space + f)',
          '',
          'What it does:',
          '• Formats entire buffer',
          '• Uses configured formatter for filetype',
          '• Falls back to LSP if no formatter',
          '• Works on visual selections too',
          '',
          'Common formatters:',
          '• JavaScript/TypeScript - Prettier',
          '• Lua - Stylua',
          '• C/C++ - clang-format',
          '• Python - black/autopep8',
          '• Go - gofmt',
          '',
          '───────────────────────────────',
        },
        tasks = {
          {
            instruction = [[Code Formatting Overview

<leader>f (Space + f) formats your code automatically.

Your config uses conform.nvim which:
• Detects filetype automatically
• Runs appropriate formatter
• Falls back to LSP formatting if needed
• Can format visual selections

When to format:
• Before committing code
• After major edits
• When code style is messy
• To enforce team conventions

Many configs enable format-on-save automatically.

Press 'v' when you understand this workflow.]],
            hint = 'Space + f formats current buffer',
            validate = function()
              return true
            end,
          },
        },
        hints = {
          'Space + f formats current buffer',
          'Uses conform.nvim with formatters',
          'Falls back to LSP formatting',
          'Works on visual selections',
        },
      },
    },
  },
}
