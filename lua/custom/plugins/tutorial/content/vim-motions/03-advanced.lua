-- Advanced Vim Motions Tutorial
-- Master macros, registers, and advanced editing techniques

return {
  metadata = {
    id = 'vim-motions-advanced',
    title = 'Vim Motions - Advanced',
    category = 'vim-motions',
    difficulty = 'advanced',
    estimated_time = '30 minutes',
    prerequisites = { 'vim-motions-beginner', 'vim-motions-intermediate' },
    description = 'Master macros, registers, visual block mode, and advanced motion composition',
  },

  lessons = {
    -- Lesson 1: Macros
    {
      title = 'Macros - Record and Replay Actions',
      content = [[
# Macros

Record a sequence of commands and replay them:

## Recording Macros

- `q{register}` → Start recording into {register} (a-z)
- (perform actions)
- `q` → Stop recording

## Playing Macros

- `@{register}` → Play macro from {register}
- `@@` → Replay last executed macro
- `{count}@{register}` → Repeat macro {count} times

## Example Workflow

```
qa              " Start recording into register 'a'
0               " Go to start of line
i# <Esc>        " Insert '# ' at beginning
j               " Move to next line
q               " Stop recording

5@a             " Replay macro 5 times (prefix 5 lines with '# ')
```

## Best Practices

1. Start each macro with a motion (0, ^, $)
2. End with a motion to next item (j, /pattern)
3. Use relative motions, not counts
4. Test on one item before repeating

## Recursive Macros

Macros can call themselves:
```
qa              " Start recording
(do something)
@a              " Call itself (recursive)
q               " Stop
```

Execute with: `999@a` (will stop at end of file)

## Pro Tips

- `:reg a` shows content of register a
- Edit macro: `:let @a='...'`
- Macros can use macros (call @b from within @a)
- Use `. (dot)` for simple repetition, macros for complex
      ]],
      practice = {
        type = 'reference',
        instructions = [[
Practice recording and playing macros:

1. Record a macro to add quotes around a word:
   - qa (start recording)
   - bi" (insert quote before word)
   - ea" (insert quote after word)
   - j (move to next line)
   - q (stop recording)

2. Play it: @a

3. Play it 5 times: 5@a

4. Try @@  to replay last macro

5. View your macro: :reg a
        ]],
        hints = {
          'q{letter} starts recording, q stops',
          '@{letter} plays the macro',
          '@@ replays last macro',
          'Use counts: 10@a plays macro 10 times',
          'Make macros repeatable: end with j or w',
        },
      },
    },

    -- Lesson 2: Registers
    {
      title = 'Registers - Advanced Copy/Paste',
      content = [[
# Registers

Vim has multiple clipboards called registers:

## Types of Registers

**Named Registers (a-z, A-Z)**
- `"ayy` → Yank line into register a
- `"ap` → Paste from register a
- `"Ayy` → Append to register a (uppercase)

**Numbered Registers (0-9)**
- `"0` → Last yank
- `"1-9` → Last deletes (delete history)

**Special Registers**
- `""` → Unnamed (default) register
- `"+` → System clipboard (Ctrl-C/V)
- `"*` → Selection clipboard (middle-click)
- `"%` → Current filename
- `":` → Last command
- `".` → Last inserted text
- `"/` → Last search pattern

**Read-Only Registers**
- `".` → Last insert
- `"%` → Current filename
- `":` → Last command
- `"/` → Last search

## Viewing Registers

- `:reg` → Show all registers
- `:reg a b c` → Show specific registers

## Common Workflows

Save important yanks:
```
"ayy        " Save line to register a
"byiw       " Save word to register b
"ap         " Paste from register a later
```

Access system clipboard:
```
"+yy        " Yank to system clipboard
"+p         " Paste from system clipboard
```

## Black Hole Register

- `"_d` → Delete without saving to register
- Useful when you don't want to overwrite unnamed register

## Pro Tips

- Registers persist between Vim sessions (viminfo)
- Use uppercase to append: "Ayy adds to register a
- Named registers great for cut/paste between files
      ]],
      practice = {
        type = 'reference',
        instructions = [[
Practice using registers:

1. Yank a line to register a: "ayy
2. Yank another line to register b: "byy
3. View registers: :reg
4. Paste from register a: "ap
5. Paste from register b: "bp
6. Try appending: "Ayy (uppercase A)
7. Yank to system clipboard: "+yy
8. Paste from system clipboard: "+p
        ]],
        hints = {
          '"{letter}yy yanks to that register',
          '"{letter}p pastes from that register',
          ':reg shows all registers',
          '"+ is system clipboard',
          '"_ is black hole (deletes without saving)',
        },
      },
    },

    -- Lesson 3: Complex Motions
    {
      title = 'g; g, - Change List Navigation',
      content = [[
# Change List Navigation

Vim tracks your changes:

- `g;` → Jump to previous change location
- `g,` → Jump to next change location

## Change List

Every time you make a change (insert, delete, etc.),
Vim remembers the location.

- `:changes` → Show change list

## Use Cases

1. **Navigate recent edits**
   - Made changes in different parts of file
   - Use `g;` to jump back through them

2. **Review your work**
   - After editing session, use `g;` to review changes
   - Like an "undo history navigator" without undoing

3. **Return after distraction**
   - Got sidetracked viewing something else
   - Use `g;` to return to last edit location

## Special Marks

Related to change list:
- `. → Last change position (single jump)
- `^ → Last insert position

## Pro Tips

- Change list is per-buffer
- Complements jump list (Ctrl-o/Ctrl-i)
- Great for reviewing changes before committing
      ]],
      practice = {
        type = 'reference',
        instructions = [[
Practice change list navigation:

1. Make a change at line 5
2. Make a change at line 15
3. Make a change at line 25
4. Press g; to jump to previous change (line 15)
5. Press g; again to jump to line 5
6. Press g, to jump forward to line 15
7. Use :changes to see full change list
        ]],
        hints = {
          'g; jumps to previous change',
          'g, jumps to next change',
          ':changes shows change history',
          'Different from undo - just navigation',
        },
      },
    },

    -- Lesson 4: Visual Block Mode
    {
      title = 'Ctrl-v - Visual Block Mode',
      content = [[
# Visual Block Mode

Edit columns of text simultaneously:

## Modes

- `v` → Character-wise visual
- `V` → Line-wise visual
- `Ctrl-v` → Block-wise visual

## Block Mode Basics

1. Press `Ctrl-v` to start block selection
2. Use motions (j, k, w, $) to select block
3. Perform operation (d, c, I, A, etc.)

## Special Operations

**Insert at start of block**
1. `Ctrl-v` select block
2. `I` insert at start
3. Type text
4. `Esc` to apply to all lines

**Append at end of block**
1. `Ctrl-v` select block
2. `A` append at end
3. Type text
4. `Esc` to apply to all lines

## Common Use Cases

**Add comments to multiple lines**
```
Ctrl-v jjj    " Select block (4 lines)
I// <Esc>     " Insert // at start
```

**Delete column of text**
```
Ctrl-v jjj$   " Select to end of lines
d             " Delete block
```

**Create table/align columns**
```
Ctrl-v        " Block select
I<spaces>     " Insert spaces
```

## Pro Tips

- `o` in visual mode toggles cursor corner
- `O` in block mode toggles corner horizontally/vertically
- Block mode works with operators: d, c, y
- Ragged selections (different line lengths) work fine
      ]],
      practice = {
        type = 'interactive',
        instructions = 'Use Ctrl-v to select blocks and edit multiple lines at once.',
        setup = function()
          local buf = vim.api.nvim_create_buf(false, true)
          local lines = {
            '──── Visual Block Practice ────',
            '',
            'const a = 1;',
            'const b = 2;',
            'const c = 3;',
            'const d = 4;',
            '',
            'Try: Select "const" column with Ctrl-v jjj',
            'Then press c to change, or d to delete',
            '',
            'name = "Alice"',
            'age = 30',
            'city = "NYC"',
            '',
            'Try: Add // at start using Ctrl-v jj I// Esc',
            '',
            '────────────────────────────────',
          }
          vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
          vim.bo[buf].modifiable = true
          return buf
        end,
        hints = {
          'Ctrl-v starts visual block mode',
          'I inserts at start of all selected lines',
          'A appends at end of all selected lines',
          'Great for editing columns, adding comments',
        },
      },
    },

    -- Lesson 5: Advanced Text Objects
    {
      title = 'Mini.ai Text Objects - Advanced Selection',
      content = [[
# Advanced Text Objects with mini.ai

Your config has mini.ai plugin installed, which enhances text objects:

## Enhanced Text Objects

Standard plus additional:
- `iq`, `aq` → Quote (any quote type)
- `ig`, `ag` → Entire buffer
- `i?`, `a?` → User prompt (asks for char)

## Next/Last Variants

mini.ai adds directional variants:
- `in{object}` → Next text object
- `il{object}` → Last (previous) text object
- `an{object}` → Around next
- `al{object}` → Around last

## Examples

```
dinw        " Delete in next word
cil"        " Change in last quote
vanf        " Visual around next function (treesitter)
```

## Treesitter Integration

With treesitter (you have it installed):
- `if`, `af` → Function definition
- `ic`, `ac` → Class/struct
- `ia`, `aa` → Argument/parameter

## Usage

Don't need to be inside the object:
```
diw         " Works if cursor is IN word
dinw        " Works anywhere - finds NEXT word
```

## Pro Tips

- Next/last variants are very powerful
- No need to navigate to object first
- Combine with counts: d2inw (delete in 2nd next word)
- Your mini.ai config might have custom objects
      ]],
      practice = {
        type = 'reference',
        instructions = [[
Practice mini.ai text objects:

1. Try "around" variants: daw, da", da)
2. Try "next" variants: dinw (next word)
3. Try treesitter: vaf (visual around function)
4. Explore: :h mini.ai for all objects

Note: Some objects require treesitter parser
for the current filetype.
        ]],
        hints = {
          'mini.ai enhances built-in text objects',
          'in{object} = in next, il{object} = in last',
          'Works with treesitter for code objects',
          'Very powerful for quick editing',
        },
      },
    },

    -- Lesson 6: Motion Composition
    {
      title = 'Operator + Motion - Composing Efficient Edits',
      content = [[
# Motion Composition

The real power of Vim: operators + motions

## The Formula

```
{operator}{count}{motion}
```

## Operators

- `d` → delete
- `c` → change (delete and enter insert)
- `y` → yank (copy)
- `v` → visual select
- `>`, `<` → indent
- `=` → format
- `g~` → toggle case
- `gu` → lowercase
- `gU` → uppercase

## Examples

```
d2w         " Delete 2 words
c$          " Change to end of line
y3j         " Yank current + 3 lines below
>i{         " Indent inside braces
gUaw        " Uppercase a word
gu3w        " Lowercase 3 words
=ap         " Format a paragraph
```

## Text Object Combos

```
diw         " Delete inner word
ci"         " Change inside quotes
ya)         " Yank around parentheses
vi{         " Visual select inside braces
>ap         " Indent a paragraph
```

## Efficiency Examples

Instead of:
- Delete line: `0d$` → Use `dd`
- Delete to end: `d$` → Use `D`
- Change to end: `c$` → Use `C`
- Delete char: `dl` → Use `x`
- Delete char back: `dh` → Use `X`

## The Dot Command

After an operation, `.` repeats it:
```
dw          " Delete word
.           " Delete another word
.           " And another
```

Works with any change!

## Pro Tips

- Learn operators + motions, not specific commands
- Combinations are unlimited
- Dot `.` is your best friend for repetition
- Build muscle memory for common combos:
  - `ciw` → change word
  - `di"` → delete in quotes
  - `yap` → yank paragraph
  - `>i{` → indent block
      ]],
      practice = {
        type = 'interactive',
        instructions = 'Practice composing operators with motions and text objects.',
        setup = function()
          local buf = vim.api.nvim_create_buf(false, true)
          local lines = {
            '──── Motion Composition Practice ────',
            '',
            'delete this word carefully',
            'change this entire line please',
            'yank this useful text here',
            '',
            'function example() {',
            '  const message = "hello world";',
            '  return message;',
            '}',
            '',
            'Try these combinations:',
            '• diw - delete inner word',
            '• ci" - change inside quotes',
            '• yap - yank a paragraph',
            '• >i{ - indent inside braces',
            '• gUaw - uppercase a word',
            '',
            'Practice chaining:',
            'ciw (change word) then press . on other words',
            '',
            '──────────────────────────────────────',
          }
          vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
          vim.bo[buf].modifiable = true
          return buf
        end,
        hints = {
          'Operator + motion = powerful editing',
          'd2w deletes 2 words, c$ changes to end',
          'Text objects: diw, ci", ya), vi{',
          '. (dot) repeats last change',
          'Think in grammar: verb + noun',
        },
      },
    },
  },
}
