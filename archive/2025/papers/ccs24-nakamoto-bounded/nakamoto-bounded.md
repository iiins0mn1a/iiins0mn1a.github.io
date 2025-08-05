# Nakamoto Consensus under Bounded Processing Capacity
## Note
### Abs:
- Previous Models fail to answer the question under specific cases;
- We fill this gap;
- And we find another new type of attack under new cases.
- And we propose a new consensus which is resilient to such attacks;

This paper includes a lot of analytical works reference.

### Intro
In Bitcoin, ideally, a block would be produced every ten mins, and will be downloaded and verified within seconds.

And here is a question, higher block rate would incure heavy burden for nodes to carry out consensus protocol and raise a question about security, i.e. capability of fault tolerance.

**Previous**: 
- **Bounded-Delay Model** which assumes all message would finally be received within the time delay Δ;
- They also consider: 
    - bad fraction: β
    - block rate: λ
- They fail to capture:
    - processing load;

Selfish mining is the worst case? previous works analyze such attacks under low block rates and claim that **ALL OTHER　ＡＴＴＣＫ would fail too**.

**New Attack** out of previous' study' scope:
We propose a new strartegy called Teasing Strategy to add processing loads to target nodes.

**Stronger** than private attack: can be performed on wider configs i.e. block rate, lower bad fraction.

Though the security implications of teasing attack is not that severe, but still a new attack out of the consideration of previous models.

**New model Analysis**:
Then we use such bounded-capacity model to analyze consensus security.

We calculate the new conceptual secure region under new model, where attacker have richer stratrgies including before but also about bounded capacity.

While in PoS settings, equivocations are easier to see since no actual cost except for the proposal lottery.

## Related works so far
Our analysis builds on tools from several of these works:
- primarily pivots [52] 
- Nakamoto blocks [24]
- convergence opportunities [37, 50, 52] (or similar [24, 55]).

This bounded delay model has some limitations like:
- need to find the value of delay bound Δ;
    - set the delay to the time taken to process one block, i.e. 1/C, where C is the speed of block processing;
    - sounds reasonable when blocks rates is lower than capacity, since in most cases queues are empty or only one block;
    - but when they need to queue, the delay time would be larger;
- [27] a **queuing model** is used to calculate a delay bound that holds throughout the execution with overwhelming probability. However, such a tail bound is too pessimistic because the queuing delays cannot always be large, due to limited block production.

## Contribution
Decompose Pivots into pp and cp:
- **Pivots** Analysis: special honest block on the chain forever(safety) and frequently(liveness).
    - Under Bounded-delay model, more hoest block means better honest growth rate, they are equivalent, since network can be stable after GST(bounded delay).
- ppivots: where pivots have more production chance.
- cpivots: where pivots have better groth rate.
    - under bounded-capacity model, **pp** sometimes can not turn into **cp**.
    - 由于网络层影响，诚实验证者的出块机会会无法完全转化为链增长;

High density pp can entail at least one cp;

To show a non-Chernoff-style tail bound analysis to provide high-density argument.

## Teasing Strategy

## NC Protocols and Threat Model

## Security Proof

## New Consensus BlaNC

## Discussion


# Reading
- Nakamoto Bounded delay analysis against selfish mining:
    - [ccs20-David Tse Group: Everything is a Race and Nakamoto Always Wins](https://dl.acm.org/doi/pdf/10.1145/3372297.3417290)
        - [ccs20: Tight Consistency Bounds for Bitcoin](https://dl.acm.org/doi/pdf/10.1145/3372297.3423365)
    - [sp24: Larger-scale Nakamoto-style Blockchains Don’t Necessarily Offer Better Security](https://arxiv.org/pdf/2404.09895)
- [bounded-badwidth nakamoto consensus](https://dl.acm.org/doi/pdf/10.1145/3558535.3559777?casa_token=mu1kMsW-VTsAAAAA:CcDTG_mRQqaLFPBWbuaNh2MLbvplfZ2jPjNu_8BZy42TuBBKQDV5ZzDN-xS7T1UZSzjbnBbz9T2t-w)

# Insights:
- network delay is one important issue for network sec, then we can add node delay to longer the network delay.
