const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("PokemonGatchaGame", function () {
  let contract, owner, player1;
  const uri = "https://evanpeterson1324.github.io/metadata/{id}.json";
  const POKEMON_ID = 1;

  beforeEach(async function () {
    [owner, player1] = await ethers.getSigners();

    const PokemonGatchaGame = await ethers.getContractFactory("PokemonGatchaGame");
    contract = await PokemonGatchaGame.deploy(uri);
    await contract.waitForDeployment();
  });

  it("should deploy with correct URI and owner", async function () {
    expect(await contract.uri(POKEMON_ID)).to.equal(uri);
    expect(await contract.owner()).to.equal(owner.address);
  });

  it("should allow owner to mint", async function () {
    await contract.mint(player1.address, POKEMON_ID, 5);
    const balance = await contract.balanceOf(player1.address, POKEMON_ID);
    expect(balance).to.equal(5);
  });

  it("should allow owner to burn", async function () {
    await contract.mint(player1.address, POKEMON_ID, 5);
    await contract.burn(player1.address, POKEMON_ID, 3);
    const balance = await contract.balanceOf(player1.address, POKEMON_ID);
    expect(balance).to.equal(2);
  });

  it("should allow owner to pause and unpause the contract", async function () {
    await contract.pause();
    expect(await contract.paused()).to.be.true;
    await contract.unpause();
    expect(await contract.paused()).to.be.false;
  });

  it("should revert if someone tries to mint when paused", async function () {
    await contract.pause();
    await expect(contract.mint(player1.address, POKEMON_ID, 1)).to.be.revertedWithCustomError(
      contract,
      "EnforcedPause"
    );
  });

  it("should revert if someone tries to burn when paused", async function () {
    await contract.mint(player1.address, POKEMON_ID, 5);
    await contract.pause();
    await expect(contract.burn(player1.address, POKEMON_ID, 1)).to.be.revertedWithCustomError(
      contract,
      "EnforcedPause"
    );
  });                 

  it("should revert if non-owner tries to mint", async function () {
    await expect(contract.connect(player1).mint(player1.address, POKEMON_ID, 1)).to.be.revertedWithCustomError(
      contract,
      "OwnableUnauthorizedAccount"
    );
  });

  it("should revert if non-owner tries to pause", async function () {
    await expect(contract.connect(player1).pause()).to.be.revertedWithCustomError(
      contract,
      "OwnableUnauthorizedAccount"
    );
  });

  it("should revert if non-owner tries to burn", async function () {
    await contract.mint(player1.address, POKEMON_ID, 1);
    await expect(contract.connect(player1).burn(player1.address, POKEMON_ID, 1)).to.be.revertedWithCustomError(
      contract,
      "OwnableUnauthorizedAccount"
    );
  });
});
