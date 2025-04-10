# Uncle Maker: (Time)Stamping Out The Competition in Ethereum
[the paper](https://dl.acm.org/doi/pdf/10.1145/3576915.3616674)

## Summary

## Notes
Abstract:
- Attack eth1.0 to allow miners's higher rewards.
- This attack is novel in that it relies on manipulating block **timestamps** and the **difficulty-adjustment algorithm (DAA)** to give the miner an advantage whenever block races ensue. We call our attack Uncle Maker, as it induces a higher rate of **uncle blocks**.
- Our attack differs from past attacks such as **Selfish Mining** [30], that have been shown to be profitable but **were never observed in practice**.

Intro:
- Attack:
    - Timestamp manipulation for a higher-difficulty block, which would be preferred by the Ethereum 1's Consensus Algorithm.
    - More profitable than benign choice.
- Claim:
    - Other timestamp attack is only **theoretical** and **low success rate**.
    - Our attack **existes in real** Ethereum.
    - No consensus level manipulation has been observed. 
    - Our attack is the **first Observed Consensus Level Attack** so far.
- DOes:
    - novel attack via novel vector, i.e. not withholding.
    - its effect: risk-less and more or equal profit.
    - Real-one in the wild. First Consensus Attack so far.
    - Feasibility Experiments.
    - Potential Mitigation
![contributions](image.png)


![Attack](image-1.png)
Attack Overview:
- Ethereum 1’s **DAA** causes a slight increase in the difficulty of mining if blocks are mined too quickly, and a slight decrease if blocks are mined too slowly. 
- As clocks are not perfectly synchronized between nodes, **timestamps** are essentially “cheap-talk”. They can be set by miners **as desired**, but are still required to grow monotonically and cannot be too far into the future. This allows block creators to slightly **change the difficulty** of the block. 
-  Such small changes do not make mining much harder, but can affect which block nodes choose to extend in case two **conflicting** blocks of the same height are mined. 
![RUM Attack](image-2.png)


## 存档：
现在能想到的更高收益的原因，就是平衡，出了一个简单快速块之后，诚实验证者会为了平衡而处理高难块而使得我们的攻击可以再次发起。

诚实验证者付出了代价，收益被我们获得？明天再仔细看看，带笔带pad
## Conclusion

## Insights