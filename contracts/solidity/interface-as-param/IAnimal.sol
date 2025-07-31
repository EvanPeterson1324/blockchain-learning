pragma solidity ^0.8.28;

/**
 * @title IAnimal
 * @dev An interface for an Animal contract that tells us what sound an animal makes.
 */
interface IAnimal {
    function makeSound() external view returns (string memory);
}