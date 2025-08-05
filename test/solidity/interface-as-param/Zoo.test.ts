import { expect } from "chai";
import { ethers, } from "hardhat";
import { Signer } from "ethers";
import { Zoo, Tiger, Car, Firework } from "../../../typechain-types";

describe("Zoo", function () {
    let Zoo: Zoo;
    let Tiger: Tiger;
    let Car: Car;
    let Firework: Firework;
    let owner: Signer;
    
    beforeEach(async function () {
        [owner] = await ethers.getSigners();
    
        const contractFactory = await ethers.getContractFactory("Zoo");
        const tigerFactory = await ethers.getContractFactory("Tiger");
        const carFactory = await ethers.getContractFactory("Car");
        const fireworkFactory = await ethers.getContractFactory("Firework");

        // Deploy a new instance of the contracts before each test
        Zoo = await contractFactory.connect(owner).deploy();
        Tiger = await tigerFactory.connect(owner).deploy();
        Car = await carFactory.connect(owner).deploy();
        Firework = await fireworkFactory.connect(owner).deploy();
    });
    
    it("should allow adding an animal and hearing it's sound", async function () {
        const tigerAddr = await Tiger.getAddress();
        const animalId = ethers.encodeBytes32String("tiger"); // or any unique id
        await Zoo.connect(owner).addAnimal(animalId, tigerAddr);
        
        // Make sure it saved to state correctly
        const animalAddr = await Zoo.getAnimal(animalId);
        expect(animalAddr).to.equal(tigerAddr);

        // Expect to hear a tiger sound
        expect(await Zoo.hearAnimalSound(animalId)).to.equal("Roar!");
    });
    
    // Case #1: Passing an address that is not a contract
    it("should revert if a non-contract address is passed and method is invoked", async function () {
        const nonContractAddress = await owner.getAddress();
        const animalId = ethers.encodeBytes32String("owner-address"); // or any unique id

        // This won't revert on addAnimal since no calls to the contract are made
        await expect(Zoo.connect(owner).addAnimal(animalId, nonContractAddress)).to.not.be.reverted;
        
        // However, invoking a method that requires the address to call a specific function
        await expect(Zoo.connect(owner).hearAnimalSound(animalId)).to.be.reverted;
    });

    // Case #2: This is unexpected behavior! What if we want to force the contract to implement IAnimal?
    it("should not revert when does not implement IAnimal explicitly but has a makeSound() function", async function () {
        // Deploy a dummy contract with no makeSound function
        const carAddr = await Car.getAddress();
        const animalId = ethers.encodeBytes32String("car"); // or any unique id

        // This won't revert on addAnimal since no calls to the contract are made
        await expect(Zoo.connect(owner).addAnimal(animalId, carAddr)).to.not.be.reverted;
        
        // Expecting it not to revert since it has a makeSound function
        await expect(async () => {
            await Zoo.connect(owner).hearAnimalSound(animalId)
        }
        ).to.not.be.reverted

        // Uh-oh! We called a contract that doesn't implement IAnimal, but has a similar function signature
        const carSound = await Zoo.connect(owner).hearAnimalSound(animalId);
        expect(carSound).to.equal("Vroom!");
    });

    it("should revert when contract has a makeSound function but with different parameters", async function () {
        const fireworkAddr = await Firework.getAddress();
        const animalId = ethers.encodeBytes32String("firework"); // or any unique id

        // This won't revert on addAnimal since no calls to the contract are made
        await expect(Zoo.connect(owner).addAnimal(animalId, fireworkAddr)).to.not.be.reverted;
        
        // Expecting it to revert since the function signature doesn't match IAnimal
        await expect(Zoo.connect(owner).hearAnimalSound(animalId)).to.be.reverted;
    });

    // TODO: How to solve this problem? (ERC-165?)
});