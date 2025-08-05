# Objectives:
To undercore the what is consensus security.

Why consensus make sense? 33%? not too heavy.

To fill the gap between Consensus and chain eco.
It's not un-practical.

What's the workarounds?
What's the solutions?
What's the profits attacker can gain from consensus level manipulation

# Layout
- Ethereum
- consensus model? why it is a threat?
    - How consensus works: layered-implementation
    - to define key consensus interfaces;
    - 33%? to provide consensus distributed system's background to blockchain researchers.
    - profit > cost = attack;
    - the ground truth, it's not un-feasible.
- Consensus Attacks and it's impact: from simulation;
    > What are the cross-chain vulnerabilities, attack vectors, privacy leaks, and mitigations currently known, and how are they mapped to past incidents?

    - define a set of properties.
    - to define key consensus attack primitives.
    - to explore technical building blocks of attacks.
    - and from definition to our simulation:
    - Implications: 
        - when consensus break;
        - direct issue;

- Further Issue:
    - Restaking
    - Cross-chain: revert
        - like this in cross-chain SoK:![cross-chain](image.png)
    - shorting on native token: 
        - the paper: [Proof-of-Stake at Stake: Predatory, Destructive Attack on PoS Cryptocurrencies](../../../archive/2025/papers/blockchainn20-pos-attack-coin/pos-attack-coin.md)
    - affected by network issues like eclipse attack;
    - RANDAO attack
# Attacks
## List

- [blog-decoy-flip-flop](https://ethresear.ch/t/decoy-flip-flop-attack-on-lmd-ghost/6001)
    - with a [paper](https://ieeexplore.ieee.org/stamp/stamp.jsp?arnumber=9547320)
- 

## consensus layer
### In-protocol Attack
#### HLMD-GHOST Attack
- [ex-ante reorg attack](https://arxiv.org/pdf/2102.02247)
    - only needs one proposer and can reorg one block;
- [proposer-boost-ex-ante](none)
    - use PB to ex-ante reorg;
- [proposer-boost-sandwich](https://notes.ethereum.org/@casparschwa/H1T0k7b85)
    - use PB to sandwich blocks;
    - the link also have more consideration about PB;
- [sp21-balance attack](https://arxiv.org/pdf/2009.04987):
    - 通过vote release**不同对象**完成攻击;
    - 需要几十个voter，扮演不同的角色；
- [decoy-flip-flop](https://ethresear.ch/t/decoy-flip-flop-attack-on-lmd-ghost/6001)
    - with a [paper](https://ieeexplore.ieee.org/stamp/stamp.jsp?arnumber=9547320)
    - 通过**only Latest** counts，改变支持的链，扩大现有不稳定；
    - [fix](https://github.com/ethereum/consensus-specs/pull/1466)
    - Only consider an attestation if it is from the **current or previous epoch**;
#### Casper Attack
- [unrealized justification](https://notes.ethereum.org/@adiasg/unrealized-justification)
    - 利用Justification 只会在epoch boundary更新，新epoch的checkpoint的parent落在哪里，由提出者选择，那么就可以把收到足够票数之后的block都无视掉；
    - 需求：一个epoch cp proposer是恶意的；
    - 效果：reorg 上个epoch后几个块；
- [justification withholding](https://hackmd.io/o9tGPQL2Q4iH3Mg7Mma9wQ)
    - [类似](https://notes.ethereum.org/VH_B3kEVQFav4roEgYuCjA)
    - 攻击者收集足够justify一个cp的票，然后无限拖延直到诚实链也有能力justify了，再justify老cp导致新块都无效；
- [bouncing-attack](https://ethresear.ch/t/analysis-of-bouncing-attack-on-ffg/6113)
    - 指出现有协议在某些极端情况下，攻击者只需控制少量边界投票权即可永久延后finalization，而只是在网络中不断justify；
    - 被 safe-slot 缓解；
- [staircase](usec24)
    - 多次的justification withholding;
#### Long-Range
- Stake Bleeding: Longest Casper CP
    - Has Non-protocol mitigation
    - inactivity-leakage
- Nothing-at-stake: Selfish CHain
    - Has Non-protocol mitigation
    - weak subjectivity
### Non-protocol Attack
- [RANDAO attack PoS Ethereum](https://ethresear.ch/t/liveness-attack-in-ethereum-pos-protocol-using-randao-manipulation/22241)
- [Proposer boost partition](https://barnabe.substack.com/p/pos-ethereum-reorg)
- [staircase](usec24)
    - 多次的justification withholding;
## network layer
eclipse attack.
bounded-capacity teasing attack.

## app layer: Target
Consensus Level Double spend
Service Level Double spend
cross chain
shorting
MEV: Sandwich
private txs via consensus



## Non-ETH PoS attack
[selfish endorsing](https://cryptoeconomicsystems.pubpub.org/pub/neuder-selfish-behavior-tezos/release/10)
# insights：
- 可否利用时间的不统一使其在一个边界时间相关的事件上发生分片？
- 以点及面的网络嗅探；

# 讨论
- 目标：从以太坊共识攻击模拟尝试揭露一些攻击的性质，以及提供一个攻击的测试平台；
    - 纯模拟：模拟节点+模拟网络；
    - 模拟调度：真实节点+模拟网络；
- 不同的攻击会：
    - 攻击共识或者说共识系统的不同部件，而导致对于节点能力模拟的能力要求在一步一步走向真实节点：
        - 应用层：使用共识层攻击协助应用层攻击；
        - 共识层：Gasper -> Incentive -> RANDAO -> Dynamic Set -> Weak Sub；
        - 网络层：使用网络层攻击协助共识层攻击；
            - eclipse
            - bounded capacity
    - 可能有不同的setup，区别于真实以太坊，所以会claim 说这个攻击只是以太坊共识协议在另一种setup下可能遭受攻击；
        - 网络假设、规模假设、参数假设；
- 不同的攻击对象，也有不同的攻击setup，而之所以将这些都放在一起，主要是因为这些攻击都是针对围绕Gasper协议实现的共识系统的攻击；
- 而实际上针对以太坊的攻击，真实的Ethereum 2.0的攻击，其实很少；
    - 为了缓解部分攻击，在共识协议中还出现了一些optional的选项；
        - 其实给攻击面了，也许可以借此分片网络；
        - 进一步让模拟难做，又或者专门做一个这个研究？
    - 以及我探索了一些理论分析性的工作，理论分析工作在面对复杂的Gasper PoS时，难以分析，目前的分析只能到Longest chain的程度，引入投票之后整个机制的复杂性难以通过数学分析；
    - 共识攻击的经济效应，作恶成本与攻击者motivation问题；

# Doing

- [Layout reference](https://prysm.offchainlabs.com/docs/learn/concepts/nodes-networks/)
    - execution client
    - beacon node
    - validator
- 搭建配置平台：
    - 对可变配置进行变化；
        - 哪些可变？
            - 优先选择与共识分叉相关的几个选项；
            - 若有了PoC再尝试结合BCB的MEI找到更多可配置选项；
        - 自动化测试？
        - 参考BCBFuzzer；
    - 驱动自动化测试；
- 实验场景：
    - byzantine fault: 
        - delay / atk / atk+delay
    - protocol under test:
        - standard eth
            - 共识稳定性
            - 攻击成功率

## development
按需吧：轻易配置平台；
重要：网络模块；



## 1.1 configs scrutiny
```go
	// Fork choice algorithm constants.
	ProposerScoreBoost              uint64           `yaml:"PROPOSER_SCORE_BOOST" spec:"true"`                
	ReorgHeadWeightThreshold        uint64           `yaml:"REORG_HEAD_WEIGHT_THRESHOLD" spec:"true"`         
	ReorgParentWeightThreshold      uint64           `yaml:"REORG_PARENT_WEIGHT_THRESHOLD" spec:"true"`       
	ReorgMaxEpochsSinceFinalization primitives.Epoch `yaml:"REORG_MAX_EPOCHS_SINCE_FINALIZATION" spec:"true"` 
	IntervalsPerSlot                uint64           `yaml:"INTERVALS_PER_SLOT" spec:"true"`                  
```
- **ProposerScoreBoost** defines a value that is a % of the committee weight for fork-choice boosting.
- **ReorgHeadWeightThreshold** defines a value that is a % of the committee weight to consider a block weak and subject to being orphaned.
- **ReorgParentWeightThreshold** defines a value that is a % of the committee weight to consider a parent block strong and subject its child to being orphaned.
- **ReorgMaxEpochsSinceFinalization** defines a limit to consider safe to orphan a block if the network is finalizing。
- **IntervalsPerSlot** defines the number of fork choice intervals in a slot defined in the fork choice spec.

- getProposerHead:
    - 安全过滤器，察看是否可以进行单block reorg；

### Experiments
- 4 setups:
    - ideal
    - ideal + latency
    - ideal + attack
    - ideal + latency + attack

**共识稳定性detailed metrics**:
- safety: reorg number;
- liveness: justification speed(number of blocks);

- attack?
    - 针对网络现状做针对性攻击；
    - 攻击策略是灵活的，只要共识稳定性差了就会有攻击出现；
    - 因此使用现有攻击策略判断共识稳定性是不妥的；
    - 网络模块搞起来；

- doing:
    - 1h - no PB under exante attack;
```
time="2025-07-30 04:15:08.016" level=info msg="reorg event" depth=5 slot=66 totalReorgDepth=0
time="2025-07-30 04:20:58.317" level=info msg="reorg event" depth=5 slot=96 totalReorgDepth=5
time="2025-07-30 04:47:20.030" level=info msg="reorg event" depth=6 slot=226 totalReorgDepth=10
time="2025-07-30 05:01:34.239" level=info msg="reorg event" depth=4 slot=300 totalReorgDepth=16
```
    - 1h - normal PB under exante attack: 3



# Plans
- 2025年7月21日 11:29:58
    - 搭建可轻易配置不同配置项的平台，脚本驱动docker compose；
    - 观察调整部分选项后是否出现共识错误；
    - 加入监测模块，量化共识的不稳定；
    - 根据数据定义共识稳定性；
    - 加入网络延迟模块；
    - 复测相关数据；
- 2025年7月26日 21:11:41
    - TBD1：consensus code reading, fork choice;
        - 1.1: fork related configs;
            - Time: 3-5h Sun.
            - not that much. But still can be tested.
    - TBD2: test for consensus diff under attack;
        - 2.1: test attack with diff config;
            - 2-3h Mon.
        - 2.2: Metrics for consensus stability;
            - 2-3h Mon.
        - 2.3: Run tests for diff config experiments, with well-defined metrics;
    - TBD3: network module;

    - TBD4: network module test;
    - TBD5: BCB slides;
- 2025年7月30日 12:01:42
- 2025年8月3日 21:00:35
    - 组网的--peer稳定性问题如何解决？
        - 固定p2p key;
            - --p2p-priv-hex=${P2PKEY}
        -  固定ip;
            - 先用docker完成一次；
            - 然后使用networkSim；
