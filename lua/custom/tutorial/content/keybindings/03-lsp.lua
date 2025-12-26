-- LSP Keybindings Tutorial
-- Language Server Protocol navigation and code actions

return {
  metadata = {
    id = 'keybindings-lsp',
    title = 'LSP - Code Intelligence',
    category = 'keybindings',
    difficulty = 'intermediate',
    estimated_time = '15 minutes',
    prerequisites = {},
    description = 'Master LSP keybindings: go to definition, find references, rename, code actions, and more',
  },

  lessons = {
    {
      title = 'LSP Overview & gr* Prefix',
      content = [[
# LSP (Language Server Protocol)

LSP provides intelligent code features:
- Go to definition
- Find references
- Rename symbols
- Code actions
- Type information
- And more!

## The gr* Prefix

Your config uses `gr*` prefix for LSP navigation:

**Most Important:**
- `grd` → [G]o to [R]eferences [D]efinition
- `grr` → [G]o to [R]eferences [R]eferences
- `grn` → [G]o to [R]eferences [N]ame (rename)
- `gra` → [G]o to [R]eferences [A]ction (code action)

**Additional Navigation:**
- `gri` → [G]o to [R]eferences [I]mplementation
- `grD` → [G]o to [R]eferences [D]eclaration
- `grt` → [G]o to [R]eferences [T]ype definition

**Document/Workspace Symbols:**
- `gO` → [G]o to document [O]utline (symbols)
- `gW` → [G]o to [W]orkspace symbols

**Other:**
- `<leader>th` → [T]oggle inlay [H]ints

## Why "gr" Prefix?

- `g` is Vim's "go" prefix for navigation
- `r` stands for "references" or "refactor"
- Mnemonic and consistent
- Keeps hands on home row

## LSP vs Text Search

LSP is language-aware:
- Understands code structure
- Finds exact symbols, not text matches
- Works across renamed symbols
- Type-safe navigation

Text search (Telescope) is simpler:
- Just finds text
- Works everywhere
- No language setup needed

Use LSP for code navigation, text search for general searching.
      ]],
      practice = {
        type = 'reference',
        instructions = [[
Practice basic LSP navigation:

1. Open a code file
2. Put cursor on a function name
3. Try grd to go to its definition
4. Try grr to find all references
5. Put cursor on a variable
6. Try grn to rename it (Esc to cancel)

LSP makes code navigation effortless!
        ]],
        hints = {
          'gr* is the LSP prefix',
          'grd = definition, grr = references',
          'grn = rename, gra = code action',
          'Language-aware, not just text search',
        },
      },
    },

    {
      title = 'Go to Definition',
      content = [[
# Go to Definition

Jump to where symbol is defined:

- `grd` → [G]o to [R]eferences [D]efinition

## How It Works

LSP finds the actual definition of:
- Functions
- Variables
- Classes
- Types
- Constants
- etc.

## Usage

1. Put cursor on symbol (function call, variable, etc.)
2. Press `grd`
3. Jump to definition (even in different file)

## Example

You see:
```javascript
const result = calculateSum(a, b);
```

Cursor on `calculateSum`, press `grd`:
→ Jumps to function definition, could be anywhere in project

## Multi-Definition Handling

If multiple definitions exist (rare):
- Opens list to choose from
- Use Telescope/quickfix to select

## Return to Previous Location

After jumping:
- `Ctrl-o` → Go back (jump list)
- `Ctrl-i` → Go forward

## Compared to Other "Go To" Commands

- `grd` → Definition (where it's defined)
- `grD` → Declaration (e.g., header file in C/C++)
- `gri` → Implementation (interface → concrete class)
- `grt` → Type definition (variable → its type)

## Pro Tips

- Most commonly used LSP feature
- Works across files seamlessly
- Respects language semantics (not just text)
- Combine with Ctrl-o to explore and return
      ]],
      practice = {
        type = 'reference',
        instructions = [[
Practice go to definition:

1. Open a file that calls functions/uses variables
2. Put cursor on a function name
3. Press grd to jump to definition
4. Press Ctrl-o to go back
5. Try on different symbols:
   - Function calls
   - Variable references
   - Class names
   - Import statements

This becomes muscle memory quickly!
        ]],
        hints = {
          'grd jumps to definition',
          'Works across files',
          'Ctrl-o returns to previous location',
          'Most-used LSP feature',
        },
      },
    },

    {
      title = 'Find References',
      content = [[
# Find References

Find all uses of a symbol:

- `grr` → [G]o to [R]eferences [R]eferences

## How It Works

LSP finds every place the symbol is used:
- Function calls
- Variable reads/writes
- Class instantiations
- Type usages

## Usage

1. Put cursor on symbol definition or usage
2. Press `grr`
3. See list of all references (Telescope)
4. Navigate and jump to any reference

## Example

You have a function:
```javascript
function calculateSum(a, b) {
  return a + b;
}
```

Cursor on `calculateSum`, press `grr`:
→ Shows all places in project where this function is called

## References vs Definition

- `grd` → Go to where it's DEFINED
- `grr` → Find where it's USED

## Use Cases

1. **Understand usage** → "Where is this function called?"
2. **Refactoring** → "What will break if I change this?"
3. **Impact analysis** → "How widely is this used?"
4. **Code review** → "Who calls this deprecated function?"

## Results View

Opens in Telescope showing:
- File path
- Line number
- Code snippet with context
- Navigate with Ctrl-n/Ctrl-p, open with Enter

## Pro Tips

- Includes definition itself in results
- Shows read vs write references (some LSPs)
- Works on any symbol: functions, variables, types
- Combine with rename for safe refactoring
      ]],
      practice = {
        type = 'reference',
        instructions = [[
Practice finding references:

1. Open a file with a function
2. Put cursor on function name
3. Press grr to see all references
4. Explore the results in Telescope
5. Jump to a reference with Enter
6. Try on variables and classes too

Great for understanding code flow!
        ]],
        hints = {
          'grr finds all references',
          'Shows where symbol is used',
          'Opposite of grd (definition)',
          'Invaluable for refactoring',
        },
      },
    },

    {
      title = 'Rename Symbol',
      content = [[
# Rename Symbol

Safely rename across entire project:

- `grn` → [G]o to [R]eferences [N]ame (rename)

## How It Works

LSP renames symbol everywhere it's used:
- Finds all references (like `grr`)
- Renames them all simultaneously
- Updates all files
- Language-aware (won't rename unrelated text)

## Usage

1. Put cursor on symbol (variable, function, etc.)
2. Press `grn`
3. Type new name
4. Press Enter to apply (or Esc to cancel)

## Example

You have:
```javascript
let userName = "John";
console.log(userName);
```

Cursor on `userName`, press `grn`:
- Prompt: "New name: userName"
- Type: `userFullName`
- Press Enter
- BOTH lines updated automatically

## Safety

LSP rename is SAFE because:
- Only renames the specific symbol
- Won't rename similar text in comments/strings (usually)
- Scoped correctly (local vs global)
- Updates across multiple files

## Comparison to Find/Replace

Find/replace: `:%s/userName/userFullName/g`
- Renames ALL occurrences of text
- No semantic understanding
- Can break unrelated code

LSP rename (`grn`):
- Only renames the symbol
- Understands scope
- Safe and precise

## Undoing Renames

Renamed wrong thing?
- `u` → Undo (in each affected buffer)
- Or use git to revert

## Pro Tips

- Preview changes before applying (some LSPs show diff)
- Works across multiple files seamlessly
- Essential for refactoring
- Much safer than manual find/replace
      ]],
      practice = {
        type = 'reference',
        instructions = [[
Practice renaming:

1. Open a file with a variable
2. Put cursor on variable name
3. Press grn
4. Type a new name
5. See preview (if available)
6. Press Enter to apply
7. Undo with u if needed
8. Check multiple files were updated

Renaming is a superpower with LSP!
        ]],
        hints = {
          'grn renames symbol everywhere',
          'Language-aware and safe',
          'Works across multiple files',
          'Much better than find/replace',
        },
      },
    },

    {
      title = 'Code Actions',
      content = [[
# Code Actions

Apply fixes and refactorings:

- `gra` → [G]o to [R]eferences [A]ction

## What Are Code Actions?

LSP-provided quick fixes and refactorings:

**Quick Fixes:**
- Import missing module
- Add missing type annotation
- Implement interface methods
- Fix spelling in variable names

**Refactorings:**
- Extract to function
- Extract to variable
- Inline variable
- Convert to arrow function
- Add explicit type
- Generate constructors
- Organize imports

## Usage

1. Put cursor on code (often on diagnostic)
2. Press `gra`
3. See list of available actions
4. Select and apply

## Example - Import

You have:
```typescript
const result = calculateSum(1, 2);  // Error: 'calculateSum' not found
```

Cursor on error, press `gra`:
- "Import calculateSum from './utils'"
- "Add declaration for calculateSum"

Select import → automatically adds import statement!

## Example - Refactoring

You have:
```javascript
const x = 5 * 5;
```

Cursor on `5 * 5`, press `gra`:
- "Extract to constant"

Select → creates:
```javascript
const value = 5 * 5;
const x = value;
```

## When to Use

- On diagnostics (errors/warnings) → Quick fixes
- On selected code → Refactoring options
- Generally explore available actions

## Visual Mode Code Actions

Select code in visual mode:
1. Select code (`v` mode)
2. Press `gra`
3. See refactoring options for selection

## Pro Tips

- Try `gra` often - discover what's available
- Some actions only appear on diagnostics
- Language-specific actions vary
- Great for auto-fixing common issues
      ]],
      practice = {
        type = 'reference',
        instructions = [[
Practice code actions:

1. Open a file with an error/warning
2. Put cursor on the diagnostic
3. Press gra
4. See available quick fixes
5. Try on different code
6. Explore refactoring options

Code actions are powerful - use them!
        ]],
        hints = {
          'gra shows available code actions',
          'Quick fixes on diagnostics',
          'Refactorings on code',
          'Language-specific actions',
        },
      },
    },

    {
      title = 'Other LSP Navigation',
      content = [[
# Additional LSP Navigation

More specialized navigation:

## Implementation

- `gri` → [G]o to [R]eferences [I]mplementation

Go to implementation of interface/abstract class.

Example (TypeScript):
```typescript
interface Drawable {
  draw(): void;
}
```

Cursor on `Drawable`, press `gri`:
→ Shows all classes implementing this interface

## Declaration

- `grD` → [G]o to [R]eferences [D]eclaration

Go to declaration (mainly for C/C++):
- Function declaration (header file)
- vs definition (implementation file)

For most languages, same as `grd`.

## Type Definition

- `grt` → [G]o to [R]eferences [T]ype

Go to type definition of variable/expression.

Example (TypeScript):
```typescript
const user = getUser();  // user is type User
```

Cursor on `user`, press `grt`:
→ Jumps to `interface User { ... }` definition

## Document Symbols

- `gO` → [G]o to document [O]utline

List all symbols in current file:
- Functions
- Classes
- Variables
- etc.

Uses Telescope for fuzzy finding.
Great for navigating large files.

## Workspace Symbols

- `gW` → [G]o to [W]orkspace symbols

Search for symbols across entire workspace.

Example:
Press `gW`, type "User":
→ Shows all classes/interfaces/types named User across project

## Inlay Hints

- `<leader>th` → [T]oggle inlay [H]ints

Toggle inline type hints (if supported by LSP):
- Parameter names in function calls
- Inferred types
- Return types

Useful for understanding code, can be noisy.

## Pro Tips

- `gO` is great for navigating unfamiliar files
- `gW` for finding symbols across project
- `grt` useful in dynamically typed languages
- Inlay hints help learning APIs
      ]],
      practice = {
        type = 'reference',
        instructions = [[
Practice other LSP navigation:

1. Press gO to see document symbols
2. Navigate and jump to a symbol
3. Try gW to search workspace symbols
4. Put cursor on variable, press grt for type
5. Try <leader>th to toggle inlay hints

Each has its use case!
        ]],
        hints = {
          'gO lists document symbols',
          'gW searches workspace symbols',
          'grt goes to type definition',
          'gri finds implementations',
        },
      },
    },
  },
}
