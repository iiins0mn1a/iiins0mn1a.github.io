# Diction
- word1:
    - genesis n. 起始 起源
# note
- basic：
    - trust minimized agreements
        - unbreakable promise
    -  application
        - defi：去中心化金融
        - DAOs: 去中心化管理
        - NFTs：非同质化代币
    - **?**: transaction fee = gas fee * compute usage by Txn
    - genesis block
        first block in a blockchain
    - how it works:
        - hash
        - block
        - blockchain
        - distrubuted system:
            - 少数服从多数？
        - coinbase
    - crypto: RSA asymmetric encryption
        - public / private key
        - public for encryption;
        - private for decryption and 签名signature；
    - Real Fee: 
        Burnt = Gas Fee Base * amount of Gas used
        永远丢失的，烧掉的东西；实际上类似于消耗的网络资源的钱
        Transaction Fee - Burnt = paid to miner            
    - Fee: 不同的链不同的规则，这相当于是金融游戏的规则，算法不一定；前面也是对的；
- concepts:
    - 共识 consensus
    - algorithm：
        - chain selection
        - sybil resistance: 
            - PoW
            - PoS proof of stake
    - attack:
        - sybil attack：大量账户还攻击去中心化概念；
        - 51% attacks：longest one is correct
- solidity:
    - **public**: can be seen outside;
        - acutally generate a *getter* function automatically for a public valueable;
- insights:
    - change and revert change?

- solidity：
    - signature: 
        pure/ view 一般不消耗gas fee，除非是被常规function做internal call；
    - struct:
        ```solidity
        People public person = People({favoriteNumber: 2, name: "bububu"});

        struct People {
            uint256 favoriteNumber;
            string name;
        }
        ```
    - array:
        array X struct initialization;
        ```solidity
        People[] public people; // empty one

        function addPerson(string memory _name, uint256 _favoriteNumber)public {
            // People memory new_person = People({favoriteNumber: _favoriteNumber, name: _name});
            People memory new_person = People(_favoriteNumber, _name);
            people.push(new_person);
        }
        ```
- EVM:
    - access and store information in six places:
        - **memory**
            - temporary data which could be modified;
        - **calldata**
            - temporary data which can not be modified;
        - **storage**
            - permenant data which could be modified;
        - stack
        - code
        - logs
    - 普通的数据类型uint256会被默认放在memory中；
    - 特殊数据类型需要声明存放位置：
        - array(include string, array of bytes), struct, mapping；
- solidity:
    - array:
        <array>.push(<element_of_array>) 
            would append new element to this array..
    - a standard usage for contract sharing:
        `<contract>.<function>`
    - import a contract and: **inheritance**
        contract A **is** B {}
    - **virtual** function can be **override**
- FundMe:
    - **C1** how to send ETH to another account?
    - oracle:
        - 现实世界与web3的数据接口；
        - 用去中心化的思路提供可靠的数据；
        - 避免数据中心化导致的;
    - 获取汇率；
    - **payable**；

- 2023年10月27日 18:00:20
    - after two failure on reading paper from siwei wu and usec19
- 2023年10月30日 11:03:43
    - what if we want to record the people(address) who has sent money to us?
    - `address[] public funders;`
        - `funders.push(msg.sender);`
    - ABI 外部接口 Application Binary Interface
    - library:
        - step1: 
            create "new.sol" 
            -> `"library Lib{ ... }"` with every `internal`
        - step2: 
            in "old.sol": `import "./new.sol";` 
            -> in contract: `using Lib for uint256;`
    - library: safemath
        - <0.8 不会检查整型上下溢出；
        - >=0.8 会检查； 依然可以使用`unchecked{ ... }`显式取消检查；
            - uncheck 节省gas fee；
    - 打钱：
        - transfer
            `payable(msg.sender).transfer(address(this).balance);`
            会报错revert，传递到caller处；
        - send
            `bool sendSuccess = payable(msg.sender).send(address(this).balance);`
            不报错，给返回值，已经被IDE不推荐使用，改用transfer；
        - call
            `(bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");`
            low-level call, <address>.call 需要自己handle返回值；
    - modifier
        - def: 
            `modifier A{ ...; _; }`
                前缀
            `modifier B{ _; ...;}` 
                后缀
- 2023年10月30日 14:40:47
    - more advanced concepts:
    - gas efficient optimization:
        - constant: 
            把一个**初始化只赋值一次**的变量变成constant常量，在正经的以太坊上部署合约能省1刀；
        - immutable：
            把一个初始化以外只赋值一次的变成immutable变量；
    - Constructor：
        - 自调用，用来指定owner不错；
    - receive:
        - 不需要function字段
        - calldata = "" 空时，默认收钱回调；
            `receive() external payable { ... }`
    - fallback:
        - 不需要function字段
        - 当calldata != "" 空时，默认收钱函数；
        `fallback() external payable { ... }`
    