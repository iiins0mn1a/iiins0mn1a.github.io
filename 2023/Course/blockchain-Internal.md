# State variable RULES

- Definition: variables stored in **storage**;
- slot
- excepts for dynamically-sized arrays and mappings, other storage data are stored continuously in slot, from the first state variable's location `slot 0`.
- For each variable, a **size in bytes** is determined according to its type.
- Multiple, contiguous items that need less than 32 bytes are **packed** into a single storage slot if possible, according to the following **[RULES]**:
  - The first item in a storage slot is stored **lower-order aligned**. like little endian;
  - Value types use only as many bytes as are **necessary** to store them.
  - If a value type does not fit the remaining part of a storage slot, it is stored in the **next storage slot**.
  - **Structs and array** data always start a new slot and their items are packed tightly according to these rules.
  - **Items following struct or array data** always start a new storage slot.
- **?Can not understand**:
  For contracts that use inheritance, the ordering of state variables is determined by the C3-linearized order of contracts starting with the most base-ward contract. If allowed by the above rules, state variables from different contracts do share the same storage slot.

# Stack variable in EVM

[article](https://medium.com/coinmonks/solidity-stack-how-does-it-work-5a216d87db0d)

- Stack definition
  The Stack is simply a pile of “words” or “slots” (256 bits long) that can contain a maximum of 1024 items.

  The EVM behaves as a “stack machine”, it uses the stack to look for its opcodes input arguments and to store its opcodes outputs.

  Value type variables declared in a function’s body are added to the stack, each variable takes a whole 256 bits slot, even if the variable’s data type requires less than 256 bits no packaging is performed (as it happens in the storage).

- Stack usage
  The Stack behaves like a LIFO queue, values are extracted/added from/to the top.

  Some EVM opcodes need input arguments, some might need only one argument (e.g. “NOT”), other might need multiple arguments (e.g. “ADD”), but they all get their values from the top of the stack and they remove them as soon as they consume them.

  Some EVM opcodes might generate an output result which is always added to the top of the stack.

  For a full list of EVM opcodes and how they interact with the stack you can check the [Ethereum official EVM codes website](https://www.evm.codes/?fork=shanghai).

# Storage in EVM

[article](https://medium.com/coinmonks/solidity-storage-how-does-it-work-8354afde3eb)

- like a database;
- DAMN it's not free for reading..
  [article2](https://zhuanlan.zhihu.com/p/82326463)
- why `database`?
  it's a mapping from index to slot;
- 2^256 slots in total, and 32 bytes for each slot. Huge memory region..
- Opcodes related:
  - Sload: read a word
  - Sstore: write a word

# Calldata in EVM

# from solidity to bytecode

[登链入门](https://learnblockchain.cn/article/4253)

- how to call a function?
- calldata:
  - function selector
    - first 4 bytes in hash `keccak256( "<function name>(arg_type)" )`;
  - argu
    - uint256 就直接 32 个 bytes 糊脸上；
- related opcodes:
  ```
  60 00                       =   PUSH1 0x00
  35                          =   CALLDATALOAD
  60 e0                       =   PUSH1 0xe0
  1c                          =   SHR
  80                          =   DUP1
  63 2e64cec1                 =   PUSH4 0x2e64cec1
  14                          =   EQ
  61 003b                     =   PUSH2 0x003b
  57                          =   JUMPI
  80                          =   DUP1
  63 6057361d                 =   PUSH4 0x6057361d
  14                          =   EQ
  61 0059                     =   PUSH2 0x0059
  57                          =   JUMPI
  ```
  - PUSH1 0x00
    - PUSH1: 压栈一个数值字节;
  - calldataload
    - 目的：将 calldata 入栈；
    - 行为：
      - pop 栈顶元素作为 input，即 0x00 作为访问偏移量 offset；
      - 一个栈元素是 32bytes，需要压入的部分就是`calldata[i:i+32]`；
        - 在我们的例子中，calldata 合计 36 字节（4 for hash and 32 for uint256）；
        - _丢失最后 4 字节？_
  - PUSH1 0xe0
    - 压栈 0xe0; 224 = 256 - 32
  - SHR
    - 右移操作，pop 栈顶元素作为右移次数，即 224；
    - 右移后还剩 32bit，即 function selector 已获取；
    - 在 calldata 里，只剩下了 fs；
  - DUP1
    - dup 栈顶 1 个元素；
  - PUSH4 0x2e64cec1
    - 向栈顶压入 4 字节的 retrieve()（另一个函数）的 fs；
  - EQ:
    - pop 栈顶两个元素并判断是否相等；
    - 相等 push(0x1) else push(0x0);
  - PUSH2 0x003b
    - 压入 2 字节 59;
    - 59 是 retrieve 的函数起始位置；
      - 类似行数；
  - JUMPI:
    - jump if
    - 依次弹出栈顶两个元素 a1, a2;
      ***
      | a1 |
      ***
      | a2 |
      ***
    - 以 a1 位跳转地址，以 a2 为是否跳转；由于 EQ 压栈了 a2 为 0（retrive 和我们的 store 匹配失败），opcode 又压栈了 a1 位 retrieve 地址，所以**不跳 retrieve**；
  - DUP1
  - PUSH4 0x6057361d
  - EQ
  - PUSH2 0x0059
  - JUMPI
    类似的尝试匹配 store，匹配成功跳！
- 本质 if-else 依次匹配已有函数；

# Memory

[play ground](https://www.evm.codes/playground?fork=shanghai)

- feature:
  - 类似于 heap 区，但目前永不 free，直到合约实例运行结束；
- 核心指令：
  - MSTORE (x, y)
    - 以“x”处为起点，写入**32 字节**的数据“y”
    - 先 push y 再 push x;
  - MSTORE8 (x, y)
    - 以“x”处为起点，写入 1 字节的数据“y”(调用栈的最低有效字节)
  - MLOAD (x)
  - 从“x”处取出 32 字节的数据加载到调用栈。
- tips:
  - store 付费，32 字节一买；
  - 前 724 字节，内存扩展的花费成线性增长，后边按照二次方增长；
  - memory 是一个以 byte 为粒度的数组，可以随机访问；
- 空闲内存指针：
  - newFreeMemoryPointer = freeMemoryPointer + dataSizeBytes;
  - 0x40 位置是是**存储空闲内存指针**的位置；
    - 即 0x40~0x5f (32bytes)的内容是空闲指针；
  - 0x00~0x3f 合计 64bytes 是固定算法如 hash 和内联汇编使用的暂存空间；
  - 0x60~0x7f 32bytes 用作**0 值插槽**；
    用作动态内存数组的初始值，不会被写入；
- 新的 memory 变量从地址 0x80 开始分配；
  - 变量初始化：
    - 使用 CALLDATACOPY 指令完成初始化；
    - 三个参数：
      - memoryOffset (数据拷贝的目标地址)
      - calldataOffset (待拷贝数据在 calldata 里的偏移量)
      - size (需要复制的大小)
    - offset 为 0x80，我们的目标在 0x80；
    - size 是 0xa0, bytes32[5]合计 160bytes；
    - calldataOffset 无所谓，我们没有，置零即可；
- memory 变量赋值：
  ```
  PUSH1 0x01
  // push 0x00
  PUSH1 0x00
  // left shift operation no shift, first input is 0
  SHL
  // duplicate 2nd item on stack (0x120)
  DUP2
  // push 0x00 = [0] where in the array should this item go
  PUSH1 0x00
  // push 0x20 = 64 bytes the length of the array
  PUSH1 0x02
  // duplicate 2nd item on stack (0x00)
  DUP2
  // 0x00 < 0x20 =  true = 0x01 (check the user is not trying to store a value at a location that doesn't exist in the array)
  LT
  // jump location
  PUSH2 0x00d7
  // 2 POPs since this is a JUMPI (checking if LT returned true or false)
  // simulate JUMPI
  POP
  // simulate JUMPI
  POP
  // push 0x20 (32 bytes aray item size)
  PUSH1 0x20
  // 0x20 * 0x00 = 0x00 = 0 in decimal (array item size * index to determine byte offset)
  MUL
  // 0x00 + 0x120
  ADD
  // duplicate 2nd on stack 0x01 (value for b[0])
  DUP2
  // duplicate 2nd on stack 0x120 (memory location for b[])
  DUP2
  // store 0x01 at memory location 0x120
  MSTORE
  // clean up stack
  POP
  POP
  POP
  POP
  ```

# Storage slot

- 本质是一个 mapping 结构， 32 字节的 key 可以取到 32 字节的 value；
  - 而 32 字节的 key 可以理解为 storage 空间有 2^(32\*8)的线性空间；
- 认为改空间内所有对应数值默认为 0；
  - 不会真的写 0，这空间过大，而是读的时候默认为 0；
  - 当我们把某个 storage value 置零后，返还 gas fee，存储 0 不占真实空间；
- storage 有两种内容：
  - 定长变量；
  - 不定长变量；

## fixed size values：

- feature:
  - 一个一个占用 32bytes 的格子 slot；
  - slot packaging:
    - 多个不足 32 字节的变量一起占用一个 32 字节的格子；
    - 小端: 4 4 8 16 存储时 为 16 8 4 4，参看 0x1 被存在 32 字节中时，也在尾巴上；
  - slot[0] 和 zero slot 不是一个东西，zero slot 是 memory 的概念；
- 相关代码：
  - SSTORE
    - 从调用栈取两个值，一个是 32 字节的 key，一个是 32 字节的 value。然后把 value 存在 key 值对应的插槽上
    - 先 push 内容，再 push 地址；
  - SLOAD
    - 从调用栈拿 32 字节的 key 值，然后把 key 值插槽的 value 拿出来压到调用栈上
- 问题：
  - S\*两条指令，都是以 32 字节为粒度进行操作的，那么如何 handle slot packaging 的变量呢？
- 使用位运算取目标：
  - AND
  - OR
  - NOT
- 处理 slot packing 变量的 bytecode：

  ```
  // --------------------------------
  // Solidity Line 17 - "value1 = 1;"
  // --------------------------------

  PUSH1 0x01
  PUSH1 0x00
  DUP1
  PUSH2 0x0100
  EXP
  DUP2
  SLOAD
  DUP2
  PUSH4 0xffffffff
  MUL
  NOT
  AND
  SWAP1
  DUP4
  PUSH4 0xffffffff
  AND
  MUL
  OR
  SWAP1
  SSTORE
  POP

  // ---------------------------------
  // Solidity Line 18 - "value2 = 22;"
  // ---------------------------------


  PUSH1 0x16 // value2 = 22 decimal = 0x16 in hex

  PUSH1 0x00 // slot 0 - storage location for "value2"

  PUSH1 0x04 // 4 bytes in - start position for "value2"

  PUSH2 0x0100 // 0x100 in hex = 256 in decimal, 256 bits in 1 byte

  EXP // exponent of 0x0100 & 0x04 = 0x100000000

  DUP2 // duplicate 0x00 to top of stack

  SLOAD // load data at slot 0

  DUP2 // duplicate exponent of 0x0100 & 0x04 = 0x100000000

  PUSH4 0xffffffff // bitmask 4 bytes length

  MUL // multiply to get bitmask for the 8 bytes assigned to "value2"

  NOT // NOT operation to get bitmask for all bytes except the 8 bytes assigned to "value2"

  AND // AND of bitmask and slot 0 value to zero out values in the 8 bytes assigned to "value2" and retain all other values

  SWAP1 // bring 0x100000000 to top of the stack

  DUP4 // duplicate value2 value = 22 = 0x16

  PUSH4 0xffffffff // bitmask 4 bytes length

  AND // AND to ensure the value is no more than 4 bytes in length

  MUL // returns value2 at the correct position - 4 bytes in

  OR // OR with previous value and the value AND yielded on line 38 gives us the 32 bytes that need to be stored

  SWAP1 // slot 0 to top of the stack

  SSTORE // store the 32 byte value at slot 0

  POP // pop 0x16 off the stack

  // ----------------------------------
  // Solidity Line 19 - "value3 = 333;"
  // ----------------------------------

  PUSH2 0x014d
  PUSH1 0x00
  PUSH1 0x08
  PUSH2 0x0100
  EXP
  DUP2
  SLOAD
  DUP2
  PUSH8 0xffffffffffffffff
  MUL
  NOT
  AND
  SWAP1
  DUP4
  PUSH8 0xffffffffffffffff
  AND
  MUL
  OR
  SWAP1
  SSTORE
  POP

  // -----------------------------------
  // Solidity Line 20 - "value4 = 4444;"
  // -----------------------------------

  PUSH2 0x115c
  PUSH1 0x00
  PUSH1 0x10
  PUSH2 0x0100
  EXP
  DUP2
  SLOAD
  DUP2
  PUSH16 0xffffffffffffffffffffffffffffffff
  MUL
  NOT
  AND
  SWAP1
  DUP4
  PUSH16 0xffffffffffffffffffffffffffffffff
  AND
  MUL
  OR
  SWAP1
  SSTORE
  POP

  // ----------------------------------------------------------
  // Solidity Line 22 - "uint64 value5 = value3 + uint32(666);"
  // ----------------------------------------------------------


  PUSH1 0x00

  PUSH2 0x029a // uint32(666)

  PUSH4 0xffffffff // bitmask 4 bytes length

  AND // ensure uint32(666) does not exceed 8 bytes, trim if it does

  PUSH1 0x00 // slot 0 - location of value3

  PUSH1 0x08 // 8 bytes in - start position for "value3"

  SWAP1 // bring 0x00 to top of stack for SLOAD of slot 0

  SLOAD // load data at slot 0

  SWAP1 // bring 0x08 to top of stack for EXP

  PUSH2 0x0100 // 256 bits in 1 byte

  EXP // exponent of 0x0100 & 0x08 = 0x10000000000000000

  SWAP1 // get slot 0 value to top of stack

  DIV // DIV of slot 0 value with 0x10000000000000000 remove bottom 8 bytes

  PUSH8 0xffffffffffffffff // bitmask 8 bytes length

  AND // Zero out bytes outside of the 8 byte mask to return variable "value3"

  // To see the rest of the opcodes for this calculation recreate the contract in remix and enter debugging mode
  ```

## Storage with dynamically-sized values

[article](https://programtheblockchain.com/posts/2018/03/09/understanding-ethereum-smart-contract-storage/)

- feature:
  - no need for allocation/release, since the storage array is too big, even we use it randomly, There's almost zero chance of a collision, the probability of collision is equal to hash collision. which is neary impossible.
  - solidity uses **a hash function** to uniformly and repeatedly compute locations for dynamically-sized values.
- spec:
  - dynamically-sized array:
    - need to store its size and elements;
    - actually the metadata of array would be stored into slot just like fixed size values;
      - But the only thing that’s stored there is the **size** of arry. The values in the array are stored consecutively starting at the hash of the slot.
      - Example: array's metadata is stored at `slot[5]`, then elements would be stored from `slot[hash(5)]` continuously.
  - mappings
    - will just occupy a slot for nothing, for example `slot[6]`, but mapping element `map[key]` would be stored at `slot[hash(key, 6)]`;
