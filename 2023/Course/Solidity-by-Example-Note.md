# Solidity by Example - Note

## Prefix

This is the link for the original artical from documentation of **solidity**:[solidity-by-example](https://docs.soliditylang.org/en/v0.8.21/solidity-by-example.html). In fact, we can find more useful knowledge about this language to reflect the whole ecosystem about Blockchain, since most of applications are developed by this specific language.

I spent couple of days to learn basic ideas about blockchain and of cource the dominant programming languge _Solidity_, and I hope that this blog could work on recapping the whole knowledge system about it and maybe would also be benifitial to others like me, who wanna try to get into this area, namely, blockchain.

## Voting

Here follows a contract which implements a voting system. And we can modify or read source code of this contract in this link with Web-based IDE Remix:

- The link:
  [Remix: Voting Contract](https://remix.ethereum.org/?#language=solidity&version=0.8.21&code=Ly8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0zLjAKcHJhZ21hIHNvbGlkaXR5ID49MC43LjAgPDAuOS4wOwovLy8gQHRpdGxlIFZvdGluZyB3aXRoIGRlbGVnYXRpb24uCmNvbnRyYWN0IEJhbGxvdCB7CiAgICAvLyBUaGlzIGRlY2xhcmVzIGEgbmV3IGNvbXBsZXggdHlwZSB3aGljaCB3aWxsCiAgICAvLyBiZSB1c2VkIGZvciB2YXJpYWJsZXMgbGF0ZXIuCiAgICAvLyBJdCB3aWxsIHJlcHJlc2VudCBhIHNpbmdsZSB2b3Rlci4KICAgIHN0cnVjdCBWb3RlciB7CiAgICAgICAgdWludCB3ZWlnaHQ7IC8vIHdlaWdodCBpcyBhY2N1bXVsYXRlZCBieSBkZWxlZ2F0aW9uCiAgICAgICAgYm9vbCB2b3RlZDsgIC8vIGlmIHRydWUsIHRoYXQgcGVyc29uIGFscmVhZHkgdm90ZWQKICAgICAgICBhZGRyZXNzIGRlbGVnYXRlOyAvLyBwZXJzb24gZGVsZWdhdGVkIHRvCiAgICAgICAgdWludCB2b3RlOyAgIC8vIGluZGV4IG9mIHRoZSB2b3RlZCBwcm9wb3NhbAogICAgfQoKICAgIC8vIFRoaXMgaXMgYSB0eXBlIGZvciBhIHNpbmdsZSBwcm9wb3NhbC4KICAgIHN0cnVjdCBQcm9wb3NhbCB7CiAgICAgICAgYnl0ZXMzMiBuYW1lOyAgIC8vIHNob3J0IG5hbWUgKHVwIHRvIDMyIGJ5dGVzKQogICAgICAgIHVpbnQgdm90ZUNvdW50OyAvLyBudW1iZXIgb2YgYWNjdW11bGF0ZWQgdm90ZXMKICAgIH0KCiAgICBhZGRyZXNzIHB1YmxpYyBjaGFpcnBlcnNvbjsKCiAgICAvLyBUaGlzIGRlY2xhcmVzIGEgc3RhdGUgdmFyaWFibGUgdGhhdAogICAgLy8gc3RvcmVzIGEgYFZvdGVyYCBzdHJ1Y3QgZm9yIGVhY2ggcG9zc2libGUgYWRkcmVzcy4KICAgIG1hcHBpbmcoYWRkcmVzcyA9PiBWb3RlcikgcHVibGljIHZvdGVyczsKCiAgICAvLyBBIGR5bmFtaWNhbGx5LXNpemVkIGFycmF5IG9mIGBQcm9wb3NhbGAgc3RydWN0cy4KICAgIFByb3Bvc2FsW10gcHVibGljIHByb3Bvc2FsczsKCiAgICAvLy8gQ3JlYXRlIGEgbmV3IGJhbGxvdCB0byBjaG9vc2Ugb25lIG9mIGBwcm9wb3NhbE5hbWVzYC4KICAgIGNvbnN0cnVjdG9yKGJ5dGVzMzJbXSBtZW1vcnkgcHJvcG9zYWxOYW1lcykgewogICAgICAgIGNoYWlycGVyc29uID0gbXNnLnNlbmRlcjsKICAgICAgICB2b3RlcnNbY2hhaXJwZXJzb25dLndlaWdodCA9IDE7CgogICAgICAgIC8vIEZvciBlYWNoIG9mIHRoZSBwcm92aWRlZCBwcm9wb3NhbCBuYW1lcywKICAgICAgICAvLyBjcmVhdGUgYSBuZXcgcHJvcG9zYWwgb2JqZWN0IGFuZCBhZGQgaXQKICAgICAgICAvLyB0byB0aGUgZW5kIG9mIHRoZSBhcnJheS4KICAgICAgICBmb3IgKHVpbnQgaSA9IDA7IGkgPCBwcm9wb3NhbE5hbWVzLmxlbmd0aDsgaSsrKSB7CiAgICAgICAgICAgIC8vIGBQcm9wb3NhbCh7Li4ufSlgIGNyZWF0ZXMgYSB0ZW1wb3JhcnkKICAgICAgICAgICAgLy8gUHJvcG9zYWwgb2JqZWN0IGFuZCBgcHJvcG9zYWxzLnB1c2goLi4uKWAKICAgICAgICAgICAgLy8gYXBwZW5kcyBpdCB0byB0aGUgZW5kIG9mIGBwcm9wb3NhbHNgLgogICAgICAgICAgICBwcm9wb3NhbHMucHVzaChQcm9wb3NhbCh7CiAgICAgICAgICAgICAgICBuYW1lOiBwcm9wb3NhbE5hbWVzW2ldLAogICAgICAgICAgICAgICAgdm90ZUNvdW50OiAwCiAgICAgICAgICAgIH0pKTsKICAgICAgICB9CiAgICB9CgogICAgLy8gR2l2ZSBgdm90ZXJgIHRoZSByaWdodCB0byB2b3RlIG9uIHRoaXMgYmFsbG90LgogICAgLy8gTWF5IG9ubHkgYmUgY2FsbGVkIGJ5IGBjaGFpcnBlcnNvbmAuCiAgICBmdW5jdGlvbiBnaXZlUmlnaHRUb1ZvdGUoYWRkcmVzcyB2b3RlcikgZXh0ZXJuYWwgewogICAgICAgIC8vIElmIHRoZSBmaXJzdCBhcmd1bWVudCBvZiBgcmVxdWlyZWAgZXZhbHVhdGVzCiAgICAgICAgLy8gdG8gYGZhbHNlYCwgZXhlY3V0aW9uIHRlcm1pbmF0ZXMgYW5kIGFsbAogICAgICAgIC8vIGNoYW5nZXMgdG8gdGhlIHN0YXRlIGFuZCB0byBFdGhlciBiYWxhbmNlcwogICAgICAgIC8vIGFyZSByZXZlcnRlZC4KICAgICAgICAvLyBUaGlzIHVzZWQgdG8gY29uc3VtZSBhbGwgZ2FzIGluIG9sZCBFVk0gdmVyc2lvbnMsIGJ1dAogICAgICAgIC8vIG5vdCBhbnltb3JlLgogICAgICAgIC8vIEl0IGlzIG9mdGVuIGEgZ29vZCBpZGVhIHRvIHVzZSBgcmVxdWlyZWAgdG8gY2hlY2sgaWYKICAgICAgICAvLyBmdW5jdGlvbnMgYXJlIGNhbGxlZCBjb3JyZWN0bHkuCiAgICAgICAgLy8gQXMgYSBzZWNvbmQgYXJndW1lbnQsIHlvdSBjYW4gYWxzbyBwcm92aWRlIGFuCiAgICAgICAgLy8gZXhwbGFuYXRpb24gYWJvdXQgd2hhdCB3ZW50IHdyb25nLgogICAgICAgIHJlcXVpcmUoCiAgICAgICAgICAgIG1zZy5zZW5kZXIgPT0gY2hhaXJwZXJzb24sCiAgICAgICAgICAgICJPbmx5IGNoYWlycGVyc29uIGNhbiBnaXZlIHJpZ2h0IHRvIHZvdGUuIgogICAgICAgICk7CiAgICAgICAgcmVxdWlyZSgKICAgICAgICAgICAgIXZvdGVyc1t2b3Rlcl0udm90ZWQsCiAgICAgICAgICAgICJUaGUgdm90ZXIgYWxyZWFkeSB2b3RlZC4iCiAgICAgICAgKTsKICAgICAgICByZXF1aXJlKHZvdGVyc1t2b3Rlcl0ud2VpZ2h0ID09IDApOwogICAgICAgIHZvdGVyc1t2b3Rlcl0ud2VpZ2h0ID0gMTsKICAgIH0KCiAgICAvLy8gRGVsZWdhdGUgeW91ciB2b3RlIHRvIHRoZSB2b3RlciBgdG9gLgogICAgZnVuY3Rpb24gZGVsZWdhdGUoYWRkcmVzcyB0bykgZXh0ZXJuYWwgewogICAgICAgIC8vIGFzc2lnbnMgcmVmZXJlbmNlCiAgICAgICAgVm90ZXIgc3RvcmFnZSBzZW5kZXIgPSB2b3RlcnNbbXNnLnNlbmRlcl07CiAgICAgICAgcmVxdWlyZShzZW5kZXIud2VpZ2h0ICE9IDAsICJZb3UgaGF2ZSBubyByaWdodCB0byB2b3RlIik7CiAgICAgICAgcmVxdWlyZSghc2VuZGVyLnZvdGVkLCAiWW91IGFscmVhZHkgdm90ZWQuIik7CgogICAgICAgIHJlcXVpcmUodG8gIT0gbXNnLnNlbmRlciwgIlNlbGYtZGVsZWdhdGlvbiBpcyBkaXNhbGxvd2VkLiIpOwoKICAgICAgICAvLyBGb3J3YXJkIHRoZSBkZWxlZ2F0aW9uIGFzIGxvbmcgYXMKICAgICAgICAvLyBgdG9gIGFsc28gZGVsZWdhdGVkLgogICAgICAgIC8vIEluIGdlbmVyYWwsIHN1Y2ggbG9vcHMgYXJlIHZlcnkgZGFuZ2Vyb3VzLAogICAgICAgIC8vIGJlY2F1c2UgaWYgdGhleSBydW4gdG9vIGxvbmcsIHRoZXkgbWlnaHQKICAgICAgICAvLyBuZWVkIG1vcmUgZ2FzIHRoYW4gaXMgYXZhaWxhYmxlIGluIGEgYmxvY2suCiAgICAgICAgLy8gSW4gdGhpcyBjYXNlLCB0aGUgZGVsZWdhdGlvbiB3aWxsIG5vdCBiZSBleGVjdXRlZCwKICAgICAgICAvLyBidXQgaW4gb3RoZXIgc2l0dWF0aW9ucywgc3VjaCBsb29wcyBtaWdodAogICAgICAgIC8vIGNhdXNlIGEgY29udHJhY3QgdG8gZ2V0ICJzdHVjayIgY29tcGxldGVseS4KICAgICAgICB3aGlsZSAodm90ZXJzW3RvXS5kZWxlZ2F0ZSAhPSBhZGRyZXNzKDApKSB7CiAgICAgICAgICAgIHRvID0gdm90ZXJzW3RvXS5kZWxlZ2F0ZTsKCiAgICAgICAgICAgIC8vIFdlIGZvdW5kIGEgbG9vcCBpbiB0aGUgZGVsZWdhdGlvbiwgbm90IGFsbG93ZWQuCiAgICAgICAgICAgIHJlcXVpcmUodG8gIT0gbXNnLnNlbmRlciwgIkZvdW5kIGxvb3AgaW4gZGVsZWdhdGlvbi4iKTsKICAgICAgICB9CgogICAgICAgIFZvdGVyIHN0b3JhZ2UgZGVsZWdhdGVfID0gdm90ZXJzW3RvXTsKCiAgICAgICAgLy8gVm90ZXJzIGNhbm5vdCBkZWxlZ2F0ZSB0byBhY2NvdW50cyB0aGF0IGNhbm5vdCB2b3RlLgogICAgICAgIHJlcXVpcmUoZGVsZWdhdGVfLndlaWdodCA+PSAxKTsKCiAgICAgICAgLy8gU2luY2UgYHNlbmRlcmAgaXMgYSByZWZlcmVuY2UsIHRoaXMKICAgICAgICAvLyBtb2RpZmllcyBgdm90ZXJzW21zZy5zZW5kZXJdYC4KICAgICAgICBzZW5kZXIudm90ZWQgPSB0cnVlOwogICAgICAgIHNlbmRlci5kZWxlZ2F0ZSA9IHRvOwoKICAgICAgICBpZiAoZGVsZWdhdGVfLnZvdGVkKSB7CiAgICAgICAgICAgIC8vIElmIHRoZSBkZWxlZ2F0ZSBhbHJlYWR5IHZvdGVkLAogICAgICAgICAgICAvLyBkaXJlY3RseSBhZGQgdG8gdGhlIG51bWJlciBvZiB2b3RlcwogICAgICAgICAgICBwcm9wb3NhbHNbZGVsZWdhdGVfLnZvdGVdLnZvdGVDb3VudCArPSBzZW5kZXIud2VpZ2h0OwogICAgICAgIH0gZWxzZSB7CiAgICAgICAgICAgIC8vIElmIHRoZSBkZWxlZ2F0ZSBkaWQgbm90IHZvdGUgeWV0LAogICAgICAgICAgICAvLyBhZGQgdG8gaGVyIHdlaWdodC4KICAgICAgICAgICAgZGVsZWdhdGVfLndlaWdodCArPSBzZW5kZXIud2VpZ2h0OwogICAgICAgIH0KICAgIH0KCiAgICAvLy8gR2l2ZSB5b3VyIHZvdGUgKGluY2x1ZGluZyB2b3RlcyBkZWxlZ2F0ZWQgdG8geW91KQogICAgLy8vIHRvIHByb3Bvc2FsIGBwcm9wb3NhbHNbcHJvcG9zYWxdLm5hbWVgLgogICAgZnVuY3Rpb24gdm90ZSh1aW50IHByb3Bvc2FsKSBleHRlcm5hbCB7CiAgICAgICAgVm90ZXIgc3RvcmFnZSBzZW5kZXIgPSB2b3RlcnNbbXNnLnNlbmRlcl07CiAgICAgICAgcmVxdWlyZShzZW5kZXIud2VpZ2h0ICE9IDAsICJIYXMgbm8gcmlnaHQgdG8gdm90ZSIpOwogICAgICAgIHJlcXVpcmUoIXNlbmRlci52b3RlZCwgIkFscmVhZHkgdm90ZWQuIik7CiAgICAgICAgc2VuZGVyLnZvdGVkID0gdHJ1ZTsKICAgICAgICBzZW5kZXIudm90ZSA9IHByb3Bvc2FsOwoKICAgICAgICAvLyBJZiBgcHJvcG9zYWxgIGlzIG91dCBvZiB0aGUgcmFuZ2Ugb2YgdGhlIGFycmF5LAogICAgICAgIC8vIHRoaXMgd2lsbCB0aHJvdyBhdXRvbWF0aWNhbGx5IGFuZCByZXZlcnQgYWxsCiAgICAgICAgLy8gY2hhbmdlcy4KICAgICAgICBwcm9wb3NhbHNbcHJvcG9zYWxdLnZvdGVDb3VudCArPSBzZW5kZXIud2VpZ2h0OwogICAgfQoKICAgIC8vLyBAZGV2IENvbXB1dGVzIHRoZSB3aW5uaW5nIHByb3Bvc2FsIHRha2luZyBhbGwKICAgIC8vLyBwcmV2aW91cyB2b3RlcyBpbnRvIGFjY291bnQuCiAgICBmdW5jdGlvbiB3aW5uaW5nUHJvcG9zYWwoKSBwdWJsaWMgdmlldwogICAgICAgICAgICByZXR1cm5zICh1aW50IHdpbm5pbmdQcm9wb3NhbF8pCiAgICB7CiAgICAgICAgdWludCB3aW5uaW5nVm90ZUNvdW50ID0gMDsKICAgICAgICBmb3IgKHVpbnQgcCA9IDA7IHAgPCBwcm9wb3NhbHMubGVuZ3RoOyBwKyspIHsKICAgICAgICAgICAgaWYgKHByb3Bvc2Fsc1twXS52b3RlQ291bnQgPiB3aW5uaW5nVm90ZUNvdW50KSB7CiAgICAgICAgICAgICAgICB3aW5uaW5nVm90ZUNvdW50ID0gcHJvcG9zYWxzW3BdLnZvdGVDb3VudDsKICAgICAgICAgICAgICAgIHdpbm5pbmdQcm9wb3NhbF8gPSBwOwogICAgICAgICAgICB9CiAgICAgICAgfQogICAgfQoKICAgIC8vIENhbGxzIHdpbm5pbmdQcm9wb3NhbCgpIGZ1bmN0aW9uIHRvIGdldCB0aGUgaW5kZXgKICAgIC8vIG9mIHRoZSB3aW5uZXIgY29udGFpbmVkIGluIHRoZSBwcm9wb3NhbHMgYXJyYXkgYW5kIHRoZW4KICAgIC8vIHJldHVybnMgdGhlIG5hbWUgb2YgdGhlIHdpbm5lcgogICAgZnVuY3Rpb24gd2lubmVyTmFtZSgpIGV4dGVybmFsIHZpZXcKICAgICAgICAgICAgcmV0dXJucyAoYnl0ZXMzMiB3aW5uZXJOYW1lXykKICAgIHsKICAgICAgICB3aW5uZXJOYW1lXyA9IHByb3Bvc2Fsc1t3aW5uaW5nUHJvcG9zYWwoKV0ubmFtZTsKICAgIH0KfQ==)

I also copied the code here for convenience.

```
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;
/// @title Voting with delegation.
contract Ballot {
    // This declares a new complex type which will
    // be used for variables later.
    // It will represent a single voter.
    struct Voter {
        uint weight; // weight is accumulated by delegation
        bool voted;  // if true, that person already voted
        address delegate; // person delegated to
        uint vote;   // index of the voted proposal
    }

    // This is a type for a single proposal.
    struct Proposal {
        bytes32 name;   // short name (up to 32 bytes)
        uint voteCount; // number of accumulated votes
    }

    address public chairperson;

    // This declares a state variable that
    // stores a `Voter` struct for each possible address.
    mapping(address => Voter) public voters;

    // A dynamically-sized array of `Proposal` structs.
    Proposal[] public proposals;

    /// Create a new ballot to choose one of `proposalNames`.
    constructor(bytes32[] memory proposalNames) {
        chairperson = msg.sender;
        voters[chairperson].weight = 1;

        // For each of the provided proposal names,
        // create a new proposal object and add it
        // to the end of the array.
        for (uint i = 0; i < proposalNames.length; i++) {
            // `Proposal({...})` creates a temporary
            // Proposal object and `proposals.push(...)`
            // appends it to the end of `proposals`.
            proposals.push(Proposal({
                name: proposalNames[i],
                voteCount: 0
            }));
        }
    }

    // Give `voter` the right to vote on this ballot.
    // May only be called by `chairperson`.
    function giveRightToVote(address voter) external {
        // If the first argument of `require` evaluates
        // to `false`, execution terminates and all
        // changes to the state and to Ether balances
        // are reverted.
        // This used to consume all gas in old EVM versions, but
        // not anymore.
        // It is often a good idea to use `require` to check if
        // functions are called correctly.
        // As a second argument, you can also provide an
        // explanation about what went wrong.
        require(
            msg.sender == chairperson,
            "Only chairperson can give right to vote."
        );
        require(
            !voters[voter].voted,
            "The voter already voted."
        );
        require(voters[voter].weight == 0);
        voters[voter].weight = 1;
    }

    /// Delegate your vote to the voter `to`.
    function delegate(address to) external {
        // assigns reference
        Voter storage sender = voters[msg.sender];
        require(sender.weight != 0, "You have no right to vote");
        require(!sender.voted, "You already voted.");

        require(to != msg.sender, "Self-delegation is disallowed.");

        // Forward the delegation as long as
        // `to` also delegated.
        // In general, such loops are very dangerous,
        // because if they run too long, they might
        // need more gas than is available in a block.
        // In this case, the delegation will not be executed,
        // but in other situations, such loops might
        // cause a contract to get "stuck" completely.
        while (voters[to].delegate != address(0)) {
            to = voters[to].delegate;

            // We found a loop in the delegation, not allowed.
            require(to != msg.sender, "Found loop in delegation.");
        }

        Voter storage delegate_ = voters[to];

        // Voters cannot delegate to accounts that cannot vote.
        require(delegate_.weight >= 1);

        // Since `sender` is a reference, this
        // modifies `voters[msg.sender]`.
        sender.voted = true;
        sender.delegate = to;

        if (delegate_.voted) {
            // If the delegate already voted,
            // directly add to the number of votes
            proposals[delegate_.vote].voteCount += sender.weight;
        } else {
            // If the delegate did not vote yet,
            // add to her weight.
            delegate_.weight += sender.weight;
        }
    }

    /// Give your vote (including votes delegated to you)
    /// to proposal `proposals[proposal].name`.
    function vote(uint proposal) external {
        Voter storage sender = voters[msg.sender];
        require(sender.weight != 0, "Has no right to vote");
        require(!sender.voted, "Already voted.");
        sender.voted = true;
        sender.vote = proposal;

        // If `proposal` is out of the range of the array,
        // this will throw automatically and revert all
        // changes.
        proposals[proposal].voteCount += sender.weight;
    }

    /// @dev Computes the winning proposal taking all
    /// previous votes into account.
    function winningProposal() public view
            returns (uint winningProposal_)
    {
        uint winningVoteCount = 0;
        for (uint p = 0; p < proposals.length; p++) {
            if (proposals[p].voteCount > winningVoteCount) {
                winningVoteCount = proposals[p].voteCount;
                winningProposal_ = p;
            }
        }
    }

    // Calls winningProposal() function to get the index
    // of the winner contained in the proposals array and then
    // returns the name of the winner
    function winnerName() external view
            returns (bytes32 winnerName_)
    {
        winnerName_ = proposals[winningProposal()].name;
    }
}
```

### Design

This system shows the procedure of voting is **automatic** and completely **transparent**.

There are two subjects in this system, chairperson and normal voters. And they have their own responsibility.

- chairperson:
  - stage-0: preparing
    - deploy this voting system;
    - satisfy the constructor with argument `bytes21[] memory proposalNames[]`;
      - this would use `struct Proposal` to instantiate a real one in the system;
    - set `address public chairperson` to self. And allow self to vote.
    - instantiate all proposals by the argu.
  - stage-1: voting
    - as the chairperson, determine the participants.
      - use an address to authorize a person to be voter.
    - increase their voting weight from 0 to 1;
- Voters:
  - no need for stage-0, they are just participants.
  - stage-1: voting
    - vote:
      - fetch the ticket(instantiation of voter `Voter`) from ticket box(`voters[]`);
      - vote;
    - delegate:
      - migrate your own weight to another one;
      - what if another one wanna delegate their weight, then migrate to this one's delegate target.

### Features:

- `struct{ ...; }`
  use `struct` to instantiate voter and proposal with human provided information.
- global variable
  `chairperson`, the special one should be marked clearly.
- `mapping(Type_A => Type_B) public maps;`
  use `mapping` to build the relationship between EOA and their instantiation, specifically, between `address` and `struct Voter`
- `memory` variable signature
  for local array/ structs, use signature "`storage`" or "`memory`";
- `struct` quick instantiation
  <Struct_Name>( { <Field1>: value1, <Field2>: value2 } )
- `external` function signature
  can be only called by outside issue, instead of internal one.
- `public` signature
  can be accessed / called by anyone.
- `view` function signature
  this function would be only used for **informantion reading**;
  can only call function with `view` or `pure`
- `pure` function signature
  No State Access, this function would not even read the state of blocks and would only perform computation issues with arguments.

## TBD
