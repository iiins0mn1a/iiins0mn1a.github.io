# 日拱一卒：Keep on Keeping on
## Fragments
- I would be better, day by day, on my own.
- 世界上唯一一个与真实的我共处过的人离开了。
- 于是，时间开始流动。2025.7.18

## Main: 2025 Summer

### Paper Reading

---

#### **Consensus-attack**: [Breaking the Privacy Barrier: On the Feasibility of Reorganization Attacks on Ethereum Private Transactions](./archive/2025/papers/acsac24-ptx-reorg/breaking-privacy-barrier.md)

Abstract:
- Leverage the Ethereum Reorg Attack to perform Private Transaction Leakage.
- ACSAC24, CCF-B, Leader: Lin Zhiqiang, Author: Mengya Zhang

---

#### **LLM-attack**: [Demystifying rce vulnerabilities in llm-integrated apps](./archive/2025/papers/ccs24-llm-rce/llm-rce.md)

Abstract:
- Detect RCE within LLM-integrated Frameworks;
- CCS24, CCF-A, Leader: Kai Chen 国科大UCAS, Author: Tong Liu

---

#### **Consensus**: [Uncle Maker: (Time)Stamping Out The Competition in Ethereum](./archive/2025/papers/ccs23-uncle-block/uncle-block.md)

Abstract:
- To attack Eth1.0 via
- CCS 23, CCF-A, Leader: Aviv Zohar(The Hebrew University, Israel)

---

#### **LLM-Sec**: [IsolateGPT: An Execution Isolation Architecture for LLM-Based Agentic Systems](./archive/2025/papers/ndss24-isolateGPT/isolateGPT.md)

Abstract:
- Perform Approach migration from traditional system security, i.e. Isolation, into LLM systems, via (1) well-defined interfaces, (2) user-permission.
- NDSS25, CCF-A, Leader: Ning Zhang Washington University in St. Louis, Author: Yuhao Wu.

---

#### **Blockchain**: [SoK:Security and Privacy of Blockchain Interoperability](./archive/2025/papers/sp24-SoK-chain-sec.md/)

Abstract:
- CCF-A, S&P24, cross-chain bridge SoK;
- just for some insights about consensus failure's implications.

---

#### **Consensus**: [A survey on long-range attacks for proof of stake protocols](./archive/2025/papers/access19-long-range-survey/long-range-survey.md)

Abstract:
- 3 type of long-range attack: simple/retired/bleeding;
- several countermeasures and evaluation via analyzing;

---

#### **Consensus-Attack**: [Proof-of-Stake at Stake: Predatory, Destructive Attack on PoS Cryptocurrencies](./archive/2025/papers/blockchainn20-pos-attack-coin/pos-attack-coin.md)

Abstract:
- CCF-A, blockchainn20
- A saying goes: Consensus Attack in PoS in not profitable since performing attack need a lot of native token(staking power) and a successful attack would result in value decrease of the native token. 
- But Attacker can actually do the **shorting/short selling** to earn profits.

---

#### **Consensus-Attack**: [Evaluating Attack Thresholds in Proof of Stake Blockchain Consensus Protocols](./archive/2025/papers/ccf-none/PoS-thresholds/PoS-threshold.md)

Abstract:
- Evaluate if validators can accumulate 1/3 stake in a classical PoS system.

---

#### **Consensus**: [The Forking Way: When TEEs Meet Consensus](./archive/2025/papers/ndss25-TEE-Consensus/tee-consensus.md)

Abstract:
- CCF-A, NDSS25
- TEE x Blockchain Applications are divided into 4 types: contract / consensus / L2 / apps;
- Mitigations: stateless / ephemeral IDs / whitelist matual trust or detection / rely on chain for serializing; 

---

#### **Consensus**: [Everything is a Race and Nakamoto Always Wins](./archive/2025/papers/ccs20-nakamoto-analysis/nakamoto-analysis.md)

Abstract:
- CCS 20, David Tse, Analytical works of Nakamoto Consensus
- To prove Private-Double-Spending is the worst case of Consensus Attack;
- Combine true threshold with private-attack threshold with two novel and un-realistic concepts: blocktree partitioning and nakamoto blocks.

---

#### **Consensus**: [Nakamoto Consensus under Bounded Processing Capacity](./archive/2025/papers/ccs24-nakamoto-bounded/nakamoto-bounded.md)

Abstract:
- CCS24, David Tse, Analytical works of Nakamoto Consensus.
- Teasing Attack, use network strategies to slow down honest validators.

---

#### NExt

####

### Materials

---

#### **Consensus**: [Ethereum Spec Basic](./archive/2025/materials/eth2book/eth2book-3.2-types.md)

Abstract:
- basic elements within consensus implementations;
- commented specification.

---

#### **Consensus**: [Weak Subjectivity](./archive/2025/materials/blog-Weak-Subjectivity/weak-subjectivity.md)

Abstract:
- VB at 2014 proposed Weak Subjectivity which tried to address nothing-at-stake and long-range attack problem.
- The security of the chain is relied on social consensus, exteral information.
- Ethereum consensus is not fully rule-based and is not economically self-contain.

---

#### **Consensus**: [Weak Subjectivity: Concerns](./archive/2025/materials/blog-Weak-Subjectivity/weak-subjectivity-concern.md)

Abstract:
- Is Weak Subjectivity necessary? How to attack it?
- Attack in private.

---

#### **Consensus**: [**Pending**: Weak Subjectivity in Ethereum](./archive/2025/materials/blog-Weak-Subjectivity/weak-subjectivity-ethereum.md)

Abstract:
- How ethereum implements the WS;
- kind of hard to understand, **Pending**.

---

#### **Consensus**: [Ethereum Book Consensus](./archive/2025/materials/eth2book/eth2book-2.3.1-consensus.md)

Abstract:
- basic ideas of Ethereum Consensus and some preliminaries of consensus.
- Contains a lot of meaningful reading list.
- [More](./archive/2025/materials/eth2book/eth2book-2.3.2-consensus.md)
- [More Again](./archive/2025/materials/eth2book/eth2book-2.3.3-4-consensus.md)

---

#### **Consensus**: [Ethereum Book Staking](./archive/2025/materials/eth2book/eth2book-2.3.7-staking.md)

Abstract:
- 


---



### Practice

---

#### **Ethereum Simulation**: [time-driven simulation framework](https://github.com/iiins0mn1a/EthereumSim/commit/1c8c4e1e8e02f1c8cc627d979b7bb735178ce447)
- Add time-fixed event to compatible original design.

---

#### **LLM RCE**: [LLM RCE Course Paper](https://sharelatex.cstcloud.cn/project/67e15e811bf7c4bc4f7dbff3)
- Intro: Research Context / Gap;
- Related work: MCP / IsolateGPT / LLM-RCE-Frameworks

---

#### **Ethereum Simulation**: [**Doing**: decoupling nodes' behavior from consensu package]()
- Leveraging go interface, we can decouple the nodes' behavior from a package
- provide a better framework for diff nodes like malicious node behavior.
- GO interface learning:

---


## Main: 2025 Fall

## Branch: Recognition of the World
- Game: 
    - [**Doing**: From Death Stranding to Flow](./archive/2025/Game/DS/deathstranding.md)
    - Love: [TBD] Combine Love with some Game
- Personality: [**Doing**: Being Aggressive](./archive/2025/Personality/Aggressive.md)
- AI-Driven Applicaions


## Tech Tips
- [Bash](./TechTips/bash.md)
- [C](./TechTips/c.md)
- [GDB](./TechTips/gdb.md)
- [git](./TechTips/git.md)
- [Python](./TechTips/python.md)
- [qemu](./TechTips/qemu.md)
- [ssh](./TechTips/ssh.md)
- [go](./TechTips/go.md)
- [docker](./TechTips/docker.md)

## Time before
- [2022](./archive/2022/summary.md)
- [2023](./archive/2023/summary.md)