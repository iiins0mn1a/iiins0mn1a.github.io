[eth2book-2.3.2-consensus-overview](https://eth2book.info/capella/part2/consensus/overview/)

# Consensus

## Terminology 

### Nodes and Validators:
- **Node**: main participants in the Ethereum network are nodes.A node's role is to *validate* consensus and form the *communication* backbone with other nodes.
- **Validator**: Consensus is formed by validators, which (in true Ethereum style) are horribly misnamed, as they don't really validate anything - that's done by the nodes.
- A validator means 32 ETH stake.
- Validators are attached to nodes, and **a single node can host a lot of** validators.
- Validators attached to the same node do not act independently, they share the same view of the world.
- under PoS, we know our validator set. We have **a complete list of all the public keys** that we expect to be active at any time. Knowing our validator set enables us to achieve finality, as we can identify when we have achieved a majority vote of participants.

### Slots and Epochs
- 1 Epoch = 32 slots = 32 * 12 seconds = 6.4 minutes;

### Blocks and Attestations
- The block contains **updates to the beacon state**, including attestations that the proposer knows about, as well as the execution payload containing Ethereum user transactions.
- The proposer shares its block with the whole network via a gossip protocol.
- an empty slot is allowed when block is missing/reorged/invalid.
- Every epoch, one validator can share its view via Attestation once.
    - LMD-GHOST vote and Casper vote.
- Why **Epoch**?
    - for spreading out the workload of votes.

### Slashing


###

# Reading

# Insights