# Interesting Funcs

ShouldOverrideFCU:
- ReorgHeadWeightThreshold / ReorgParentWeightThreshold related;
- would be called when:
    - It is immediately after receiving a block that may be subject to a reorg
    - It is right after processAttestationsThreshold and we have processed the current slots attestations.
    - The caller has already called Forkchoice.Head() so that forkchoice has been updated.
    - The beacon node is serving a validator that will propose during the next slot.

# reading:
- types.go：理解 Checkpoint、BlockAndCheckpoints、区块节点等结构。
- forkchoice.go / forkchoice_state.go（或类似文件）：查找 ForkChoice/ForkChoiceState 的定义和主流程。
- InsertBlock/ProcessAttestation/GetHead 等方法：理解区块插入、投票处理、链头选择的具体实现。
- 投票权重的更新与递归选择：重点关注 LMD-GHOST 的递归遍历实现。
justified/finalized checkpoint 的推进逻辑。

## Data Structs and Paras:
["Configurable"](https://github.com/ethereum/eth2.0-specs/blob/v0.10.0/specs/phase0/beacon-chain.md#configuration)
- Actually, these paras should not be altered during the lifetime of the chain.
- Changing of the config should only happen between chains.
- While some of the config would not result such fork...
    - like `proposer_score_boost` etc.

Twn maintained configs:
- minimal: a faster version for small scale test;
- mainnet: mainnet;

Beacon Operations:
- proposerslashing proof;
- attesterslashing proof;
- attestation: vote;
    - one per epoch'
- deposit;
- VoluntaryExit;

AttestationData:
- slot / committeeIndex;
- GHOST vote / FFG Vote;

BeaconBlock
- slot
- parent_root
- state_root: post state before running this block;
- BeaconBlockBody

BeaconBlockBody:
- randao_reveal;
- eth1_data;
- graffiti;
- operation_lists;
- **execution_payloads**;

BeaconState:
- the **result hash** for all history;
- we can obtain current BeaconState with `genesis_state`+`all blocks after genesis' exec`


## Modules

### State Trans
- **new_state = state_transition(old_state, new_block)**
- pre-state(new_block) == old_state
- post-state(new_block) == new_state

### Fork CHoice Rule
- Head = ForkChoiceRule(local_tree)
- Chain(Head) = Canonical Chain

### Validator Responsibilites
Key 3 duties:
- vote(once per epoch)
- aggregate(occasionally)
- build blocks(infrequently)

committees:
- are **randomly** shuffled according to Beacon RNG;
- assigned at epoch boundary, (defined **1 epoch in advance to allow for preparation**)
- a subset is assigned to aggregate **similar** votes;

Proposer:
- are randomly picked
- via `get_beacon_proposer_index` to be a proposer;
- Proposal assignments are only known **within the current epoch**;

**Not Instant Exile**:
- do not immediately result in the re-assignment of committees/shuffling. This is to ensure the stability of responsibilities during each epoch – stability needs to be prioritized to ensure sufficient lookahead on duties.

###

### Finality

### Shard Trans

# Insights:
- SSZ and its consensus objective.