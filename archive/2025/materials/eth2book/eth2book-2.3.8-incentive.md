# Incentive Layer
[link](https://eth2book.info/capella/part2/incentives/)

## Overall
Tips:
- cryptography enforces correct behaviour where possible; economics incentivises correct behaviour where it cannot be enforced.
- we cover these about incentive mechanism:
    - (1) rewards for behaviour that helps the protocol, 
    - (2) penalties for behaviour that hinders the protocol, and 
    - (3) punishments for behaviour that looks like an attack on the protocol.
- PoW is economically simple;
- While PoS adds lots of economical issues:
    - Staking;
    - validator balance;
    - issuance;
    - rewards;
    - penalties: reducing rewards;
    - inactivity leak;
    - slashing: reducing stake;
- Recently, a validator is involved into more complex situation like Restaking, making slashing maybe not enough to guide the validator to behave well in the consensus layer.
    - For example, a validator behaved **economically rationally** when it got itself slashed (at a cost of 1 ETH) to gain around [$20 million](https://collective.flashbots.net/t/post-mortem-april-3rd-2023-mev-boost-relay-incident-and-related-timing-issue/1540) of MEV income, although it acted dishonestly by the protocol rules in doing so.
## Staking
## Balance
## Issuance
## Rewards
## Penalties
## Inactivity Leak
## Slashing
## Diversity


# Reading:
- [$20 million: Bad Proposer](https://collective.flashbots.net/t/post-mortem-april-3rd-2023-mev-boost-relay-incident-and-related-timing-issue/1540)
