-- Git Keybindings Tutorial
-- Gitsigns integration for Git operations in Neovim

return {
  metadata = {
    id = 'keybindings-git',
    title = 'Git with Gitsigns',
    category = 'keybindings',
    difficulty = 'beginner',
    estimated_time = '15 minutes',
    prerequisites = {},
    description = 'Learn Git operations in Neovim: hunks, staging, blame, diff, and more',
  },

  lessons = {
    {
      title = 'Git Integration Overview',
      content = [[
# Git in Neovim with Gitsigns

Your config uses gitsigns.nvim for Git integration:

**Hunk Operations:**
- `<leader>hs` → [H]unk [S]tage
- `<leader>hr` → [H]unk [R]eset
- `<leader>hS` → [H]unk [S]tage buffer (all hunks)
- `<leader>hu` → [H]unk [U]ndo stage
- `<leader>hR` → [H]unk [R]eset buffer (all hunks)

**View Changes:**
- `<leader>hp` → [H]unk [P]review
- `<leader>hd` → [H]unk [D]iff against index
- `<leader>hD` → [H]unk [D]iff against last commit

**Git Blame:**
- `<leader>hb` → [H]unk [B]lame line
- `<leader>tb` → [T]oggle [B]lame line

**Navigation:**
- `]c` → Next change (hunk)
- `[c` → Previous change (hunk)

**Other Toggles:**
- `<leader>tD` → [T]oggle [D]eleted lines

## What Are Hunks?

A "hunk" is a contiguous block of changes:
- Added lines (green)
- Modified lines (yellow)
- Deleted lines (red)

## Git Status Signs

In the gutter, you'll see:
- `+` or `│` → Added lines
- `~` → Modified lines
- `_` → Deleted lines

## Pro Tips

- All Git operations use `<leader>h*` prefix (think "hunk")
- Navigate with `]c` and `[c` between changes
- Stage hunks instead of entire files for cleaner commits
- Use blame to understand why code was changed
      ]],
      practice = {
        type = 'reference',
        instructions = [[
Practice Git basics:

1. Make a change to a file
2. See gitsigns in gutter (+, ~, etc.)
3. Press ]c to jump to next change
4. Press <leader>hp to preview hunk
5. Press <leader>hs to stage hunk
6. Press <leader>hr to reset hunk

Git integration at your fingertips!
        ]],
        hints = {
          '<leader>h* is for hunk operations',
          ']c and [c navigate changes',
          'Gutter signs show added/modified/deleted',
          'Stage hunks for granular commits',
        },
      },
    },

    {
      title = 'Navigating Changes',
      content = [[
# Navigating Git Changes

Jump between hunks:

- `]c` → Next change (hunk)
- `[c` → Previous change (hunk)

## How It Works

Jumps to next/previous hunk in current buffer.

Hunks are blocks of changes:
- Added lines
- Modified lines
- Deleted lines

## Usage

1. Edit a file
2. Save (git sees changes)
3. Press `]c` to jump to next change
4. Press `[c` to jump to previous change

## Visual Feedback

Gutter signs show where you are:
- Green/yellow/red marks
- Current hunk may be highlighted

## Workflow

Review your changes before committing:
```
]c              " Jump to next change
<leader>hp      " Preview this hunk
]c              " Jump to next change
<leader>hp      " Preview this hunk
...
```

## Alternative: Diff View

For full file diff:
- `<leader>hd` → Diff against index

But `]c`/`[c` is faster for quick review.

## Pro Tips

- Think `]` = next, `[` = previous (common Vim pattern)
- Combine with preview: `]c` then `<leader>hp`
- Great for reviewing changes before staging
- Works only in files with changes
      ]],
      practice = {
        type = 'reference',
        instructions = [[
Practice navigation:

1. Make several changes in a file
2. Press ]c to jump to first change
3. Press ]c again for next change
4. Press [c to go back
5. Try ]c to cycle through all changes

Fast way to review your work!
        ]],
        hints = {
          ']c jumps to next change',
          '[c jumps to previous change',
          'Only works in modified files',
          'Combine with preview for review',
        },
      },
    },

    {
      title = 'Staging Hunks',
      content = [[
# Staging Changes

Stage hunks individually or all at once:

- `<leader>hs` → [H]unk [S]tage (current hunk)
- `<leader>hS` → [H]unk [S]tage buffer (all hunks)
- `<leader>hu` → [H]unk [U]ndo stage

## Why Stage Hunks?

Traditional Git workflow:
```bash
git add file.js    # Stages entire file
```

With gitsigns:
```
<leader>hs         # Stage only current hunk
```

Benefits:
- Granular control
- Separate concerns into different commits
- Don't commit debug code mixed with real changes

## Staging Current Hunk

1. Navigate to a hunk (or `]c` to jump)
2. Press `<leader>hs`
3. Hunk is staged
4. Gutter sign may change (showing staged state)

## Staging Entire Buffer

All changes in current file:
1. Press `<leader>hS` (capital S)
2. All hunks staged

Equivalent to `git add <current-file>`

## Unstaging

Made a mistake?
1. Press `<leader>hu`
2. Unstages last staged hunk

Or use Git commands:
```
:!git reset HEAD <file>
```

## Visual Mode

Can also stage selected lines:
1. Select lines in visual mode
2. Press `<leader>hs`
3. Only selected lines staged

## Pro Tips

- `<leader>hs` is lowercase = stage current hunk
- `<leader>hS` is uppercase = stage ALL hunks in file
- Review with `<leader>hp` before staging
- Use hunks for atomic commits
      ]],
      practice = {
        type = 'reference',
        instructions = [[
Practice staging:

1. Make changes to a file
2. Navigate to first hunk: ]c
3. Stage it: <leader>hs
4. Navigate to next hunk: ]c
5. Stage it too: <leader>hs
6. Or stage all: <leader>hS
7. Undo if needed: <leader>hu

Selective staging for better commits!
        ]],
        hints = {
          '<leader>hs stages current hunk',
          '<leader>hS stages all hunks in buffer',
          '<leader>hu unstages',
          'Works in visual mode too',
        },
      },
    },

    {
      title = 'Resetting Changes',
      content = [[
# Resetting/Discarding Changes

Undo changes (reset to last commit):

- `<leader>hr` → [H]unk [R]eset (current hunk)
- `<leader>hR` → [H]unk [R]eset buffer (all hunks)

## Reset Current Hunk

Discard changes in current hunk:
1. Navigate to hunk
2. Press `<leader>hr`
3. Changes discarded (back to last commit)

⚠️ WARNING: This is destructive! Changes are lost.

## Reset Entire Buffer

Discard ALL changes in file:
1. Press `<leader>hR` (capital R)
2. Entire file back to last commit

Equivalent to: `git checkout -- <file>`

⚠️ WARNING: All unsaved changes in file are lost!

## When to Use

**Reset hunk:**
- Made a change you don't want
- Testing different approaches
- Accidentally edited something

**Reset buffer:**
- Want to start over
- File got messed up
- Easier than manual undo

## Safety

Neovim has undo history:
- Even after reset, can undo with `u`
- But only if you haven't closed buffer
- Better to use Git commands for recovery

## Alternative: Stash

If unsure about discarding:
```
:!git stash       " Stash changes instead
:!git stash pop   " Restore later
```

## Pro Tips

- `<leader>hr` is lowercase = reset current hunk
- `<leader>hR` is uppercase = reset ALL hunks
- Preview with `<leader>hp` before resetting
- Can undo immediately with `u` if mistake
      ]],
      practice = {
        type = 'reference',
        instructions = [[
Practice resetting (carefully!):

1. Make a small change
2. Navigate to hunk: ]c
3. Reset it: <leader>hr
4. See change disappear
5. Make more changes
6. Try resetting all: <leader>hR
7. Practice with undo: u

Be careful - this discards work!
        ]],
        hints = {
          '<leader>hr resets current hunk',
          '<leader>hR resets all hunks in buffer',
          'Destructive - changes are lost!',
          'Can undo with u immediately after',
        },
      },
    },

    {
      title = 'Previewing and Diffing',
      content = [[
# Previewing Changes

View changes before staging/committing:

- `<leader>hp` → [H]unk [P]review
- `<leader>hd` → [H]unk [D]iff against index
- `<leader>hD` → [H]unk [D]iff against last commit

## Preview Hunk

Show current hunk in floating window:
1. Navigate to hunk (or `]c`)
2. Press `<leader>hp`
3. Floating window shows changes
4. Press `q` or `Esc` to close

Shows:
- Removed lines (red, prefixed with -)
- Added lines (green, prefixed with +)

## Diff Against Index

Full diff of file against staging area:
- `<leader>hd`

Opens diff view showing:
- What's currently staged
- vs your working copy

Good for reviewing before final commit.

## Diff Against Last Commit

Full diff against last commit:
- `<leader>hD` (capital D)

Shows all changes (staged + unstaged) vs last commit.

## When to Use What

**Preview (`<leader>hp`):**
- Quick look at current hunk
- Floating window (non-intrusive)
- Great while navigating changes

**Diff Index (`<leader>hd`):**
- Full file view
- See relationship between staged/unstaged
- Before committing

**Diff Commit (`<leader>hD`):**
- See all changes you've made
- Full context
- Before pushing

## Pro Tips

- Preview is fastest for quick checks
- Diff views for thorough review
- Close diffs with `:q`
- Combine with navigation: `]c`, `<leader>hp`, `]c`, `<leader>hp`
      ]],
      practice = {
        type = 'reference',
        instructions = [[
Practice previewing:

1. Make changes to a file
2. Navigate to hunk: ]c
3. Preview: <leader>hp
4. Close preview: q or Esc
5. Try full diff: <leader>hd
6. See staging area diff
7. Try commit diff: <leader>hD

Know your changes before committing!
        ]],
        hints = {
          '<leader>hp previews current hunk',
          '<leader>hd shows diff vs index',
          '<leader>hD shows diff vs last commit',
          'Preview is quick, diffs are thorough',
        },
      },
    },

    {
      title = 'Git Blame',
      content = [[
# Git Blame

See who changed each line and when:

- `<leader>hb` → [H]unk [B]lame line
- `<leader>tb` → [T]oggle [B]lame line (persistent)

## Blame Line

See blame for current line:
1. Put cursor on any line
2. Press `<leader>hb`
3. Virtual text or popup shows:
   - Author name
   - Commit hash
   - Commit date
   - Commit message

## Toggle Blame

Show blame for ALL lines:
1. Press `<leader>tb`
2. Virtual text appears on every line
3. Shows blame info inline
4. Press `<leader>tb` again to hide

## What Is Git Blame?

Shows the last commit that modified each line.

Useful for:
- "Who wrote this code?"
- "When was this changed?"
- "Why was this changed?" (from commit message)

## Blame Info Format

Typically shows:
```
John Doe, 2 months ago - Fix authentication bug (#123)
```

- Name of author
- When it was changed
- Commit message (often has ticket #)

## Use Cases

**Understanding code:**
- Why was this done this way?
- Check commit message for context

**Finding experts:**
- Who understands this code?
- Who to ask questions?

**Tracking bugs:**
- When was this bug introduced?
- What else changed in that commit?

**Code review:**
- When was this last touched?
- Is it old code or recent?

## Pro Tips

- `<leader>hb` for quick one-line check
- `<leader>tb` to see all blame (toggle on/off)
- Can click commit hash to see full commit (some configs)
- Blame is per-line, not per-hunk
      ]],
      practice = {
        type = 'reference',
        instructions = [[
Practice Git blame:

1. Open a file in Git repo
2. Put cursor on a line
3. Press <leader>hb to see blame
4. Try different lines
5. Toggle blame for whole file: <leader>tb
6. See all authorship info
7. Toggle off: <leader>tb again

Great for understanding code history!
        ]],
        hints = {
          '<leader>hb shows blame for current line',
          '<leader>tb toggles blame for all lines',
          'Shows author, date, commit message',
          'Useful for understanding code context',
        },
      },
    },
  },
}
