
Ethereum Gas Fee Word Problems – Solution Sheet

Assumptions:
- Gas Price = 40 gwei = 40 × 10^9 wei
- 1 ETH = 10^18 wei

-----------------------------------------------------
Problem 1: ETH Transfer
Gas Used: 21,000
Fee in wei = 21,000 × 40 × 10^9 = 840,000,000,000,000
Fee in ETH = 0.00084 ETH

-----------------------------------------------------
Problem 2: Contract Call (SLOAD + ADD)
Gas Used = 21,000 (base) + 2,100 (SLOAD) + 3 (ADD) = 23,103
Fee in wei = 23,103 × 40 × 10^9 = 924,120,000,000,000
Fee in ETH = 0.00092412 ETH

-----------------------------------------------------
Problem 3: Contract Write + Event
Gas Used = 21,000 (base) + 20,000 (new slot write) + 375 (event base) + 375 (topic) = 41,750
Fee in wei = 41,750 × 40 × 10^9 = 1,670,000,000,000,000
Fee in ETH = 0.00167 ETH

-----------------------------------------------------
Problem 4: Contract Deployment
Gas Used = 100,000
Fee in wei = 100,000 × 40 × 10^9 = 4,000,000,000,000,000
Fee in ETH = 0.004 ETH

-----------------------------------------------------
Problem 5: High Gas Price Surge
Gas Price = 120 gwei = 120 × 10^9 wei
Gas Used = 21,000 (base) + 5,000 (overwrite) + 375 (event base) + 375×2 (topics) = 27,125
Fee in wei = 27,125 × 120 × 10^9 = 3,255,000,000,000,000
Fee in ETH = 0.003255 ETH

-----------------------------------------------------
Problem 6: Multiple Storage Accesses
Gas Used = 21,000 (base) + 2×2,100 (SLOADs) + 20,000 (new write) = 45,200
Fee in wei = 45,200 × 40 × 10^9 = 1,808,000,000,000,000
Fee in ETH = 0.001808 ETH
