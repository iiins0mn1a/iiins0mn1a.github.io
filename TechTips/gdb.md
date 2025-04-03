# GDB Debugging Tips

## Basic Commands
- `break`: Set breakpoint
- `run`: Start program execution
- `next`: Step over
- `step`: Step into
- `print`: Print variable value

## Example Session
```bash
gdb ./your_program
(gdb) break main
(gdb) run
(gdb) next
(gdb) print variable_name
```

## Advanced Features
- Watchpoints
- Reverse debugging
- Core dump analysis