# Writing:
## Diction
- Word1:
    - couple
        tight coupling 紧耦合
    - coarse-grained 粗粒度的
    - fine-grained 细粒度的
    - neat: 整洁的
    - schema
        n. （计划或理论的）纲要，图解；（逻）（三段论法的）格；（康德哲学的）先验图式
    - scheme
        n. <英>（政府或其他组织的）计划，方案；（用于组织或整理信息的）系统，体系；组合，布局；阴谋，诡计；<苏格兰，非正式>社会住宅区
        v. 密谋，策划；<南非，非正式>认为，猜想；按色调布置
    - large-scale 大规模
    - Accordingly 相应的
- Word2:
    - proactive 积极主动的
    - prevalence 流行
    - taxonomy
        n. 分类学；分类法 / a taxonomy of DMA attacks
    - be regarded as ..
        被认为是
    - disruptive 混乱的开拓性的；
    - dictate 听写 命令 规定 背书（以理限行）
    - faithful 忠诚的 好人
    - inception 创始 开端
    - pursue 追求
    - , namely, 即
    - immutable. 不可改变的；
    - academia 学术界
    - Alternatively, 此外 或者
    - fraud 诈骗
    - fraudulent 诈骗的
    - to the best of our knowledge..
    - depicts 图片描述；
    - twofold: 双重的
    - devious  
        adj. 偏僻的；弯曲的；不光明正大的
    - elaborate 详细说明
## Layout
- abs:
    - [TOSEM]Scalable-Attack-SWwu: 
        background -> limitation with a little detail -> solution: prefer effectiveness -> evaluation statistics. -> meaning
    - [usec19]ArtOfScam-CFtorres:
        **Background**:
        -> Big background 
        -> attacks recently 
        -> New trend which is not well studied
            **Work**:
            -> Aim on exploring
            -> via brand new tool
            -> Evaluation 
        -> Meaning
- intro
    - [TOSEM]Scalable-Attack-SWwu:
        Ethereum -> Ethereum Attacks -> Smart contract exploitation: with example
        --> need for security (need for **us**) --> An example for our work flow
        --> Challenge: scale of the problem
            --> related study[1, 2, 3, 4, 5] suffers: limitations
        --> solution to challenge: 
            **strong** corresponds to limitation
        --> Implementation --> evaluation: better --> summary --> opensource
    - [usec19]ArtOfScam-CFtorres:
        blockchain 
        --> implementations of blockchain: Ethereum
        --> attacks --> related tools in academia
        --> new type of attack:
            -> description
            -> contribution
- overall

# Note
## [TOSEM]Scalable-Attack-SWwu
### abs
With pressing need on attack detection, But Still SUFFER limitations like:

limitation1:
- tight coupling between:
    - malicious contract detection
    - blockchain data importing
impossible for detecting different attacks repeadedly.

limitation2:
- coarse-grained archive data
inefficient to **replay** transactions.

limitation3:
- seperation between:
    - detection
    - run-time state recovery
consumes too much storage.

--> solution: prefer on the target instead of methodology 
    **weak** corresponding to limitation;
--> evaluation statistics
--> meaning

### intro
Ethereum -> Ethereum Attacks -> Smart contract exploitation: with example

Example of Attacks:
- re-entrancy vulnerability
    in DAO
- other [19-21]

> maybe at least 2 example would be better?

Ethereum -> Ethereum Attacks -> Smart contract exploitation: with example
--> need for security (need for **us**, specifiy flaw need to bound our tool)
--> A example for our work flow
--> Challenge: scale of the problem
    --> related study[1, 2, 3, 4, 5] suffers:
        limitation1: detection rely on data importing to local machine, heavy.
        limitation2: archive mode-> coarse-grained archive data -> not efficient
        limitation3: huge storage requirements
--> solution to challenge: 
    **strong** corresponds to limitation
--> Implementation:
    data aggregator / replay engine / instrumentation framework
--> evaluation: better
--> summary --> opensource

### background
- Background from siwei wu~
    - Ethereum accounts:
        - Externally owned account EOA
            controlled by private key.
            类似于我们的账户地址？
        - smart contract account
            controlled by smart contract code.
    - transactions
        - message call with 3 purposes:
            - transfer ether;
            - deploy a smart contract
            - invoke functions of a smart contract
        - classification:
            - normal transaction
                - initiated from an EOA 
            - internal transactions:
                - initiated from a normal transaction;
                - call a function from another function;
    - Ethereum State
        - Ethereum's nodes are devices for validating transactions;
        - 4 types of information:
            - block information;
            - normal transaction information;
            - internal transaction information;
                - same with normal transaction information, plus the **depth of the call stack**;
            - account state;
                - balance / nonce / code / storage of each account 
    - smart contract
        - EVM: 
            - overall:
                A smart contract is a program that runs on an underlying EVM to transit the global states of the Ethereum network
            - stack based virtual machine; 
                push pop is globally used in EVM;
            - other locations for data:
                - local types: 3
                    - memory
                    - input field
                    - ret field
                - persistent type: 1
                    - storage
        - Function invocation:
            - by calling these opcodes, internal transactions being performed:
                CALL / CALLCODE / DELEGATECALL / STATICCALL / CREATE / CREATE2
        - Smart contract:
            - creation:
                CREATE and CREATE2;
            - destruction:
                self-destructed: SELFDESTRUCT has a parameter for target address which would receive remaining ether.
                once target address is invalid, create such one as description. **IMPLICIT creation from destruction.**
    - Ethereum cryptocurrencies:
    - DeFi

### Design
- challenge
    - incomplete blockchain state
        data needed by the detection system is not enough;
    - scalability:
        **main issue as mentioned in sec:intro**
        previous studies focus on three ways, has their own limitations respectively.
        tight coupling / coarse-granularity archive node data / storage(recording too much runtime informations)
    - extensibility to detect different attacks:
        - JSTracer：to introspect the execution of a smart contract. It allows users to specify a JavaScript file that will be invoked for every opcode executed.
        - like instrumentation? But involves the **context switch** between EVM and JS.
        - optimization:
            - conditional context switch: defined instrumentation points are hit.
            - dynamic taint analysis engine **inside** EVM:
                - don't need to implement taint in JS, which reduce lots of CS;
- overall design
    - data aggregator
        - one-off blockchain data importing, collects the state we need.
            - collecting: via modifying EVM
            - stored to a cluster database with query interface;
    - replay engine:
        - to replay arbitrary transaction;
        - flow:
            - step1: analyst locates condidate one;
            - step2: obtain related states from data aggregator;
            - step3: re-executes the transactions;
    - instrumentation framework:
        - to customize the analysis:
            via defining callbacks at instrumentation point;
        - stack / memory values would be provided to callback
        - taint would be provided to callback with APIs;
### implementation detail
EthScope; code of **Geth**... I need more knowledge.. 2023年10月26日 15:24:32


## [usec19]ArtOfScam-CFtorres
### abs
Big background -> attacks recently 
-> New trend: more proactive with description
    well designed traps: **honeypots**
-> Work: Aim on exploring
-> Work: via brand new tool: with description
-> Work: Evaluation 
-> Meaning
### intro
- inroduction of blockchain
    - **blockchain**:
        a verifiable, append-only list of records in which all transactions are recorded in so-called *blocks*;

        are linked via hash to form a chain list - blockchain;

        list is maintained by a distributed p2p network of **untrusted nodes**, follow a consensus protocol that dictates the appending of new blocks.

        trust the majority.
    - different implementations of blockchain
        - pursue same goal: **decentralization** of asset.
        - Ethereum: computing resource decentralization via smart contract.
            - EVM: turing-complete instruction
- Attacks：
    - DAO hack in 2016
    - Parity Wallet hack in 2017
- Tools:
    - before deploy: [21 25 38] / maybe scanning tool
        This potentially enables attackers to follow a reactive approach by actively scanning the blockchain for vulnerable contracts.
        如果部分in-use合约没用过这些工具，就可能利用这些工具挖洞；
- Trap：
    - An obvious vul with second implicit vul. Attract attackers to exploit.
    - how a trap works on human-being;
    - tool, **without further description**;
    - meaning;
- contributions:
    - first analysis on new type;
    - identify related techtips and organise them in a **taxonomy**.
    - tool for new type;
    - practical value by the tool.
### background
- Smart Contract
    - He described the concept of a **trustless** system consisting of *self-executing* computer programs that would facilitate the digital verification and enforcement of contract clauses contained in legal contracts.
    - different:
        - code is stored on chain;
    - high-level:
        - Vyper / LLL / Bamboo / Solidity
- Ethereum Virtual Machine
    - The Ethereum blockchain consists of a network of mutually **distrusting** nodes that together form a decentralised public ledger.
    - stack-based, register-less virtual machine
        - 无寄存器特性；
    - gas fee: 防止无限执行；
    - Execution of smart contract: 精辟的总结，状态机；
        The execution of a smart contract results in a modification of the world state s, a data structure stored on the blockchain mapping an address a to an account state s[a]. The account state of a smart contract consists of two main parts: a balance s[a]b, that holds the amount of ether owned by the contract, and storage s[a]s, which holds the persistent data of the contract. Storage is organised as a key-value store and is the only way for a smart contract to retain state across executions. Besides the world state s, the EVM also holds a transaction execution environment I, which contains the address of the smart contract that is being executed Ia, the transaction input data Id, the transaction sender Is and the transaction value Iv. The EVM can essentially be seen as a transaction-based state machine, that takes as input s and I, and outputs a modified world state s0.
- Ethereum Blockchain Explorer
    Etherscan, allows binding between bytecode and source code;
### Ethereum Honeypots
- Def of Honeypots:
    - procedure:
        - 1. attacker deploy vulnerable contract and set bait.
        - 2. victim tries to exploit this bait contract. whiie it needs mininum funds to start execution.
        - 3. attacker withdraws the bait.
    - attacker has a **low budget** to launch such attacks, only deploy fee maybe.
- Taxonomy of Honeypots:
    - meaning of taxonomy:
        意义针对不同人群来谈：1. for user/ developer 2. for researcher
    - according to the level on which they operate:
        - EVM
            - 尽管EVM挺稳定的，user can still be **misled or confused** by devious smart **contract**.
            - techniques:
                - balance disorder
        - Compiler
            - undocumented / unnoticed / bad developer maybe..
            - techniques:
                - inheritance disorder
                - skip empty string literal
                - type deduction overflow
                - uninitialised struct
        - Explorer: **being fully trusted**
            - rely on information provided by Etherscan
            - techniques:
                - hidden state update
                - hidden transfer
                - straw man contract
- Level: EVM --> balance disorder
    - balance: like budget, contract has its own local money.
    - before execution, balance would be updated with transacton value.
- Level: solidity compiler
    - inheritance disorder: 
        - inheritance is implemented via **is** in solidity.
        - inherit multiple contracts:
            - actually only one contract would be deployed, namely, *this*;
            - all ancestor's code would be copied into *this*;

- **modifier** is a signature of solidity, IDK, then maybe next time XD 2023年10月27日 17:52:30 
        


# Refer:
- introduction of blockchain: Satoshi Nakamoto 2009
    Bitcoin: A peer-to-peer electronic cash system
- before deploy tools:
    - [CCS16] Making smart contracts smarter
    - [HITB18] Smashing ethereum smart contracts for fun and real profit 
    - [ACSAC18] Osiris: Hunting for integer bugs in ethereum smart contracts






# insights
- Need to understand the work flow of EVM thoroughly.



