# basic vuls
- non re-entrience
    - interger overflow;
        - case: **batchOverflow 2018**;
        - **safemath** **safecast**;
        - sol 0.8之后，自带compiler检查；、
            - 检查是费钱的，instruction花钱的；
            - 使用uncheck来优化gas fee；
    - call injection;
        - 有些low level call 的参数可控，用来绕过**this**；
        - 有些internal使用的函数，利用low-level call来作为代理攻击者；
        - 类似的事，新的叫法：
            - untrusted from/to address
            - untrusted path
    - case： public mint / burn / xxx
- **Re-entrancy**:
    - links: 
        repo/reentrancy-attacks
        re-entrancy in-depth
    - 类比：
        - 传统OS中，可重入函数很多：
            被打断，又进入这个调用，过程中若OK则**可重入**，如果不应该被打断，打断后会出问题，则不可重入；
    - 重入root cause:
        - external call
        - shared state
    - in Blockchain:
        - external call:
            - implicit
            - explicit
        - shared states
            - global states
            - change before/after external call
    - implicit call in blockchain
        - fallback
        - library call
        - send ether:
            - transfer
            - send
            - call
    - Explicit call
        - ERC721: safeTransferFrom

- 重入：
    - msg.sender.call.value...
    - 该类交易会走目标的fallback，可以再循环调用交易函数；
        - 由于交易后为交易值置零，所以交易可以被发起多次；
    - pattern：
        - untrust external call
        - able to modify state
- read-only re-entrancy
    - re entrancy for good, 1inch fusion mode

- price: 用amount来算的；
