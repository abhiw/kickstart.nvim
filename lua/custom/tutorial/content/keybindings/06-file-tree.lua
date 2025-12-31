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
        type = 'interactive',
        instructions = 'Learn Neo-tree file explorer basics.',
        initial_content = {
          '──── Neo-tree Overview ────',
          '',
          'Keybinding: \\ (backslash)',
          '',
          'What it does:',
          '• Toggles Neo-tree sidebar',
          '• Shows directory tree structure',
          '• Highlights current file',
          '• Visual file browser',
          '',
          'Three views (sources):',
          '1. Filesystem - Directory tree (default)',
          '2. Buffers - Open buffers list',
          '3. Git Status - Modified files',
          '',
          'Switch views:',
          '• ] - Next source',
          '• [ - Previous source',
          '',
          'Close: \\ (same key)',
          '',
          '──────────────────────────',
        },
        tasks = {
          {
            instruction = [[Neo-tree File Explorer

\\ (backslash) toggles Neo-tree sidebar - a visual file browser.

What you see:
• Directory tree structure
• Files and folders
• Current file highlighted
• Tree expanded to current file location

Three sources (views):
1. Filesystem - Browse project files
2. Buffers - List open buffers
3. Git Status - See modified files

Switch between sources with ] and [:
• ] moves to next source
• [ moves to previous source

Comparison with Telescope:
• Neo-tree - Visual browsing, file operations
• Telescope - Fast fuzzy finding, searching

Most people use:
• Telescope for navigation (<leader>sf)
• Neo-tree for visual exploration and file ops

Press 'v' when you understand this.]],
            hint = '\\ toggles Neo-tree, ] and [ switch views',
            validate = function()
              return true
            end,
          },
        },
        hints = {
          '\\ toggles Neo-tree open/close',
          '] and [ switch between sources',
          'Shows filesystem, buffers, git status',
          'Visual complement to Telescope',
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
        type = 'interactive',
        instructions = 'Learn Neo-tree navigation.',
        initial_content = {
          '──── Neo-tree Navigation ────',
          '',
          'Standard Vim motions:',
          '• j/k - Move down/up',
          '• gg - Top of tree',
          '• G - Bottom of tree',
          '',
          'Folder operations:',
          '• l or Enter - Expand folder',
          '• h - Collapse folder',
          '• h - Go to parent folder',
          '',
          'Opening files:',
          '• Enter or l - Open in main window',
          '• s - Open in horizontal split',
          '• v - Open in vertical split',
          '',
          'Search:',
          '• / - Search for file/folder',
          '• n/N - Next/previous match',
          '',
          'Refresh: R',
          '',
          '──────────────────────────',
        },
        tasks = {
          {
            instruction = [[Neo-tree Navigation

Navigate Neo-tree using familiar Vim motions:

Movement:
• j/k - Down/up through items
• gg/G - Top/bottom of tree
• Same as normal Vim!

Folders:
• l or Enter - Expand folder (think "go right into it")
• h - Collapse folder or go to parent (think "go left out of it")

Opening files:
• Enter or l - Open in main window
• s - Open in horizontal split
• v - Open in vertical split

Search within tree:
• / - Start search
• Type filename
• n/N - Navigate matches

Refresh:
• R - Refresh tree (if files changed externally)

The navigation feels natural because it uses standard Vim motions!

Press 'v' when ready.]],
            hint = 'h/j/k/l work like Vim motions in tree',
            validate = function()
              return true
            end,
          },
        },
        hints = {
          'j/k move, l expands, h collapses',
          '/ searches within tree',
          's/v open in splits',
          'Natural Vim-style navigation',
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
        type = 'interactive',
        instructions = 'Learn file operations in Neo-tree.',
        initial_content = {
          '──── File Operations ────',
          '',
          'Create:',
          '• a - Add new file or folder',
          '  - End with / for folders',
          '  - Can create nested: src/new/file.js',
          '',
          'Modify:',
          '• r - Rename or move',
          '• d - Delete (⚠️ permanent!)',
          '',
          'Copy/Move:',
          '• c - Copy file',
          '• x - Cut file',
          '• p - Paste',
          '',
          'Clipboard:',
          '• y - Copy filename to clipboard',
          '',
          '⚠️ WARNING:',
          'All operations happen on disk immediately!',
          'Use Git for safety.',
          '',
          '──────────────────────────',
        },
        tasks = {
          {
            instruction = [[File Operations in Neo-tree

Neo-tree provides powerful file management:

Creating:
• a - Add new file or folder
  - Type filename: "newfile.js"
  - Type folder: "newfolder/"
  - Create nested: "src/components/Button.tsx"

Renaming:
• r - Rename or move file
  - Edit the name/path
  - Can move between folders

Deleting:
• d - Delete file/folder
  - ⚠️ PERMANENT - deletes from disk!
  - Always confirm carefully

Copy/Cut/Paste:
• c - Copy file
• x - Cut file
• p - Paste at cursor location

Clipboard:
• y - Copy filename to system clipboard

IMPORTANT:
All operations modify disk immediately.
There's no undo - use Git for safety!

Press 'v' when you understand these operations.]],
            hint = 'a=add, d=delete, r=rename, c/x/p=copy/cut/paste',
            validate = function()
              return true
            end,
          },
        },
        hints = {
          'a creates, d deletes, r renames',
          'c/x/p for copy/cut/paste',
          '⚠️ Operations are permanent!',
          'Use Git for safety',
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
        type = 'interactive',
        instructions = 'Learn Neo-tree buffer view.',
        initial_content = {
          '──── Neo-tree Buffer View ────',
          '',
          'Keybinding: <leader>fb (Space + f + b)',
          '',
          'What it shows:',
          '• All open buffers',
          '• Current buffer highlighted',
          '• Buffer numbers',
          '• File paths',
          '• Modified indicators (*)',
          '',
          'Operations:',
          '• j/k - Navigate',
          '• Enter - Switch to buffer',
          '• d - Delete buffer',
          '• \\ - Close Neo-tree',
          '',
          'Comparison:',
          '• <leader><leader> - Telescope buffers',
          '• <leader>fb - Neo-tree buffers',
          '',
          'Use whichever you prefer!',
          '',
          '──────────────────────────',
        },
        tasks = {
          {
            instruction = [[Neo-tree Buffer View

<leader>fb (Space + f + b) opens buffer view in Neo-tree.

What you see:
• List of all open buffers
• Current buffer highlighted
• Buffer numbers and paths
• Modified indicators (*)

Operations:
• j/k - Navigate up/down
• Enter - Switch to that buffer
• d - Delete buffer (close it)
• \\ - Close Neo-tree

Two ways to manage buffers:
1. Telescope: <leader><leader> (double Space)
   - Fuzzy finding
   - Type to filter
   - Fast selection

2. Neo-tree: <leader>fb
   - Visual list
   - See all buffers at once
   - Easy to scan and delete

Use whichever fits your workflow better!

Press 'v' when ready.]],
            hint = '<leader>fb = File Buffers view',
            validate = function()
              return true
            end,
          },
        },
        hints = {
          '<leader>fb opens buffer view',
          'd deletes buffer',
          'Visual alternative to Telescope',
          'Good for scanning and managing buffers',
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
        type = 'interactive',
        instructions = 'Learn about the resolved keybinding conflict.',
        initial_content = {
          '──── Keybinding Conflict Resolution ────',
          '',
          'IMPORTANT: Conflict has been fixed!',
          '',
          'Original problem:',
          '• <leader>b was mapped to TWO things',
          '  1. Debug: Toggle breakpoint',
          '  2. Neo-tree: Show buffers',
          '',
          'Resolution:',
          '• <leader>b → Debug breakpoint (kept)',
          '• <leader>fb → Neo-tree buffers (new)',
          '',
          'Why this change?',
          '• Debug uses <leader>b frequently',
          '• <leader>fb is more descriptive',
          '• fb = [F]ile [B]uffers (mnemonic)',
          '',
          'Remember:',
          '• Space + b = Debug breakpoint',
          '• Space + f + b = File Buffers',
          '• No more conflict!',
          '',
          '───────────────────────────────────────',
        },
        tasks = {
          {
            instruction = [[Keybinding Conflict Resolution

Your config had a conflict that has been fixed:

Original conflict:
• <leader>b mapped to BOTH debug breakpoint AND Neo-tree buffers

Resolution:
• <leader>b → Debug: Toggle breakpoint (kept - more frequent)
• <leader>fb → Neo-tree: File Buffers (new - more descriptive)

Why this is better:
• No more ambiguity or conflict
• <leader>fb is self-documenting: [F]ile [B]uffers
• Fits with file management theme (<leader>f for format)
• Debug keeps the shorter binding (used more often)

Practice the new keybinding:
1. Press Space + f + b (not Space + b!)
2. This opens Neo-tree buffer view
3. Remember: fb = File Buffers (mnemonic)
4. Close with \\
5. Try debug: Space + b sets breakpoint
6. Both work without conflict!

Build new muscle memory: Space + f + b for File Buffers

Press 'v' when you understand the resolution.]],
            hint = '<leader>fb (Space+f+b) = File Buffers, <leader>b = Debug',
            validate = function()
              return true
            end,
          },
        },
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
