# Test shadow for programs
## C mmap:
msync is not implemented;
mmap is okay;

## C comprehensive test:
still about msync is not implemented;

- If the fault handler is good, then the simulation would be fine;

## Go
- dynamic go is OK;
- busy loop can decrease the performance significantly;
- timer/ticker is OK;

## Go-Ethereum: Geth/Prysm
- dynamic version of Geth/Prysm;
    - they are already dynamically compiled.
- shadow version of Geth/Prysm;
    - ok for "--version"
- shadow testnet;
    - NO, for un-implemented syscalls;
    - How2?:
        - A LLM-Agent-based Generator;
        - Learn！ Learn quickly!