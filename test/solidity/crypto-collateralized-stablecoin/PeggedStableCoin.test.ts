import { expect } from "chai";
import { ethers } from "hardhat";
import { Signer } from "ethers";
import { PeggedStableCoin } from "../../../typechain-types"

describe("PeggedStableCoin", function () {
  let PeggedTestStableCoin: PeggedStableCoin;
  let owner: Signer;
  let vault: Signer;
  let user1: Signer;

  beforeEach(async function () {
    [owner, vault] = await ethers.getSigners();

    const contractFactory = await ethers.getContractFactory("PeggedStableCoin");

    // Deploy a new instance of my erc20 contract before each test
    PeggedTestStableCoin = await contractFactory
      .connect(owner)
      .deploy(
        "Test Stable Coin",
        "TSC",
        await vault.getAddress(),
      );
  });

  it("should setup the correct roles for the specified addresses", async function () {
    const ownerAddress = await owner.getAddress();
    const vaultAddress = await vault.getAddress();
    const defaultAdminRole = await PeggedTestStableCoin.DEFAULT_ADMIN_ROLE();
    const minterRole = await PeggedTestStableCoin.MINTER_ROLE();
    const burnerRole = await PeggedTestStableCoin.BURNER_ROLE();

    // Check if the owner has the DEFAULT_ADMIN_ROLE and not the MINTER_ROLE/BURNER_ROLE
    expect(await PeggedTestStableCoin.hasRole(defaultAdminRole, ownerAddress)).to.be.true;
    expect(await PeggedTestStableCoin.hasRole(minterRole, ownerAddress)).to.be.false;
    expect(await PeggedTestStableCoin.hasRole(burnerRole, ownerAddress)).to.be.false;

    // Check if the vault has the MINTER_ROLE
    expect(await PeggedTestStableCoin.hasRole(minterRole, vaultAddress)).to.be.true;

    // Check if the vault has the BURNER_ROLE
    expect(await PeggedTestStableCoin.hasRole(burnerRole, vaultAddress)).to.be.true;
  })

  it("should have the correct name and symbol", async function () {
    expect(await PeggedTestStableCoin.name()).to.equal("Test Stable Coin");
    expect(await PeggedTestStableCoin.symbol()).to.equal("TSC");
  });

  it("should set the owner and vault correctly", async function () {
    expect(await PeggedTestStableCoin.owner()).to.equal(await owner.getAddress());
    expect(await PeggedTestStableCoin.vault()).to.equal(await vault.getAddress());
  });

  it("should allow the vault to mint tokens", async function () {
    const mintAmount = ethers.parseEther("1000");
    await PeggedTestStableCoin.connect(vault).mint(await owner.getAddress(), mintAmount);
    
    const balance = await PeggedTestStableCoin.balanceOf(await owner.getAddress());
    expect(balance).to.equal(mintAmount);
  });

  it("should not allow non-vault addresses to mint tokens", async function () {
    [user1] = await ethers.getSigners();
    const mintAmount = ethers.parseEther("1000");

    await expect(
      PeggedTestStableCoin.connect(user1).mint(await owner.getAddress(), mintAmount)
    ).to.be.reverted;
  });

  it('should allow the vault to burn tokens', async function () {
    const mintAmount = ethers.parseEther("1000");
    const user1Address = await user1.getAddress();

    // Mint some tokens to user1
    await PeggedTestStableCoin
      .connect(vault)
      .mint(user1Address, mintAmount);
    
    const userBalance = await PeggedTestStableCoin.balanceOf(user1Address);
    expect(userBalance).to.equal(mintAmount);

    // Burn all the tokens from user1
    await PeggedTestStableCoin
      .connect(vault)
      .burn(user1Address, mintAmount);
    
    const finalBalance = await PeggedTestStableCoin.balanceOf(user1Address);
    expect(finalBalance).to.equal(0);
  });
});