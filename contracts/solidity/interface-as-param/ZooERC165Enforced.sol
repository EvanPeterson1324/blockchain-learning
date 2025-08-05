// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import {IAnimal} from "./IAnimal.sol";
import {IERC165} from "@openzeppelin/contracts/utils/introspection/ERC165.sol";
import {Zoo} from "./Zoo.sol";

/**
 * @title Zoo
 * @dev A simple contract that holds a mapping of animal names to their respective IAnimal interfaces.
 * This allows interaction with different animal contracts through a unified interface.
 */
contract ZooERC165Enforced is Zoo {

    error IsNotAnimal(address providedAddress);

    /**
     * @notice Overrides addAnimal to enfore the ERC-165 spec (https://eips.ethereum.org/EIPS/eip-165)
     * @dev Validations
     * - revert if animalId is empty
     * - revert if animal address is the zero addr
     * - revert if the provided animal contract does not implement IAnimal
     * 
     * @param animalId random unique identifier for the animal
     * @param animal contract address of the specific animal contract instance
     */
    function addAnimal(bytes32 animalId, IAnimal animal) public override {
        if (animalId == bytes32(0)) revert InvalidIdentifier("Animal ID can not be empty");
        if (address(animal) == address(0)) revert InvalidAddress("Animal address");
        if (!_isAnimal(animal)) revert IsNotAnimal(address(animal));

        // Add an animal to the zoo
        animalsInZoo[animalId] = animal;
    }

    /**
     * @dev Checks if the provided contract implements the IAnimal interface
     * @param animal contract address of the specific animal contract instance
     * @return bool true if the contract implements the IAnimal interface, false otherwise
     */
    function _isAnimal (IAnimal animal) private view returns (bool) {
        try IERC165(address(animal)).supportsInterface(type(IAnimal).interfaceId) returns (bool isAnimal) {
            return isAnimal;
        } catch {
            return false;
        }
    }
}