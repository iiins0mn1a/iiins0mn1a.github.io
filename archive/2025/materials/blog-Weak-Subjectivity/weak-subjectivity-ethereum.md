# Gasper's Dynamic Validator Set
the current Ethereum 2.0 spec, for example, does not accept attestations 2 or more epochs old, which avoids this long-range attack.

# Weak-Subjectivity Checkpoint
[eth-weak-subjectivety-analysis](https://notes.ethereum.org/@adiasg/weak-subjectvity-eth2)
LIke a Genesis Block at a non-genesis position in the chain.

Weak Subjectivity Period:
- The weak subjectivity period is the number of recent epochs within which there must be a weak subjectivity chekpoint so that an attacker who takes control of the validator set at the beginning of the period is slashed at least a threshold amount in case a conflicting finalized checkpoint is produced.
    - e.g. we set period to 100 epochs. Then, within 100 epochs there must be a WS checkpoint. We are in epoch 1100 right now, then in the period from epoch 1001 to epoch 1100, there must be a checkpoint.
    - Les's assume the WS checkpoint in epoch 1002. Then attackers' double voting in epoch 1001 would be slashed for sure.
    - e.g. we have 1/3 attacker power, at epoch 1001, and we perform normally until epoch 1010, and we withdraw our staking from 1011 to 1160, we have our money back in 1161 and after a long time, it's 1200 now.
    - our 1/3 staking power is still useful in epoch 1001, then we can perform double voting right now, since nothing-at-stake. all money is in our pocket, launch another fork can slash nothing.
    - But even we lunch a new fork in epoch 1001. With WS period, which is shorter than withdrawal delay, we can ensure to have a WS checkpoint within 100 epochs from 1101 to 1200. Then the attackers' new fork from 1001 will be treated as invalid for honest nodes.

And for dynamic validator set. Let's assume **safety decay** `D`. 




# Insight:
- YES: genesis is “irreversible”, “finalized”, “un-orphanable”, or whatever else you’d like to call a block that is always found in the canonical chain.
- BUT: reverting genesis block is un-profitable, no motivation. But revert a checkpoint can sometimes be profitable.
- Can Long-range be detected? if yes, why we need WS?
    - Yes for online validator.
    - But No for new nodes.