pragma solidity ^0.8.28;

import {IAnimal} from "./IAnimal.sol";

/**
 * @title Zoo
 * @dev A simple contract that holds a mapping of animal names to their respective IAnimal interfaces.
 * This allows interaction with different animal contracts through a unified interface.
 */
contract Zoo {
    mapping(bytes32 => IAnimal) public animalsInZoo;

    error InvalidAddress(string message);
    error InvalidIdentifier(string message);

    function addAnimal(bytes32 animalId, IAnimal animal) external virtual {
        if (animalId == bytes32(0)) revert InvalidIdentifier("Animal ID can not be empty");
        if (address(animal) == address(0)) revert InvalidAddress("Animal address");
        animalsInZoo[animalId] = animal; // Add an animal to the zoo
    }

    function getAnimal(bytes32 animalId) external view returns (IAnimal) {
        return _getAnimal(animalId);
    }

    function hearAnimalSound(bytes32 animalId) external view returns (string memory) {
        IAnimal animal = _getAnimal(animalId);
        return animal.makeSound();
    }

    function _getAnimal(bytes32 animalId) private view returns (IAnimal) {
        IAnimal animal = animalsInZoo[animalId];
        if (address(animal) == address(0)) revert InvalidIdentifier("Animal not found");
        return animal;
    }
}