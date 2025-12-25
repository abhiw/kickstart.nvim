-- C/C++ Specific Keybindings Tutorial
-- Language-specific compilation and debugging keybindings

return {
  metadata = {
    id = 'keybindings-cpp',
    title = 'C/C++ Development',
    category = 'keybindings',
    difficulty = 'beginner',
    estimated_time = '10 minutes',
    prerequisites = {},
    description = 'Learn C/C++ specific keybindings for compilation, running, and debugging',
  },

  lessons = {
    {
      title = 'C/C++ Overview',
      content = [[
# C/C++ Development Keybindings

Your config has special keybindings for C/C++ development:

**Compile & Run:**
- `F9` → Compile current file (with debug symbols -g)
- `F4` → Compile and run
- `<leader>r` → Run executable without recompiling

**Debug:**
- `F6` → Debug: Terminate session

## File Type Specific

These keybindings ONLY work in C/C++ files:
- `.c`, `.cpp`, `.cc`, `.cxx`, `.h`, `.hpp`

Open other file types → these keys do nothing (or default action).

## Why These Keys?

**F-keys for building:**
- F9, F4 → Classic IDE shortcuts
- Fast access without modifier keys
- Common in many C/C++ IDEs

**F6 for debug stop:**
- Complements F5 (debug start/continue)
- F1-F7 group for debug/build operations

**Leader r for run:**
- Think "[R]un"
- Doesn't recompile (faster for testing)

## Workflow

Typical C/C++ development cycle:
```
1. Edit code
2. F9 (compile with -g for debugging)
3. See errors (if any)
4. Fix errors, repeat F9
5. F4 (compile and run)
6. Test program
7. Debug if needed (F5, breakpoints, etc.)
```

## Pro Tips

- F9 vs F4: F9 just compiles, F4 compiles and runs
- Use F9 while writing, F4 when ready to test
- <leader>r is fast iteration (no recompile wait)
- Debug symbols (-g) allow debugging with nvim-dap
      ]],
      practice = {
        type = 'reference',
        instructions = [[
Practice C/C++ workflow:

1. Open a .cpp file
2. Write simple code (e.g., hello world)
3. Press F9 to compile
4. Check for errors in output
5. Press F4 to compile and run
6. See program output
7. Modify code
8. Press <leader>r to run without recompile

Build-test cycle made easy!
        ]],
        hints = {
          'F9 compiles with debug symbols',
          'F4 compiles and runs',
          '<leader>r runs without recompiling',
          'Only works in C/C++ files',
        },
      },
    },

    {
      title = 'Compile Current File (F9)',
      content = [[
# Compile Current File

Compile with debug symbols:

- `F9` → Compile current file with `-g` flag

## How It Works

Runs compiler command on current file:
```bash
g++ -g filename.cpp -o filename
```

Flags:
- `-g` → Include debug symbols (for nvim-dap debugging)
- `-o filename` → Output executable named `filename`

## Output

See compilation output in terminal:
- Errors (if any)
- Warnings
- Success message

## Errors

If compilation fails:
- Read error messages
- Line numbers shown
- Fix and press F9 again

## Success

If compilation succeeds:
- Executable created (same name as file, no extension)
- Ready to run with F4 or `<leader>r`

## Debug Symbols

The `-g` flag includes debug information:
- Allows setting breakpoints
- Step through code
- Inspect variables
- Essential for nvim-dap debugging

Without `-g`:
- Still runs fine
- But can't debug properly

## Compiler Used

Default: `g++` for C++, `gcc` for C

Your config may allow customization:
- Use clang instead
- Add optimization flags
- Custom compile commands

## Pro Tips

- Always use F9 during development (includes -g)
- Read error messages carefully (line numbers!)
- Warnings are important too (may be errors in disguise)
- Executable created in same directory as source
      ]],
      practice = {
        type = 'reference',
        instructions = [[
Practice compiling:

1. Open or create a simple .cpp file:
   ```cpp
   #include <iostream>
   int main() {
     std::cout << "Hello!" << std::endl;
     return 0;
   }
   ```
2. Press F9 to compile
3. Watch compilation output
4. Check for executable file
5. Introduce an error, press F9 again
6. See error messages

Learn to read compiler errors!
        ]],
        hints = {
          'F9 compiles with -g (debug symbols)',
          'Creates executable in same directory',
          'Shows errors/warnings',
          'Essential for debugging later',
        },
      },
    },

    {
      title = 'Compile and Run (F4)',
      content = [[
# Compile and Run

Compile and immediately execute:

- `F4` → Compile and run current file

## How It Works

Two steps automatically:
1. Compile (like F9)
2. Run the executable

## Compile Command

Same as F9:
```bash
g++ filename.cpp -o filename
```

Note: No `-g` flag (faster compilation, can't debug).

## Then Runs

After successful compilation:
```bash
./filename
```

Executes the program.

## Output

See both:
1. Compilation messages (if any errors)
2. Program output

## If Compilation Fails

- Shows error messages
- Does NOT run
- Fix errors and try again

## Use Cases

**F4 when:**
- Ready to test
- Quick feedback loop (edit, F4, see output)
- Don't need debugging

**F9 when:**
- Just want to check if it compiles
- Will debug later (need -g)
- Large program (don't want to run yet)

## Speed

F4 is fastest way to test:
- One keypress
- See output immediately
- No manual terminal commands

## Pro Tips

- F4 = quick test cycle
- If program has errors, still compiles without -g (faster)
- For debugging, use F9 first (includes -g), then debug
- Program runs in Neovim terminal (can interact if needed)
      ]],
      practice = {
        type = 'reference',
        instructions = [[
Practice compile and run:

1. Open a .cpp file with simple program
2. Press F4
3. See compilation messages
4. See program output
5. Modify code (change output message)
6. Press F4 again
7. See new output

Fast iteration!
        ]],
        hints = {
          'F4 compiles and runs in one step',
          'No -g flag (faster, but no debug info)',
          'Shows both compile and run output',
          'Fastest way to test changes',
        },
      },
    },

    {
      title = 'Run Without Recompiling',
      content = [[
# Run Executable Without Recompiling

Run existing executable:

- `<leader>r` → Run executable (no recompile)

## How It Works

Runs the executable directly:
```bash
./filename
```

Does NOT compile first.

## When to Use

**Use `<leader>r` when:**
- Already compiled (F9 or F4)
- Just want to run again
- Testing with different inputs
- Faster (skip compilation)

**Use `F4` when:**
- Made code changes
- Need to recompile first

## Speed Difference

Large programs:
- F4 → 5-10 seconds (recompile + run)
- `<leader>r` → Instant (just run)

## Multiple Runs

Testing different scenarios:
1. F9 (compile once)
2. `<leader>r` (run test case 1)
3. `<leader>r` (run test case 2)
4. `<leader>r` (run test case 3)
5. Edit code
6. F9 (recompile)
7. Repeat

## If Executable Doesn't Exist

Error message:
```
./filename: No such file or directory
```

Solution: Compile first with F9 or F4.

## Interactive Programs

If program needs input:
- Runs in terminal
- Can type input
- See output

## Pro Tips

- Think "r" for [R]un (mnemonic)
- Saves time when testing
- Great for iterative testing without code changes
- Combine with F9 for efficient workflow
      ]],
      practice = {
        type = 'reference',
        instructions = [[
Practice running:

1. Compile with F9 or F4 first
2. Press <leader>r (Space + r)
3. See program run (no recompile!)
4. Press <leader>r again
5. Runs instantly (no wait)
6. Try without compiling first
7. See error message

Understand when to compile vs just run!
        ]],
        hints = {
          '<leader>r runs without recompiling',
          'Much faster for testing',
          'Must compile first (F9/F4)',
          'Great for iterative testing',
        },
      },
    },

    {
      title = 'Debug Terminate (F6)',
      content = [[
# Debug Terminate

Stop debugging session:

- `F6` → Debug: Terminate

## C/C++ Specific

This binding is specific to C/C++ files:
- Calls `:DapTerminate`
- Stops debug session
- Closes debug UI

## When to Use

During debugging:
1. Started debugging (F5)
2. Stepping through code (F1, F2, F3)
3. Done or want to stop
4. Press F6 to terminate

## What Happens

- Debug session ends
- Program stops executing
- Debug UI closes (if open)
- Back to normal editing

## Alternative Ways to Stop

Can also use:
- `:DapTerminate` command
- Let program run to completion
- Close debug UI manually

But F6 is fastest.

## Complete Debug Workflow

```
1. Set breakpoints (<leader>b)
2. F9 (compile with -g)
3. F5 (start debugging)
4. F1/F2/F3 (step through)
5. F7 (toggle debug UI)
6. Inspect variables
7. F6 (stop debugging)
```

## Compile vs Debug Keys

**Build:**
- F9 → Compile
- F4 → Compile and run

**Debug:**
- F5 → Start/continue debug
- F1/F2/F3 → Step through
- F6 → Terminate debug
- F7 → Toggle debug UI

F1-F7 group for all build/debug operations!

## Pro Tips

- F-keys 1-7 cover all C/C++ dev operations
- Muscle memory: same position as debug IDEs
- Can restart debugging anytime (F5 again)
- F6 is quick exit from debug mode
      ]],
      practice = {
        type = 'reference',
        instructions = [[
Practice debug workflow:

1. Compile with F9
2. Set breakpoint: <leader>b
3. Start debug: F5
4. See breakpoint hit
5. Toggle UI: F7
6. Terminate: F6
7. See debug session end

Complete C/C++ debugging!
        ]],
        hints = {
          'F6 terminates debug session',
          'C/C++ specific keybinding',
          'Part of F1-F7 debug/build group',
          'Quick way to stop debugging',
        },
      },
    },

    {
      title = 'C/C++ Development Tips',
      content = [[
# C/C++ Development Best Practices

Workflow tips for efficient C/C++ development:

## Typical Workflow

**Writing new code:**
```
1. Edit → F9 → Fix errors → F9 → ...
2. When compiles clean: F4
3. Test output
4. Repeat
```

**Debugging:**
```
1. F9 (compile with -g)
2. Set breakpoints (<leader>b)
3. F5 (start debug)
4. F7 (show debug UI)
5. F1/F2/F3 (step through)
6. Fix bug
7. F6 (stop debug)
8. Repeat
```

**Quick testing:**
```
1. F9 (compile once)
2. <leader>r (test)
3. <leader>r (test again)
4. Edit
5. F9 (recompile)
6. <leader>r (test)
```

## Key Combinations

**Must know:**
- F9 → Compile check
- F4 → Quick test
- F5 + F1/F2/F3 → Debug

**Nice to have:**
- `<leader>r` → Fast iteration
- F6 → Quick debug stop
- F7 → Debug UI toggle

## Compile Errors

Read errors carefully:
- Line number → Use `{line}G` to jump
- Error message → Understand what's wrong
- Fix and F9 again

## LSP Integration

Combine with LSP for power:
- `grd` → Go to definition
- `grr` → Find references
- `gra` → Code actions (e.g., add include)
- F9 → Compile to verify

## File Organization

Your executable:
- Same directory as source
- Same name as source (no extension)
- May want `.gitignore` for executables

## Multiple Files

For projects with multiple files:
- May need custom compile commands
- Use Makefile or CMake
- Adjust keybindings or use :!make

## Pro Tips

- F9 during writing, F4 for testing, F5 for debugging
- Learn to read compiler errors (most important skill!)
- Use LSP for navigation, F9 for verification
- Debugging is powerful - use it instead of printf
      ]],
      practice = {
        type = 'reference',
        instructions = [[
Practice complete workflow:

1. Write a simple program
2. F9 to compile (check errors)
3. Fix any errors
4. F4 to test
5. Introduce a bug
6. Set breakpoint before bug
7. F5 to debug
8. F1/F2 to step through
9. Find bug with debug UI
10. F6 to stop
11. Fix bug
12. F4 to verify fix

This is C/C++ development in Neovim!
        ]],
        hints = {
          'F9/F4/<leader>r for compile/run',
          'F5/F1/F2/F3/F6 for debugging',
          'Combine with LSP for full IDE experience',
          'Fast, efficient, keyboard-driven',
        },
      },
    },
  },
}
