# Overall

## what is defi:

- financial assets fully controlled by user?
  - no: **Ce-Fi**
  - yes, then: someone be able to censor a transaction's execution single-handedly?
    - yes: **CeFi Intermediary, DeFi Settlement**
    - no, then: someone be able to censor the protocol's execution single-handedly?
      - yes: **Centrally governed DeFi**
      - no: **DeFi**

## DeFi components:

### DeFi: Asset Tokenization

- **Tokenization 代币化**: process of adding new assets on blockchain.
- **Token**:
  - **blockchain representation** of assets;
  - why? make assets more accessible, transfer, programmable
- 特殊 token：
  - T
  - NFT
  - stablecoin 稳定币
    - 链上币价不稳定，为了标准化价值，引入稳定币，锚定现实中的货币/贵金属价值；
    - 方法：
      - 中心化锚定：
        链下抵押，发行多少，就在现实中存多少，依托其信用；
      - 链上抵押：
        链上抵押数字货币；
      - 算法稳定：
        _无抵押_，算是个创新点，不过可能存在崩溃的可能；

### DEX: 去中心化交易所

- **AMM/CFMM**: constant function market maker
  - uniswap 超过 coinbase（中心化的数字货币交易所） in 20fall;

### Decentralized Lending: 去中心化借贷

- Lending in CeFi:
  - 当还不上钱，称为 default 违约；
  - 金融服务的一大目标就是减少违约的发生
    - processing default is expensive;
  - _押金小于借款_，依托于个体信用:
- Lending in DeFi:
  - 超额抵押 collateralization，_押金高于借款_；
  - 实际应用：
    - 抵押债务仓位 collateralized debt positions：
      - 抵押资产以进行货币发行，例如 makerDAO；
      - 盲猜一个和链上抵押数字货币的稳定币类型相关；
        - 使用相对稳定的数字资产来锚定当前数字资产；
    - 抵押债务市场 collateralizaed debt markets；
      - 抵押数字资产，然后借走另一种数字资产
      - 例如 compound；
- 闪电贷 flash Loans
  - rely on **atomic** transactions
    - finish completely or fail entirely;
  - 在一笔 transaction 中借贷并返还，做一些短时间操作；
    - 项目方不亏：没借出去 / 连本带利返还，只有两种可能，写死在合约里；
  - 由于项目方不亏，所以**不需要任何抵押**；
  - 常用于**套利**：arbitrageur
    - 交易所之间价差套利；
    - 稳定币脱钩套利；
      一般稳定币会回归(？)

### others

- derivatives 衍生品
- on-chain asset management
  - done on-chain rely on contract;
- decentralized insurance

## DeFi security:

### intro

- security risks in **hierarchical** structure
  - network
  - consensus
  - smart contract code
  - defi protocol composability
  - bridge
    - 跨链，预言机
  - governance
- attack vectors:
  - **technical** structure security
    - risk-free profit by exploit the blockchain system;
  - **economic** incentive security
    - exploit the incentive structure of the protocol to realize **unintended** profit at the expense of the protocol or its users.

### Case

- front-running
  attacker would observe many transactons, once there is one transaction which is profitable, like arbitrage, attacker would launch a similar behaviour with **higher transaction fee**, which would be executed quicker.
- back-running:
  sandwith attacks
- MEV miner extractable value
  黑化的矿工；

## DeFi Dependencies & systemic Risks

- 金融服务的风暴；
  - 传统使用熔断来缓解；
  - defi 没有熔断；

## DeFi challenges

- scalability: 性能差；
- usability: Dapp 使用起来**很贵**，花钱多，gas/transaction fee 之类的吧；
  - 难以推广；
- privacy
- security

# 值得看的 defi 服务：

- uniswap
- makerDAO
- compound
- balancer

# blockchain

- 去中心化技术用于一个没有可信中心的环境，例如金融，都是为了赚钱；

## Layers

- the hierarchy structure of blockchain
  - consensus layer
  - compute layer(blockchain computer)
  - Dapps / smart contracts
  - User interface;

### Consensus layer:

- append-only data structure
  - persistence, immutable;
  - consensus: agree that data on-chain is ture.
    - soft fork, latest one may not that stable;
  - liveness: would not stock
  - open: anyone can access
- miner
  - Leader: one for compute / others for verify
    - leader would win the incentive like 2 ETH...

### Compute Layer:

- Dapp are public **transparent**, to change the blockchain state;
  - would be executed by new block creators(miners);

### Dapps

- like defi, a new way to program apps;

### UI

## Foundations
- hash
- merkle tree 
  - 建立默克尔树耗时；
  - 验证简单log2N次hash即可验证；
  - how it works:
    - 用于确认当前transaction在block上的正确性；
    - 一个block可以有多个transaction；
    - 然后block串成blockchain；
- signatures
## Scaling blockchains
- low TPS and high cost；
- CeFi can handle more than 20000 tps. 
- solutions：
  - **NEW chain**: faster consunsus;
  - payment channels
    - off-chain
  - layer2: rollup
### payment channels
- **off-chain** accelerate;
- case and intro:
  - open a channel on chain, and reserve $100 into the channel;
    - reserving $100 is also slow and in-efficient.
    - the **real optimization is on the way for spending** this $100.
  - HTLC： Hashed TimeLock Contract
    - two way to close the channel:
      - close the channel by herself after 30 days.
        - timeLock: 30 days
      - anyone could submit a transaction with both bob & alice sig, would close the channel right away.
  - actually, similar to 支票记账，channel中是一个临时的保证金；
    - only the creation and the closing of channel would involve blockchain.
### Rollup:
- SNARK: a synct non-interactive argument of knowledge
- 本质：零知识证明的隐私性，以及验证的高效性；
- 引入中间验证人，证明一大堆Tx是有效的，再打包给miner； 
## Interoperability
- 跨链交互：
  - interoperability: 不同链上用户转移财产；
  - composability: 不同链上DAPP互相调用；
### Bridge
- 代理机构，再另一链上发行wrapped token；

# smart contract
- signatures:
  - visibility modifier
  - mutability modifier 
- metadata:
  - `block.timestamp`

# traditional finance

# DEX

# De-Lending
## 超额抵押

## 清算
- 抵押物价格暴跌时会被清算；
- 暴跌导致健康因子下降到1以下，就可以进行清算；
## 闪电贷