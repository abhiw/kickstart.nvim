-- File Tree Keybindings Tutorial
-- Neo-tree file explorer navigation

return {
  metadata = {
    id = 'keybindings-file-tree',
    title = 'Neo-tree File Explorer',
    category = 'keybindings',
    difficulty = 'beginner',
    estimated_time = '10 minutes',
    prerequisites = {},
    description = 'Learn Neo-tree file explorer keybindings and navigation',
  },

  lessons = {
    {
      title = 'Neo-tree Overview',
      content = [[
# Neo-tree File Explorer

Visual file browser in Neovim:

**Open/Close:**
- `\` (backslash) → Toggle Neo-tree (reveal current file)
- `<leader>fb` → Neo-tree buffers view

**Inside Neo-tree:**
- `\` → Close Neo-tree window
- `]` → Next source (filesystem → buffers → git_status)
- `[` → Previous source

**In Buffer View:**
- `d` → Delete buffer

## What Is Neo-tree?

Visual file browser like VSCode's sidebar:
- See directory structure
- Navigate files visually
- Perform file operations
- Multiple views (files, buffers, git status)

## Opening Neo-tree

Press `\` (backslash):
- Opens Neo-tree sidebar
- Shows current file highlighted
- Directory tree expanded to current file

## Sources

Neo-tree has multiple "sources":
1. **Filesystem** → Directory tree (default)
2. **Buffers** → Open buffers list
3. **Git Status** → Modified files

Switch with `]` and `[` inside Neo-tree.

## Default Source: Filesystem

Shows:
- Directories (folders)
- Files
- Current file highlighted
- Tree structure

## Pro Tips

- `\` is fast toggle - same key to open and close
- Great for visual exploration
- Most navigation still faster with Telescope (`<leader>sf`)
- Use for file operations (create, delete, move)
      ]],
      practice = {
        type = 'reference',
        instructions = [[
Practice Neo-tree basics:

1. Press \ to open Neo-tree
2. See file tree appear
3. Press ] to switch to buffers view
4. Press ] again for git status
5. Press [ to go back
6. Press \ to close Neo-tree

Simple and visual!
        ]],
        hints = {
          '\\ toggles Neo-tree open/close',
          '] and [ switch between sources',
          'Shows filesystem, buffers, git status',
          'Visual alternative to Telescope',
        },
      },
    },

    {
      title = 'Navigating in Neo-tree',
      content = [[
# Navigating the File Tree

Inside Neo-tree, use Vim motions:

- `j` / `k` → Move up/down
- `h` → Collapse folder / go to parent
- `l` → Expand folder / open file

## Basic Movement

- `j` → Down to next item
- `k` → Up to previous item
- `gg` → Top of tree
- `G` → Bottom of tree

Just like normal Vim navigation!

## Folders

**Expand folder:**
- Move to folder
- Press `l` or `Enter`

**Collapse folder:**
- Move to folder
- Press `h`

**Go to parent folder:**
- Press `h` when on any item

## Opening Files

**Open file:**
- Navigate to file
- Press `Enter` or `l`
- File opens in main window

**Open in split:**
- Navigate to file
- Press `s` → Horizontal split
- Press `v` → Vertical split

## Search in Tree

- `/` → Search for file/folder name
- `n` → Next match
- `N` → Previous match

Fuzzy search within visible tree.

## Refresh Tree

If files changed outside Neovim:
- Press `R` → Refresh tree

## Pro Tips

- h/j/k/l feels natural (same as Vim motions)
- l = expand/open (think "go right into it")
- h = collapse/parent (think "go left out of it")
- Use / to quickly find files in tree
      ]],
      practice = {
        type = 'reference',
        instructions = [[
Practice navigation:

1. Open Neo-tree: \
2. Navigate with j/k
3. Expand a folder: l
4. Collapse it: h
5. Search for a file: /filename
6. Open file: Enter
7. Close Neo-tree: \

Natural Vim-style navigation!
        ]],
        hints = {
          'j/k move up/down',
          'l expands folders/opens files',
          'h collapses folders/goes to parent',
          '/ searches within tree',
        },
      },
    },

    {
      title = 'File Operations',
      content = [[
# File Operations in Neo-tree

Create, delete, rename files:

- `a` → Add (create new file/folder)
- `d` → Delete
- `r` → Rename
- `x` → Cut
- `c` → Copy
- `p` → Paste
- `y` → Copy filename to clipboard

## Creating Files/Folders

1. Press `a` (add)
2. Type name
3. For folder, end with `/`
4. Press Enter

Examples:
- `newfile.js` → Creates file
- `newfolder/` → Creates folder
- `src/components/Button.tsx` → Creates nested structure

## Deleting

1. Navigate to file/folder
2. Press `d`
3. Confirm deletion

⚠️ Be careful - this deletes from disk!

## Renaming

1. Navigate to file/folder
2. Press `r`
3. Edit name
4. Press Enter

Can also move by changing path.

## Copy/Cut/Paste

Copy or move files:
1. Navigate to source file
2. Press `c` (copy) or `x` (cut)
3. Navigate to destination
4. Press `p` (paste)

## Copy Filename

Press `y` on file:
- Copies filename to clipboard
- Can paste elsewhere

## Pro Tips

- All operations work on disk immediately
- No undo (use Git for safety)
- Can create nested folders in one go
- Useful for project organization
      ]],
      practice = {
        type = 'reference',
        instructions = [[
Practice file operations (in test directory!):

1. Open Neo-tree: \
2. Create test file: a, type "test.txt"
3. Rename it: r, change name
4. Copy it: c
5. Navigate somewhere: j/k
6. Paste: p
7. Delete: d (confirm)

Powerful file management!
        ]],
        hints = {
          'a creates new file/folder',
          'd deletes (careful!)',
          'r renames or moves',
          'c/x/p for copy/cut/paste',
        },
      },
    },

    {
      title = 'Buffer View',
      content = [[
# Neo-tree Buffers View

Manage open buffers:

- `<leader>fb` → Open Neo-tree in buffers view

## What It Shows

List of all open buffers:
- Current buffer highlighted
- Buffer numbers
- File paths
- Modified indicators

## Inside Buffers View

**Navigate:**
- `j` / `k` → Move between buffers
- `Enter` → Switch to buffer

**Delete Buffer:**
- `d` → Delete buffer (close it)

**Switch Sources:**
- `[` → Back to filesystem
- `]` → To git status

## Why Use Buffer View?

Alternative to:
- `:buffers` or `:ls` (text list)
- `<leader><leader>` (Telescope buffers)

Visual interface, easy to see all open files.

## Common Workflow

Open many files, want to see/organize:
1. `<leader>fb` → Open buffers view
2. Navigate with `j`/`k`
3. Delete unwanted buffers with `d`
4. Switch to buffer with `Enter`

## Modified Buffers

Shows indicator for unsaved changes:
- `[+]` or similar marker
- Easy to see what's unsaved

## Pro Tips

- Faster than typing `:buffers`
- Visual, easier to scan
- Can delete multiple buffers quickly
- Still prefer Telescope for fuzzy finding
      ]],
      practice = {
        type = 'reference',
        instructions = [[
Practice buffer view:

1. Open several files
2. Press <leader>fb (Space+f+b)
3. See all open buffers
4. Navigate with j/k
5. Switch to buffer: Enter
6. Delete a buffer: d
7. Close Neo-tree: \

Nice visual buffer management!
        ]],
        hints = {
          '<leader>fb opens buffer view',
          'd deletes buffer in view',
          'Enter switches to buffer',
          'Visual alternative to :buffers',
        },
      },
    },

    {
      title = 'Fixed Keybinding Conflict',
      content = [[
# Keybinding Conflict Resolution

IMPORTANT: Your config had a conflict that has been fixed!

## Original Conflict

- `<leader>b` was mapped to TWO things:
  1. Debug: Toggle breakpoint
  2. Neo-tree: Show buffers

## Resolution

The conflict has been resolved:
- **Debug keeps `<leader>b`** → Toggle breakpoint (more frequently used)
- **Neo-tree changed to `<leader>fb`** → [F]ile [B]uffers (new, more specific)

## Why This Change?

- Debugging uses `<leader>b` often during debug sessions
- File buffer view is used less frequently
- `<leader>fb` is more descriptive: [F]ile [B]uffers
- Fits with file/buffer management theme

## Remember the New Binding

Old: `<leader>b` (confusing, conflicted)
New: `<leader>fb` (clear, [F]ile [B]uffers)

Think: "File Buffers" = `fb`

## Other File-Related Bindings

You now have a consistent pattern:
- `<leader>f` → Format (conform.nvim)
- `<leader>fb` → File Buffers (Neo-tree)

May add more `<leader>f*` in future for file operations.

## Pro Tips

- `<leader>fb` is just Space + f + b
- Mnemonic: File Buffers
- No more conflict with debug breakpoint
- Both keybindings now work perfectly
      ]],
      practice = {
        type = 'reference',
        instructions = [[
Practice the new keybinding:

1. Press Space + f + b (not Space + b!)
2. See Neo-tree buffer view open
3. Remember: fb = File Buffers
4. Close with \
5. Try debug: Space + b sets breakpoint
6. No conflict!

New muscle memory to build!
        ]],
        hints = {
          '<leader>fb is the NEW keybinding',
          '<leader>b is now only for debug',
          'fb = File Buffers (mnemonic)',
          'Conflict resolved!',
        },
      },
    },
  },
}
