-- Debug Keybindings Tutorial
-- DAP (Debug Adapter Protocol) for debugging code

return {
  metadata = {
    id = 'keybindings-debug',
    title = 'Debugging with DAP',
    category = 'keybindings',
    difficulty = 'intermediate',
    estimated_time = '15 minutes',
    prerequisites = {},
    description = 'Learn debugging keybindings: breakpoints, stepping, continue, and debug UI',
  },

  lessons = {
    {
      title = 'Debug Overview',
      content = [[
# DAP (Debug Adapter Protocol)

Debug your code directly in Neovim!

Your config uses nvim-dap with these keybindings:

**Start/Control:**
- `F5` → Debug: Start/Continue
- `F7` → Debug: Toggle UI

**Stepping:**
- `F1` → Step Into
- `F2` → Step Over
- `F3` → Step Out

**Breakpoints:**
- `<leader>b` → Toggle breakpoint
- `<leader>B` → Set conditional breakpoint

**Stop:**
- `F6` → Terminate debug session (C/C++ specific)

## Debug Workflow

1. Set breakpoints (`<leader>b`)
2. Start debugging (`F5`)
3. Step through code (`F1`, `F2`, `F3`)
4. Inspect variables (debug UI)
5. Continue to next breakpoint (`F5`)
6. Stop debugging (`F6` or debug stop command)

## Debug UI

When debugging starts:
- Variables window (local/global vars)
- Call stack window
- Breakpoints list
- REPL console (evaluate expressions)

Toggle with `F7`.

## DAP vs Print Debugging

Print debugging:
```javascript
console.log("value:", value);
```

DAP debugging:
- Set breakpoint
- Inspect ALL variables
- Step through execution
- Evaluate expressions on the fly
- No code changes needed

Much more powerful!

## Pro Tips

- Learn F-key positions (muscle memory)
- Keep debug UI visible while stepping
- Use conditional breakpoints to stop only when needed
- REPL console for quick expression evaluation
      ]],
      practice = {
        type = 'reference',
        instructions = [[
Practice debug basics:

1. Open a code file (JS, Python, etc.)
2. Set a breakpoint: Space + b
3. Start debugging: F5
4. See breakpoint hit
5. Toggle UI: F7
6. Inspect variables in UI
7. Stop debug session

Get familiar with the F-keys!
        ]],
        hints = {
          'F5 starts/continues debugging',
          'Space + b sets breakpoint',
          'F7 toggles debug UI',
          'Much more powerful than print debugging',
        },
      },
    },

    {
      title = 'Breakpoints',
      content = [[
# Breakpoints

Pause execution at specific lines:

**Toggle Breakpoint:**
- `<leader>b` → Toggle breakpoint on current line

**Conditional Breakpoint:**
- `<leader>B` → Set conditional breakpoint

## Regular Breakpoint

Simple pause point in code.

Usage:
1. Put cursor on line you want to pause at
2. Press `Space` + `b`
3. See breakpoint indicator (red dot, icon, or highlight)
4. Start debugging with `F5`
5. Code pauses when that line is reached

## Conditional Breakpoint

Only pause when condition is true.

Example:
```javascript
for (let i = 0; i < 100; i++) {
  processItem(i);  // Only want to debug when i == 50
}
```

Usage:
1. Put cursor on line
2. Press `Space` + `B` (capital B)
3. Enter condition: `i == 50`
4. Breakpoint only triggers when condition is true

Very useful for loops!

## Managing Breakpoints

- Toggle same breakpoint to remove it
- Set multiple breakpoints across files
- Breakpoints list in debug UI shows all breakpoints
- Clear all breakpoints (via DAP commands)

## Breakpoint Symbols

You'll see indicators:
- Line highlight (red/orange background)
- Sign in gutter (•, B, or custom icon)
- Listed in breakpoints pane of debug UI

## Use Cases

**Regular breakpoints:**
- Start of function
- Before/after critical operation
- Where bug likely occurs

**Conditional breakpoints:**
- Inside loops (only trigger for specific iteration)
- Only when variable has certain value
- Edge cases (null, zero, etc.)

## Pro Tips

- Set multiple breakpoints to trace execution flow
- Use conditional breakpoints to avoid stopping 100 times
- Remove breakpoints you don't need anymore
- Breakpoints persist in session (some configs save them)
      ]],
      practice = {
        type = 'reference',
        instructions = [[
Practice breakpoints:

1. Space + b to set a breakpoint
2. See the breakpoint indicator
3. Space + b again to remove it
4. Set it again
5. Add another breakpoint elsewhere
6. Try Space + B for conditional breakpoint
7. Enter a condition like "x > 10"

Breakpoints are essential for debugging!
        ]],
        hints = {
          'Space + b toggles breakpoint',
          'Space + B sets conditional breakpoint',
          'See indicators in gutter/line',
          'Can set multiple across files',
        },
      },
    },

    {
      title = 'Start and Continue',
      content = [[
# Start and Continue Debugging

Begin and control debug session:

- `F5` → Debug: Start/Continue

## Starting Debug Session

When no debug session is active:
- Press `F5`
- Starts debugging current file/project
- Runs until first breakpoint or end

## Configuration Required

DAP needs debug configuration:
- Launch configurations define how to start
- Usually in `.vscode/launch.json` or nvim-dap setup
- Your config likely has some languages pre-configured

## Continuing Execution

When paused at breakpoint:
- Press `F5` again
- Continues execution
- Runs until next breakpoint or end

## Start vs Continue

Same key (`F5`), different context:
- No session → **Start** debugging
- Paused at breakpoint → **Continue** execution

Like "Run" button in GUI debuggers.

## Typical Workflow

```
1. Set breakpoints
2. F5 (start)
3. Code runs, hits first breakpoint
4. Inspect variables
5. F5 (continue)
6. Hits next breakpoint
7. Repeat...
```

## When Nothing Happens

If F5 doesn't work:
- May need debug configuration
- Check DAP setup for your language
- See `:DapShowLog` for errors
- Ensure debug adapter installed (Mason)

## Pro Tips

- Set breakpoint before starting, or code runs to completion
- F5 is most-used debug key (start and continue)
- Can start debugging from any file in project
- Some languages auto-detect how to start
      ]],
      practice = {
        type = 'reference',
        instructions = [[
Practice start/continue:

1. Set a breakpoint
2. Press F5 to start debugging
3. See execution pause at breakpoint
4. Press F5 again to continue
5. Set another breakpoint
6. F5 continues to next breakpoint

F5 becomes muscle memory!
        ]],
        hints = {
          'F5 starts debugging (no session)',
          'F5 continues (when paused)',
          'Same key, different contexts',
          'Most frequently used debug key',
        },
      },
    },

    {
      title = 'Stepping Through Code',
      content = [[
# Stepping Through Code

Execute code line by line:

- `F1` → Step Into
- `F2` → Step Over
- `F3` → Step Out

## Step Over (F2)

Execute current line, don't enter functions.

Example:
```javascript
const result = calculateSum(a, b);  // ← cursor here
console.log(result);
```

Press F2:
- Executes `calculateSum` (doesn't go inside)
- Moves to `console.log` line

Use when: You trust the function, just want to go to next line.

## Step Into (F1)

Execute current line, enter functions.

Example:
```javascript
const result = calculateSum(a, b);  // ← cursor here
```

Press F1:
- Goes INSIDE `calculateSum` function
- Stops at first line of that function

Use when: You want to debug inside the function.

## Step Out (F3)

Finish current function, return to caller.

Example:
```javascript
function calculateSum(a, b) {
  const sum = a + b;        // ← currently here
  return sum;
}
```

Press F3:
- Executes rest of function
- Returns to caller
- Stops after function call

Use when: You're inside a function but want to get back out.

## Stepping Strategy

**Exploring new code:**
- Step Over (F2) to see flow
- Step Into (F1) when you hit interesting function

**Debugging specific function:**
- Step Into (F1) to enter it
- Step Over (F2) inside function
- Step Out (F3) when done

**Skipping boring parts:**
- Just set next breakpoint and F5 (continue)

## Pro Tips

- F2 (Step Over) is most common
- F1 (Step Into) for deep diving
- F3 (Step Out) when you've seen enough
- Watch variables change in debug UI while stepping
      ]],
      practice = {
        type = 'reference',
        instructions = [[
Practice stepping:

1. Set breakpoint at start of function
2. F5 to start debugging
3. Try F2 (Step Over) to go line by line
4. Hit a function call, try F1 (Step Into)
5. Inside function, try F3 (Step Out)
6. Experiment with different combinations

Stepping is core debugging skill!
        ]],
        hints = {
          'F2 = Step Over (don\'t enter functions)',
          'F1 = Step Into (enter functions)',
          'F3 = Step Out (finish current function)',
          'Watch variables change while stepping',
        },
      },
    },

    {
      title = 'Debug UI',
      content = [[
# Debug UI

View debug information:

- `F7` → Toggle Debug UI

## Debug UI Components

When you toggle UI (F7), you see panels:

**1. Variables**
- Local variables in current scope
- Global variables
- See values update as you step

**2. Call Stack**
- Function call hierarchy
- Current position in stack
- Click to navigate up/down stack

**3. Breakpoints**
- List of all breakpoints
- Enable/disable individual breakpoints
- See line numbers and conditions

**4. REPL (Console)**
- Evaluate expressions
- Type variable names to see values
- Execute code in current context

**5. Watches** (some configs)
- Pin variables to always show
- Track specific expressions

## Using Debug UI

**Inspect Variables:**
- See all locals without `console.log`
- Expand objects/arrays
- See types

**Navigate Call Stack:**
- Click on stack frames
- See variables at each level
- Understand how you got to current line

**Evaluate Expressions:**
- In REPL, type `user.name`
- See value immediately
- No need to modify code

## UI Layout

Your config uses nvim-dap-ui:
- Opens in splits automatically
- Can toggle with F7
- Can manually adjust split sizes

## Closing UI

- F7 again to close
- Or close windows manually (`:q`)

## Pro Tips

- Keep UI open while debugging
- REPL is powerful - use it to test expressions
- Call stack navigation essential for understanding flow
- Variables auto-update as you step - watch them change
      ]],
      practice = {
        type = 'reference',
        instructions = [[
Practice debug UI:

1. Start debug session (F5)
2. Toggle UI (F7)
3. Look at variables panel
4. Look at call stack
5. Type in REPL to evaluate expression
6. Step through code, watch variables update
7. Toggle UI off (F7)

The UI is incredibly useful!
        ]],
        hints = {
          'F7 toggles debug UI',
          'Variables panel shows all locals',
          'REPL evaluates expressions',
          'Call stack shows function hierarchy',
        },
      },
    },

    {
      title = 'Stopping Debug Session',
      content = [[
# Stopping Debug Session

End debugging:

- `F6` → Terminate (C/C++ specific in your config)
- DAP commands for other languages

## Terminate vs Disconnect

**Terminate:**
- Kills debug session
- Stops the program
- Clears debug UI

**Disconnect** (some debuggers):
- Detaches debugger
- Program keeps running

## Your Config - C/C++

Your config has F6 for C/C++ debugging:
```lua
{ '<F6>', ':DapTerminate<CR>', desc = 'Debug: Terminate' }
```

This runs `:DapTerminate` command.

## For Other Languages

Use DAP commands:
- `:DapTerminate` → Stop debug session
- Or close debug UI and it usually stops

## Alternative: Let Program Finish

Don't need to manually stop:
- Let program run to completion (F5)
- Session ends automatically
- UI closes

## When to Terminate

- Found the bug, done debugging
- Want to restart with different breakpoints
- Program in infinite loop
- Want to edit code and re-run

## Clean Exit

After terminating:
- Debug UI closes (or use F7)
- Breakpoints remain (for next session)
- Can edit code normally

## Pro Tips

- Let simple programs run to completion
- Terminate when stuck or done
- Breakpoints persist for next debug session
- Can restart debugging immediately after terminating
      ]],
      practice = {
        type = 'reference',
        instructions = [[
Practice stopping debug:

1. Start debugging (F5)
2. Let it hit a breakpoint
3. Terminate with F6 or :DapTerminate
4. See debug UI close
5. Notice breakpoints still set
6. Start again (F5) to continue debugging

Stopping and restarting is common workflow!
        ]],
        hints = {
          'F6 terminates (C/C++ in your config)',
          ':DapTerminate works for all languages',
          'Or let program run to completion',
          'Breakpoints persist after stopping',
        },
      },
    },
  },
}
