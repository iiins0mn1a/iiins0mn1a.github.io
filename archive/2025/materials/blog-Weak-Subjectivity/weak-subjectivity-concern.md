# My Insights:
- How to determine the checkpoints?
- how to determine valid? what if they are already wrong?
- where to fetch the correct checkpoint?
- what if we just remove withdrawed validators in the history?
- why not just add a large voting window to make the consensus full-sync without loss of liveness?
- how to utilize such revert-forbid to launch attacks?
- Weak Subjectivity:
    - Can avoid the chain to revert to a too old history. And any Short-Range Re-org is still possible when the attacker is willing to pay.
    - Like a cheat to determine which part is correct from external information.

# Concerns
[Verus Chain: Long range-free PoS without subjectivity](https://medium.com/veruscoin/how-verus-solved-nothing-at-stake-and-weak-subjectivity-proof-of-stake-problems-b4dd6a85086e)
- **Probabilistic Finality**: 每个区块的“最终性”不是通过固定检查点确定，而是通过 累积的共识权重 动态计算。随着链的增长，旧区块被确认的概率呈指数级增长，恶意分叉需要极高的成本才能覆盖历史。

[nothing at stake](https://medium.com/coinmonks/understanding-proof-of-stake-the-nothing-at-stake-theory-1f0d71bc027)
Important Assumption:
- It assumes that a validator will seek profit whenever there is an opportunity to do so, even if it is at the expense of the security or quality of the network. This is a standard (and smart) security assumption in the crypto world.
- It assumes that 0 validators will act altruistically (aka no validators will mine on only 1 chain at a time out of the goodness of their hearts).
- It assumes that validators went out of their way to either modify their validation software or download software that someone else modified. Standard validation software will not come with the ability to mine on all forks. This is because standard software comes with an internal logic for choosing a “true” fork when a fork occurs.


[**Weak** Subjectivity](https://academy.binance.com/en/glossary/weak-subjectivity)
- Still, the subjectivity is considered weak because it only occurs in two situations: when new nodes join the network, or when nodes go offline for long periods.

# Insights:
- why we hate block tree? i.e. multiple chains at same time?
- it's because of defi, someone want to connect the virtual world with our real world.