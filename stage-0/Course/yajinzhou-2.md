- 课程2
    - Transactions: field
        - nonce（改地址发过多少交易） / gas price / gas limit / to / value / data / v,r,s
        - 部署合约：from == something & to == NULL
        - 构造函数： Constructor；
        - EVM部署：
            - 解释执行：认为是deploy代码；
            - 定位bytecode字段，并认为可执行；
            - 执行Constructor；
                Constructor 一次性执行，不会放在合约代码段，浪费；
            - opcode CREATE:
                - 新地址 = hash(sender, nonce);
                - 由于nonce在变，新地址难以相同；
            - opcode CREATE2:
                - new_address = hash(0xFF, sender, salt, bytecode);
                - 不引入nonce，所以可以创建地址相同的新地址；
            - 例子：课程19m
                - A用CREATE2创建B，B用CREATE创建C；
                - BC自毁；
                - A用CREATE2创建B' == B，B用CREATE创建C’ == C；
                - C的代码可以不一样（bytecode不参与地址计算）；
                - 利用nonce值的**reset to zero**;
                - 效果：相同地址，不同功能；
                - 相关案例：Metamorphic
                    https://github.com/spalen0/warroom-ethcc-2023/blob/master/test/metamorphic/MultiplerRug.t.sol
                - cy锐评：有没有方法来快速知道这种bytecode change的事件发生的所有历史呢 感觉可以做个measurement看看人家为啥要这么干；
        - Field: data/input: 
            function selector + 参数
        - EVM执行：
            - 书：教你怎么写virtual machine
            - stack-based virtual machine:
                - 操作数都在栈上；
                - 大数组；
            - memory-model:
                - non-volatile:
                    - 执行后依然存在的数值；
                    - include: code / storage data
                    - storage：
                        - 持久化存储当前地址的状态信息；
                            谁拥有我的token？
                        - 有特定的指令opcode用于存储storage；
                - volatile：
                    - 执行后消失的数值；
                    - include: stack args(calldata) memory;
            - type: memory
                - mstore(p, v)
                    写 / p，v来自栈；
                    mem[p..(p+32)] := v
                - mload()
                    读
                    mload(0x40)从0x40偏移处取值；
            - type: storage
                - EVM codes playground;
            - Call & Delegatecall:
                - internal transaction;
                - 合约之间上下文隔离；
                - Delegatecall: 
                    - 定义：
                        call the functions inside another smart contract, while using its **own** storage and context.
                    - 类似于借用他的代码；不需要他的代码；
                    - 简单的proxy合约交互；实现在复杂的合约里，通过delegatecall交互；
                    - 类似于库函数；
                    - 打补丁方便，交互都用proxy，给B改实现，改proxy改storage；
                        - 隐患：升级后端合约，变成恶意；
                        - 案例：https://proxies.yacademy.dev/pages/security-guide/
            - low-level call
                - 常规写法：<contract>.<function>
                    - 可以自动传递异常；
                        - A call B.func；
                        - 在func出问题，revert信息会往上报；
                - low-level call:
                    - <address>.call() 
                    - **不传递异常** but return false;
                    - 返回：（成功失败与否，返回值）
                    - 需要手动对异常进行校验；
                    - **不会revert**；
                - 跨链桥 root cause;
        - attacks:
            - Fomo3D:
                - 花钱可能获得奖励；
                - 如何有选择的投注？由于合约漏洞；
                - “随机数”伪随机；
                - 算法透明；
                - 攻击：
                    - 生成一个合约，计算是否会中奖；
                    - 否则下一个，直到撞到；
                    - 投注；
                    - 只损失一点点gas fee；
                - **链上无随机**； commit reviewer?
            - EFVault:
                - contract with proxy;
                - user can <redeem()> 从池子里取钱；
                    - 需要计算user有多少钱；
                - implementation contract upgrade；
                - **storage related 不理解**；
            - UUPS vul
                - Constructor: 一般implementation 当然会修改当前自身的context；
                - 如果想要修改proxy的状态，将Constructor变成普通函数；
                - 用proxy去delegatecall调用该cons函数，则改proxy的状态；
                - UUPS模式：
                    - 在实现合约实现“升级逻辑”：
                        - proxy合约的某个storage值 指向新implementation；
                        - **migration**，将老imple的部分向新imple的数据做迁移；
                        - 利用delegatecall；
                    - 外部调用imple的升级函数，可导致imple毁灭；
                        - 而让项目**黄掉**；
                - 案例：
                    uninitialize漏洞  ethernaut 25 題
                    https://github.com/alex0207s/ethernaut-foundry-boilerplate/blob/solution/test/25-Motorbike.t.sol
                    **wormhole**
                - refer:
                    关于如何编写可升级的合约可以看 openzepplin 的官方文档：https://docs.openzeppelin.com/upgrades-plugins/1.x/writing-upgradeable
            - TC Dao
                - https://twitter.com/BlockSecTeam/status/1660214665429876740

- 如果bytecode和sourcecode不匹配会怎样？
- import不同的东西会影响CREATE2马？