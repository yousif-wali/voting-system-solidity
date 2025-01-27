# Solidity Voting System

This repository contains a Solidity smart contract for a decentralized voting system. It allows users to vote for candidates in a secure, transparent, and tamper-proof manner. The system ensures that each voter can cast only one vote, and the results are publicly verifiable.

## Features
- **Owner-Only Actions:**
  - Add candidates
  - Authorize voters
  - Declare the winner
- **Voter Management:**
  - Only authorized voters can participate.
  - Each voter can cast only one vote.
- **Candidate Management:**
  - Dynamically add candidates.
- **Real-Time Vote Count:**
  - Track votes for each candidate instantly.
- **Winner Declaration:**
  - Automatically identify the candidate with the highest votes.

---

## Prerequisites
To deploy and interact with the contract, you need:
- [Node.js](https://nodejs.org/) installed
- [Truffle Suite](https://trufflesuite.com/) or [Hardhat](https://hardhat.org/)
- An Ethereum wallet such as [MetaMask](https://metamask.io/)
- Testnet Ether (e.g., from a faucet like [Goerli Faucet](https://faucet.goerli.mudit.blog/))

---

## Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/yousif-wali/voting-system-solidity.git
   cd voting-system-solidity
   ```

2. Install dependencies:
   ```bash
   npm install
   ```

3. Compile the contract:
   ```bash
   truffle compile
   ```

4. Deploy the contract:
   ```bash
   truffle migrate --network <network_name>
   ```

---

## Usage

### Adding Candidates
Only the owner can add candidates. Use the `addCandidate` function:
```solidity
addCandidate("Candidate Name");
```

### Authorizing Voters
The owner authorizes voters by their wallet address:
```solidity
authorizeVoter(0xYourVoterAddress);
```

### Voting
Authorized voters can cast their vote:
```solidity
vote(candidateId);
```

### Viewing Results
To view the total votes for a candidate:
```solidity
getCandidate(candidateId);
```

### Declaring Winner
The owner can declare the winner by calling:
```solidity
endElection();
```

---

## Contract Structure
- **VotingSystem.sol**: Main smart contract that handles all voting logic.

---

## Security Considerations
- Ensure that only trusted individuals have access to the owner's private key.
- Deploy the contract on a testnet for thorough testing before deploying on the mainnet.
- Use proper gas estimation to prevent transaction failures.

---

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss your ideas.

---

## License
This project is licensed under the MIT License. See the LICENSE file for details.
