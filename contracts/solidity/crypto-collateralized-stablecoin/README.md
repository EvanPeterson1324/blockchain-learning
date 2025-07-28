# ETH-Backed Stablecoin – Learning Plan & Project Timeline - **AI assisted learning**

This project implements a crypto-collateralized ERC-20 stablecoin backed by ETH and deployed to the Base testnet. Over the course of 7 days, I plan to go from learning fundamentals to building and demoing a functional prototype.

---

## 🗓️ Timeline Overview

### **Day 1 – ERC-20 & Stablecoin Basics**
**Goal:** Understand ERC-20 tokens and how stablecoins maintain their peg.

- 📖 Read:
  - [x] [ERC-20 Standard – EIP](https://eips.ethereum.org/EIPS/eip-20)
  - [x] [OpenZeppelin ERC20 Docs](https://docs.openzeppelin.com/contracts/5.x/api/token/erc20)

- 🧪 Task:
  - [ ] Deploy a basic ERC-20 token using Hardhat + OpenZeppelin
  - [ ] Interact with it via console or scripts

---

### **Day 2 – ETH Vault Basics**
**Goal:** Write a contract to accept and store ETH securely.

- 📖 Read:
  - [ ] [Solidity: receive() and fallback()](https://docs.soliditylang.org/en/latest/contracts.html#receive-ether-function)
  - [ ] [Solidity by Example – Sending Ether](https://solidity-by-example.org/sending-ether/)

- 🧪 Task:
  - [ ] Write a simple vault contract that accepts ETH
  - [ ] Track per-user deposits

---

### **Day 3 – Minting Stablecoin with ETH**
**Goal:** Implement minting of ERC-20 tokens based on ETH deposits.

- 📖 Read:
  - [ ] [Building a DeFi Stablecoin – James Backhouse](https://jamesbachini.com/defi-stablecoin/)

- 🧪 Task:
  - [ ] Integrate ERC-20 minting into your vault
  - [ ] Use a fixed conversion rate (e.g., $1 = 0.0005 ETH)
  - [ ] Implement burn + redeem logic

---

### **Day 4 – Security & Unit Testing**
**Goal:** Secure the system and verify logic correctness.

- 📖 Read:
  - [ ] [Smart Contract Security Best Practices](https://consensys.github.io/smart-contract-best-practices/)
  - [ ] [Hardhat Testing Guide](https://hardhat.org/tutorial/testing-contracts)

- 🧪 Task:
  - [ ] Add `ReentrancyGuard` and input checks
  - [ ] Write tests for minting, burning, and redemption logic

---

### **Day 5 – Base Testnet Deployment**
**Goal:** Deploy the system to the Base Sepolia testnet.

- 📖 Read:
  - [ ] [Base Testnet Docs](https://docs.base.org/tools/dep)
