import { expect } from "chai";
import { ethers, } from "hardhat";
import { AddressLike, Signer } from "ethers";
import { Zoo } from "../../../typechain-types";

describe("Zoo", function () {
    let Zoo: Zoo;
    let owner: Signer;
    let animal1: Signer;
    let animal2: Signer;
    
    beforeEach(async function () {
        [owner, animal1, animal2] = await ethers.getSigners();
    
        const contractFactory = await ethers.getContractFactory("Zoo");
    
        // Deploy a new instance of the Zoo contract before each test
        Zoo = await contractFactory.connect(owner).deploy();
    });
    
    it("should allow adding an animal", async function () {
        const animalAddress: AddressLike = await animal1.getAddress();
        const animalId = ethers.encodeBytes32String("lion"); // or any unique id
        await Zoo.connect(owner).addAnimal(animalId, animalAddress);
    });
    
    it("should revert if a non-contract address is passed and method is invoked", async function () {
        const nonContractAddress = await owner.getAddress();
        const animalId = ethers.encodeBytes32String("lion"); // or any unique id

        // This won't revert on addAnimal since no calls to the contract are made
        await expect(Zoo.connect(owner).addAnimal(animalId, nonContractAddress)).to.not.be.reverted;
        
        // However, invoking a method that requires the address to call a specific function
        await expect(Zoo.connect(owner).hearAnimalSound(animalId)).to.be.reverted;
    });

    // TODO: Test contract function without the make sound function
    // TODO: Test contract function with same name as make sound but different params
    // TODO: How to solve this problem? (ERC-165?)
});