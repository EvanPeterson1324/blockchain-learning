pragma solidity ^0.8.28;

import {IAnimal} from "./IAnimal.sol";
/**
 * @title Tiger
 * @dev A simple implementation of the IAnimal interface representing a Tiger.
 * This contract defines the sound a Tiger makes.
 */
contract Tiger is IAnimal {
    function makeSound() external pure override returns (string memory) {
        return "Roar!";
    }
}