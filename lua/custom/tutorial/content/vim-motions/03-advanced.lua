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
        type = 'interactive',
        instructions = 'Record a macro and apply it to multiple lines.',
        initial_content = {
          '──── Macro Practice ────',
          '',
          'apple',
          'banana',
          'cherry',
          'date',
          '',
          'Instructions:',
          'Record a macro to add "- " at the start of each line',
          'Then apply it to all fruit lines above',
          '',
          '───────────────────────',
        },
        tasks = {
          {
            instruction = [[Step 1: Record a macro to add "- " prefix

We'll record a macro that:
1. Goes to start of line (0)
2. Inserts "- " (I- <space><Esc>)
3. Moves to next line (j)

Position on line 3 (apple), then:
1. Press qa (start recording into register 'a')
2. Press 0 (go to line start)
3. Press I (insert at start)
4. Type: - <space>
5. Press Esc
6. Press j (move to next line)
7. Press q (stop recording)

The line should now read: "- apple"
Press 'v' to verify.]],
            hint = 'qa 0 I- <space> <Esc> j q',
            validate = function()
              local validator = require('custom.tutorial.ui.practice-validator').validators
              return validator.lines_with_feedback({
                { line = 3, expected = '- apple' },
              })
            end,
          },
          {
            instruction = [[Step 2: Play the macro with '@a'

Now use the macro on the next line!
You should be on line 4 (banana).

1. Press @a (play macro from register 'a')

The line should become: "- banana"
Press 'v' to check.]],
            hint = 'Press: @a',
            validate = function()
              local validator = require('custom.tutorial.ui.practice-validator').validators
              return validator.lines_with_feedback({
                { line = 4, expected = '- banana' },
              })
            end,
          },
          {
            instruction = [[Step 3: Replay with '@@'

The @@ command replays the last macro.
You should be on line 5 (cherry).

1. Press @@ (replay last macro)

The line should become: "- cherry"
Press 'v' to verify.]],
            hint = 'Press: @@',
            validate = function()
              local validator = require('custom.tutorial.ui.practice-validator').validators
              return validator.lines_with_feedback({
                { line = 5, expected = '- cherry' },
              })
            end,
          },
          {
            instruction = [[Step 4: Apply to last line

One more time! You should be on line 6 (date).

1. Press @@ or @a

The line should become: "- date"
Press 'v' to check. Excellent work with macros!]],
            hint = 'Press: @@ or @a',
            validate = function()
              local validator = require('custom.tutorial.ui.practice-validator').validators
              return validator.lines_with_feedback({
                { line = 6, expected = '- date' },
              })
            end,
          },
        },
        hints = {
          'q{letter} starts recording, q stops',
          '@{letter} plays the macro',
          '@@ replays last macro',
          'Make macros repeatable: end with j or w',
          ':reg a shows macro content',
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
        type = 'interactive',
        instructions = 'Practice yanking to named registers and pasting from them.',
        initial_content = {
          '──── Register Practice ────',
          '',
          'TEXT A: Yank this to register a',
          'TEXT B: Yank this to register b',
          '',
          'Paste line A below:',
          '',
          '',
          'Paste line B below:',
          '',
          '',
          '───────────────────────────',
        },
        tasks = {
          {
            instruction = [[Step 1: Yank line to register 'a'

Position your cursor on line 3 (TEXT A).

1. Navigate to line 3
2. Press "ayy (quote, then a, then yy)

This yanks the entire line to register 'a'.
You won't see any visual change yet.
Press 'v' when ready.]],
            hint = 'Line 3, then: "ayy',
            validate = function()
              -- We can't easily validate the register content directly,
              -- so we just check they're on the right line
              local pos = vim.api.nvim_win_get_cursor(0)
              return pos[1] == 3
            end,
          },
          {
            instruction = [[Step 2: Yank line to register 'b'

Position your cursor on line 4 (TEXT B).

1. Navigate to line 4
2. Press "byy

This yanks the line to register 'b'.
Press 'v' to continue.]],
            hint = 'Line 4, then: "byy',
            validate = function()
              local pos = vim.api.nvim_win_get_cursor(0)
              return pos[1] == 4
            end,
          },
          {
            instruction = [[Step 3: Paste from register 'a'

Navigate to line 7 (the empty line after "Paste line A below:").

1. Go to line 7
2. Press "ap (quote, then a, then p)

This pastes the content from register 'a'.
The line should now show: TEXT A: Yank this to register a
Press 'v' to verify.]],
            hint = 'Line 7, then: "ap',
            validate = function()
              local validator = require('custom.tutorial.ui.practice-validator').validators
              return validator.lines_with_feedback({
                { line = 7, expected = 'TEXT A: Yank this to register a' },
              })
            end,
          },
          {
            instruction = [[Step 4: Paste from register 'b'

Navigate to line 10 (the empty line after "Paste line B below:").

1. Go to line 10
2. Press "bp

This pastes from register 'b'.
The line should show: TEXT B: Yank this to register b
Press 'v' to check. Excellent work with registers!]],
            hint = 'Line 10, then: "bp',
            validate = function()
              local validator = require('custom.tutorial.ui.practice-validator').validators
              return validator.lines_with_feedback({
                { line = 10, expected = 'TEXT B: Yank this to register b' },
              })
            end,
          },
        },
        hints = {
          '"{letter}yy yanks to that register',
          '"{letter}p pastes from that register',
          ':reg shows all registers',
          'Registers let you juggle multiple yanks',
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
        type = 'interactive',
        instructions = 'Make changes and navigate through change list with g; and g,',
        initial_content = {
          '──── Change List Navigation ────',
          '',
          'Line 3: Make a change here',
          '',
          'Some content',
          'More content',
          '',
          'Line 8: Make another change here',
          '',
          'Additional content',
          '',
          'Line 12: Make a third change here',
          '',
          'After making changes, use g; and g, to navigate',
          '',
          '────────────────────────────────',
        },
        tasks = {
          {
            instruction = [[Step 1: Make a change on line 3

Navigate to line 3 and make a small change to create a change entry.

1. Go to line 3 (3G)
2. Press A to append at end of line
3. Type: EDIT1
4. Press Esc

This creates your first change entry.
Press 'v' when ready.]],
            hint = '3G, then: A type EDIT1 <Esc>',
            validate = function()
              local validator = require('custom.tutorial.ui.practice-validator').validators
              return validator.lines_with_feedback({
                { line = 3, expected = 'Line 3: Make a change here EDIT1' },
              })
            end,
          },
          {
            instruction = [[Step 2: Make a change on line 8

Navigate to line 8 and make another change.

1. Go to line 8 (8G)
2. Press A
3. Type: EDIT2
4. Press Esc

This is your second change.
Press 'v' to continue.]],
            hint = '8G, then: A type EDIT2 <Esc>',
            validate = function()
              local validator = require('custom.tutorial.ui.practice-validator').validators
              return validator.lines_with_feedback({
                { line = 8, expected = 'Line 8: Make another change here EDIT2' },
              })
            end,
          },
          {
            instruction = [[Step 3: Make a change on line 12

Make a third change on line 12.

1. Go to line 12 (12G)
2. Press A
3. Type: EDIT3
4. Press Esc

Now you have 3 changes in the change list!
Press 'v' when ready.]],
            hint = '12G, then: A type EDIT3 <Esc>',
            validate = function()
              local validator = require('custom.tutorial.ui.practice-validator').validators
              return validator.lines_with_feedback({
                { line = 12, expected = 'Line 12: Make a third change here EDIT3' },
              })
            end,
          },
          {
            instruction = [[Step 4: Navigate back with 'g;'

You're currently on line 12 (your last change).
Press g; to jump to the PREVIOUS change location.

1. Press g;

You should jump to line 8 (where you made EDIT2).
Press 'v' to verify you're on line 8.]],
            hint = 'Press: g;',
            validate = function()
              local pos = vim.api.nvim_win_get_cursor(0)
              return pos[1] == 8
            end,
          },
          {
            instruction = [[Step 5: Continue backward with 'g;'

Press g; again to go to the change before that.

You should jump to line 3 (EDIT1).
Press 'v' to check. Great work mastering change navigation!]],
            hint = 'Press: g; again',
            validate = function()
              local pos = vim.api.nvim_win_get_cursor(0)
              return pos[1] == 3
            end,
          },
        },
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
        initial_content = {
          '──── Visual Block Practice ────',
          '',
          'apple',
          'banana',
          'cherry',
          'date',
          '',
          'const x = 1;',
          'const y = 2;',
          'const z = 3;',
          '',
          'function first() {}',
          'function second() {}',
          'function third() {}',
          '',
          '────────────────────────────────',
        },
        tasks = {
          {
            instruction = [[Step 1: Add '# ' to the fruit lines using visual block mode

Position your cursor on line 3 (apple).
1. Press Ctrl-v to start visual block selection
2. Press jjj to select 4 lines (apple through date)
3. Press I to insert at the beginning
4. Type '# ' (hash and space)
5. Press Esc to apply to all lines

All four fruit lines should now start with '# '.
Press 'v' to verify.]],
            hint = 'Ctrl-v to start, jjj to select, I# <space><Esc>',
            validate = function()
              local validator = require('custom.tutorial.ui.practice-validator').validators
              return validator.lines_with_feedback({
                { line = 3, expected = '# apple' },
                { line = 4, expected = '# banana' },
                { line = 5, expected = '# cherry' },
                { line = 6, expected = '# date' },
              })
            end,
          },
          {
            instruction = [[Step 2: Add comments to function definitions

Position your cursor at line 12 (function first).
1. Press 0 to go to the start of the line
2. Press Ctrl-v to start block selection
3. Press jj to select 3 function lines
4. Press I to insert at start
5. Type '// ' (two slashes and space)
6. Press Esc

The three function lines should now start with '// '.
Press 'v' to check.]],
            hint = 'Start at line 12, then: Ctrl-v jj I// <Esc>',
            validate = function()
              local validator = require('custom.tutorial.ui.practice-validator').validators
              return validator.lines_with_feedback({
                { line = 12, expected = '// function first() {}' },
                { line = 13, expected = '// function second() {}' },
                { line = 14, expected = '// function third() {}' },
              })
            end,
          },
          {
            instruction = [[Step 3: Delete the 'const ' column

Position cursor at the 'c' in 'const' on line 8.
1. Press Ctrl-v to start block mode
2. Press jj to select 3 lines
3. Press 5l to extend right 6 characters (to include 'const ')
4. Press x or d to delete the selected block

The lines should now read 'x = 1;', 'y = 2;', 'z = 3;'.
Press 'v' to verify.]],
            hint = 'Position on "c" of const, then: Ctrl-v jj 5l d',
            validate = function()
              local validator = require('custom.tutorial.ui.practice-validator').validators
              return validator.lines_with_feedback({
                { line = 8, expected = 'x = 1;' },
                { line = 9, expected = 'y = 2;' },
                { line = 10, expected = 'z = 3;' },
              })
            end,
          },
        },
        hints = {
          'Ctrl-v starts visual block mode',
          'I inserts at start of all selected lines',
          'A appends at end of all selected lines',
          'd or x deletes the selected block',
          'Great for editing columns, adding comments',
        },
      },
    },

    -- Lesson 5: Advanced Text Objects
    {
      title = 'Mini.ai Text Objects - Advanced Selection',
      content = [[
# Advanced Text Objects with mini.ai

Your config may have mini.ai plugin which enhances text objects:

## Enhanced Text Objects

Standard plus additional (if mini.ai is installed):
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

Note: This lesson practices standard text objects which work without mini.ai
      ]],
      practice = {
        type = 'interactive',
        instructions = 'Practice text objects (works with or without mini.ai plugin).',
        initial_content = {
          '──── Advanced Text Objects ────',
          '',
          'Test standard text objects:',
          'word1 word2 word3 word4',
          '',
          'Change "this text" to something new',
          '',
          'function (param) { code }',
          '',
          'const array = [item1, item2];',
          '',
          '───────────────────────────────',
        },
        tasks = {
          {
            instruction = [[Step 1: Delete around a word with 'daw'

Position your cursor on "word2" in line 4.

1. Move cursor anywhere on "word2"
2. Press daw (delete around word)

The line should become: "word1 word3 word4"
(Note: daw includes the trailing space)
Press 'v' to verify.]],
            hint = 'Cursor on "word2", then: daw',
            validate = function()
              local validator = require('custom.tutorial.ui.practice-validator').validators
              return validator.lines_with_feedback({
                { line = 4, expected = 'word1 word3 word4' },
              })
            end,
          },
          {
            instruction = [[Step 2: Change inside quotes with 'ci"'

Position your cursor anywhere inside the quotes on line 6.

1. Cursor anywhere between the quotes
2. Press ci"
3. Type: updated
4. Press Esc

The line should read: Change "updated" to something new
Press 'v' to check.]],
            hint = 'Cursor in quotes, then: ci" type text <Esc>',
            validate = function()
              local validator = require('custom.tutorial.ui.practice-validator').validators
              return validator.lines_with_feedback({
                { line = 6, expected = 'Change "updated" to something new' },
              })
            end,
          },
          {
            instruction = [[Step 3: Delete inside parentheses with 'di('

Position your cursor anywhere inside the parentheses on line 8.

1. Cursor anywhere inside ( )
2. Press di( or di)

The function should become: function () { code }
Press 'v' to verify.]],
            hint = 'Cursor in parens, then: di(',
            validate = function()
              local validator = require('custom.tutorial.ui.practice-validator').validators
              return validator.lines_with_feedback({
                { line = 8, expected = 'function () { code }' },
              })
            end,
          },
          {
            instruction = [[Step 4: Delete inside brackets with 'di['

Position your cursor anywhere inside the square brackets on line 10.

1. Cursor anywhere inside [ ]
2. Press di[

The line should become: const array = [];
Press 'v' to check. Great work!]],
            hint = 'Cursor in brackets, then: di[',
            validate = function()
              local validator = require('custom.tutorial.ui.practice-validator').validators
              return validator.lines_with_feedback({
                { line = 10, expected = 'const array = [];' },
              })
            end,
          },
        },
        hints = {
          'Standard text objects work everywhere',
          'mini.ai adds "next" and "last" variants (if installed)',
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
        initial_content = {
          '──── Motion Composition Practice ────',
          '',
          'The quick brown fox jumps over lazy dog',
          '',
          'Replace: "old text" should become "new text"',
          '',
          'delete_this_word and keep the rest',
          '',
          'MAKE THIS lowercase',
          '',
          'const value = "change me";',
          '',
          '──────────────────────────────────────',
        },
        tasks = {
          {
            instruction = [[Step 1: Delete a word using 'daw'

Position your cursor anywhere on the word "quick" in line 3.
1. Press daw (delete a word - includes trailing space)

The line should now read: "The brown fox jumps over lazy dog"
Press 'v' to verify.]],
            hint = 'Position cursor on "quick", then press: daw',
            validate = function()
              local validator = require('custom.tutorial.ui.practice-validator').validators
              return validator.lines_with_feedback({
                { line = 3, expected = 'The brown fox jumps over lazy dog' },
              })
            end,
          },
          {
            instruction = [[Step 2: Change text inside quotes using 'ci"'

Position your cursor anywhere inside the quotes on line 5.
1. Press ci" (change inside quotes)
2. Type: new text
3. Press Esc

The line should now read: Replace: "new text" should become "new text"
Press 'v' to verify.]],
            hint = 'Cursor in quotes, then: ci" type "new text" <Esc>',
            validate = function()
              local validator = require('custom.tutorial.ui.practice-validator').validators
              return validator.lines_with_feedback({
                { line = 5, expected = 'Replace: "new text" should become "new text"' },
              })
            end,
          },
          {
            instruction = [[Step 3: Delete to end of line using 'd$' or 'D'

Position your cursor on the underscore after "delete" in line 7.
1. Press d$ (or just D)

The line should now read: "delete"
Press 'v' to verify.]],
            hint = 'Position on "_", then press: d$ (or D)',
            validate = function()
              local validator = require('custom.tutorial.ui.practice-validator').validators
              return validator.lines_with_feedback({
                { line = 7, expected = 'delete' },
              })
            end,
          },
          {
            instruction = [[Step 4: Lowercase a word using 'guaw'

Position your cursor anywhere on "MAKE" in line 9.
1. Press guaw (lowercase around word)

The line should now read: "make THIS lowercase"
Press 'v' to check.]],
            hint = 'Cursor on "MAKE", then: guaw',
            validate = function()
              local validator = require('custom.tutorial.ui.practice-validator').validators
              return validator.lines_with_feedback({
                { line = 9, expected = 'make THIS lowercase' },
              })
            end,
          },
          {
            instruction = [[Step 5: Delete inside quotes and type new text

Position cursor anywhere inside the quotes in line 11 ("change me").
1. Press ci" (change inside quotes)
2. Type: updated
3. Press Esc

The line should read: const value = "updated";
Press 'v' to verify. Great job!]],
            hint = 'Cursor in quotes, then: ci" type "updated" <Esc>',
            validate = function()
              local validator = require('custom.tutorial.ui.practice-validator').validators
              return validator.lines_with_feedback({
                { line = 11, expected = 'const value = "updated";' },
              })
            end,
          },
        },
        hints = {
          'Operator + motion = powerful editing',
          'd2w deletes 2 words, c$ changes to end',
          'Text objects: diw, ci", ya), vi{',
          'gu = lowercase, gU = uppercase',
          'Think in grammar: verb + noun',
        },
      },
    },
  },
}
