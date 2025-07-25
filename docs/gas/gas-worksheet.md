## 📊 Gas Cost Reference Table

| **Operation**                     | **Gas Cost**            | **Notes**                                |
| --------------------------------- | ----------------------- | ---------------------------------------- |
| ETH transfer                      | `21,000`                | Basic transaction from EOA to EOA        |
| Contract call (simple logic only) | `25,000` – `50,000`     | Varies by function complexity            |
| Contract deployment               | `100,000` + code size   | Large contracts may cost more            |
| Storage write (new slot)          | `20,000`                | Writing to a slot that was `0`           |
| Storage write (overwrite)         | `5,000`                 | Changing a non-zero slot                 |
| Storage clear (set to 0)          | Refund of `15,000`      | Refund after deletion (net cost = 5,000) |
| Storage read (`SLOAD`)            | `2,100`                 | Reading from storage                     |
| Event log with 1 topic + data     | `375 + 375`             | Base + 375 per topic                     |
| Keccak256 (`SHA3`) hash           | `30 + 6 per 32 bytes`   | Cost depends on input size               |
| Call to external contract         | `2,600` + calldata cost | Nontrivial calls are more expensive      |

---

## 📝 Gas Fee Word Problems Worksheet

Assume:

* `Gas Price = 40 gwei = 40 × 10⁹ wei`
* `1 ETH = 10¹⁸ wei`

---

### **Problem 1: ETH Transfer**

You are sending 0.5 ETH to a friend. What is the total cost of the transaction, including gas?

> Hint: ETH transfer costs 21,000 gas.

---

### **Problem 2: Contract Call**

You interact with a contract that reads from storage (`SLOAD`) once and then performs a simple `ADD` operation. What is the total gas used, and what is the fee in ETH?

> Hint: `SLOAD = 2,100`, `ADD = 3`, plus `Base Tx = 21,000`.

---

### **Problem 3: Contract Write**

You call a function that writes a new value to storage and emits an event with 1 topic. What is the gas used and total fee in ETH?

> Hint: `Storage write (new slot) = 20,000`, `Event = 375 (base) + 375 (topic)`, `Base = 21,000`.

---

### **Problem 4: Deployment**

You deploy a smart contract. The init code is simple, so the base deployment cost is 100,000 gas. What is the total cost in ETH?

---

### **Problem 5: High Gas Price Surge**

Network congestion spikes the gas price to `120 gwei`. You want to overwrite an existing storage slot (`5,000 gas`) and emit an event with 2 topics. What is the new transaction fee in ETH?

---

### **Problem 6: Multiple Storage Accesses**

A function:

* Reads from 2 storage slots (`SLOAD`)
* Writes to 1 new storage slot
* Emits no event

Gas price remains `40 gwei`. What’s the total gas cost and ETH fee?

---

See `gas-worksheet-solutions.md` for the answer key.
