# Proof of Stake: How I Learned to Love Weak Subjectivity
[blog](https://blog.ethereum.org/2014/11/25/proof-stake-learned-love-weak-subjectivity): Vitalik Buterin on November 25, 2014.

## Abstract
The **core** insight is to make sure the "consensus" is not entirely determined by algorithm, but also social consensus, i.e. "subjectivity". While the consensus also doesn't need too much social info, and this is the reason of "weak".

For me, I think it's a workaround when Consensus Protocol itself can not work properly, i.e. when Long-Range Re-org occurs.

## Note
Context:
- PoS is designed to several benefits: efficiency, a larger security margin and future-proof immunity to **hardware centralization concerns**;
- Key Challenges: **nothing at stake** problem;
- VB claims that: As it turns out, however, the problems are **solvable**, and one can make a rigorous argument that proof of stake, with all its benefits, can be made to be successful - but at a **moderate cost**. 

Economic Sets and Nothing at Stake:
- Consensus is to securely update world state;
- **Economic Set**:
    - a set of users which can be given the right to collectively perform transitions via some algorithm, and the important property that the economic set used for consensus needs to have is that it must be **securely decentralized** - meaning that **no single actor**, or **colluding set** of actors, can take up the majority of the set, even if the actor has a fairly large amount of capital and financial incentive.
    - 3 securely decentralized economic sets:
        - Owners of computing power:
        - Stakeholders
        - A user's social network: **Ripple/Stellar-style consensus**
    - A problem: how to sample M-of-N security model's M in Neo-BFT like Ethereum PoS in current stakeholders ES.
- When PoW faces double-voting:
    - Proof of work has a nice property that makes it much simpler to design effective algorithms for it: participation in the economic set requires the consumption of a resource external to the system. This means that, when contributing one's work to the blockchain, a miner must make the choice of which of all possible forks to contribute to (or whether to try to start a new fork), and the different options are mutually exclusive. Double-voting, including double-voting where the second vote is made many years after the first, is unprofitablem since it requires you to split your mining power among the different votes; the dominant strategy is always to put your mining power exclusively on the fork that you think is most likely to win.
    - if **you wish to compete on old one, you lose your reward right now**. And that's the reason why PoW does't have such problem.
    - participants **have to choose only one correct** chain to compete.
- But in PoS, joining is expensive, **voting is free**;
    - With proof of stake, however, the situation is different. Although inclusion into the economic set may be costly (although as we will see it not always is), voting is free. This means that "naive proof of stake" algorithms, which simply try to copy proof of work by making every coin a "simulated mining rig" with a certain chance per second of making the account that owns it usable for signing a block, have a fatal flaw: if there are multiple forks, the **optimal strategy is to vote on all** forks at once. This is the core of "**nothing at stake**".
- Altruism-prime 利他主义: including real one and fake one;
    - Can Not rely on this along: eg. if there are 1000 stakeholders, and each of their activity has a 1% chance of being "pivotal" in contributing to a successful attack that will knock coin value down to zero, then each stakeholder will accept a bribe equal to only 1% of their holdings;
    - Stakeholders may take evil actions if they've received enough bribe which could make up their expected loss (`== 1% * Held-Stake`).


Short and Long Range Reorgs
- Using security deposits and slashing mechanism, we can force stakeholders to vote on only one fork.
- Slashing: 
    - 1.0: penalize double-vote
    - 2.0: penalize wrong vote
- The reason why this **only works for short-range** forks is simple:
    - the user has to have the right to withdraw the security deposit eventually, and once the deposit is withdrawn there is no longer any incentive not to vote on a long-range fork starting far back in time using those coins.
- Making the deposit permanent?
    - Morally un-acceptable;
- To prevent Long Range: **transactions-as-proof-of-stake**:
    - to combine the Slasher mechanism described above for short-range forks with a backup, transactions-as-proof-of-stake;
    - to use activity status, like **Transaction Fees**;
    - in this case, Long range fork **would only work when atttackers spend a lot of additional Fees**.
- Key Flaw/Game-Theory: 
    - **if we think such case is secure, then it's not secure.**, i.e. expected loss (`== 1% * Held-Stake`);
    - I can do this, I can earn more while the risk is acceptable.
    - if we assume that the probability of an attack succeeding is near-zero, then every signer has an incentive to offer a service of **re-signing all of their transactions onto a new blockchain** in exchange for a small fee; hence, a zero probability of attacks succeeding is not game-theoretically stable.

Because of all the arguments above, we can safely conclude that this threat of an attacker building up a fork from arbitrarily long range is unfortunately fundamental, and in all non-degenerate implementations the issue is fatal to a proof of stake algorithm's success in the proof of work security model. However, we can get around this fundamental barrier with a slight, but nevertheless fundamental, change in the security model.

Weak Subjectivity:
- Two context paradigms:
    - **Objective**: a new node coming onto the network with no knowledge except (i) the *protocol definition* and (ii) the set of all blocks and other "important" messages *(data)* that have been *published* can independently come to the exact same conclusion as the rest of the network on the current state.
    - **Subjective**: the system has stable states where different nodes come to different conclusions, and a large amount of social information (ie. reputation) is required in order to participate.
- Systems that use **social networks** as their consensus set (eg. Ripple) are all necessarily subjective; a new node that knows nothing but the protocol and the data can be convinced by an attacker that their 100000 nodes are trustworthy, and without reputation there is no way to deal with that attack. Proof of work, on the other hand, is objective: the current state is always the state that contains the highest expected amount of proof of work.
    - We assume PoS would always suffers from **Sharding(Conflicting correct chain)** due to LongLong range Attack;
        - In such case, there in no way to distinguish good or bad without repuation info.
    - While PoW would not suffer about such case, since there is only one correct chain.
- To solve such LongLong Range Sharding problem in PoS:
    - **Weakly subjective**: a new node coming onto the network with no knowledge except (i) the protocol definition, (ii) the set of all blocks and other "important" messages that have been published and (iii) **a state from less than N blocks ago that is known to be valid** can independently come to the exact same conclusion as the rest of the network on the current state, unless there is an attacker that permanently has more than X percent control over the consensus set.
    - we simply **forbid nodes from reverting more than N blocks**
    - Set N to he withdrawal length, then the PoS will no longer suffers from LongLong Range Attack;
        - That is to say, if state S has been valid and has become an ancestor of at least N valid states, then from that point on **no state S' which is not a descendant of S can be valid**.
    - no attack can cause permanent disruption unless it lasts more than N blocks
- And an alternative **weakly subjective scoring method**:
    - if a block on a different branch with fewer descendents, then it is less attractive.
    - Essentially, **we explicitly penalize forks that come later**.
    - it mostly avoids permanent network splits;


This security assumption, the idea of "getting a block hash from a friend", may seem unrigorous to many; Bitcoin developers often make the point that if the solution to long-range attacks is some alternative deciding mechanism X, then the security of the blockchain ultimately depends on X, and so the algorithm is in reality no more secure than using X directly - implying that most X, including our **social-consensus-driven approach**, are insecure.

此文发表于 2014 年，说明了 PoS 系统的运行需要我们如何更改安全假设。引人注意的是作者在文章的末段提出的意见：“人类本身非常善于达成共识；共识算法只是加快了达成共识的速度”，这似乎意味着，人类自驱的社会共识，足以支撑一个分布式系统的安全性，而 “弱主观性” 也仅仅是白玉微瑕。但是，人类善于 “达成” 共识吗？并不。小到打官司、政策争论，大到国际争端乃至战争，无一例外都暗示着，人类并不善于达成共识，因为作为共识对象的状态的背后是规则，而人类会不断冲击规则、对规则作出有利于自己的解释，乃至直接破坏规则。因为说到底，人类只是善于发现自己的利益，而不是达成共识，达成共识许多时候只是达成利益的一个步骤，而利益如果转移共识也就会被破坏。回到问题本身，在客观性共识的世界里，“创世块” + 最长链规则，就能确切地定义一种币并解决伪币问题；但在弱主观性的世界里，创世块定义不了币种，要解决伪币问题，除非你从创世块开始就是验证者，否则你只能假手他人。要是一个系统的最新状态的裁决和解读是依赖于一小部分人的，那么不信任这一小部分人的人就根本不会去用这个系统。这就丧失了所谓的 “社会可扩展性”。


# TBD:
Reading:
- Social Network related Consensus:
    - [Ripple vs Stellar: How are These Blockchains Different?](https://www.youhodler.com/blog/ripple-vs-stellar)
    - [Stellar Protocol](https://stellar.org/learn/stellar-consensus-protocol)
- Dynamic Sets of PoS
- [Casper blog](https://coinbureau.com/education/what-is-the-ethereum-casper-pos-protocol/)
- [Casper blog2](https://medium.com/unitychain/intro-to-casper-ffg-9ed944d98b2d)
- [weak subjectivity in Ethereum](https://ethereum.org/en/developers/docs/consensus-mechanisms/pos/weak-subjectivity/)



