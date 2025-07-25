import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "@typechain/hardhat";

const config: HardhatUserConfig = {
  solidity: "0.8.28",
  // Generate typings for smart contracts
  typechain: {
    outDir: "typechain-types",
    target: "ethers-v6",
  },
};

export default config;
