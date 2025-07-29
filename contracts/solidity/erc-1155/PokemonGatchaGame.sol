// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC1155} from "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {Pausable} from "@openzeppelin/contracts/utils/Pausable.sol";

/**
 * @title PokemonGatchaGame
 * @dev A Pokemon Gatcha game which implements the ERC-1155 spec.
 * Players can "roll" for Pokemon, which are represented as ERC-1155 tokens.
 * The game is paused by default and can be unpaused by the owner.
 * The metadata for each token is stored at a specific URL format ("https://evanpeterson1324.github.io/metadata/{id}.json")
 */
contract PokemonGatchaGame is Ownable, Pausable, ERC1155 {

    /**
     * @dev Initializes the contract with the metadata URI.
     * @param uri_ The base URI for the metadata of the tokens.
     */
    constructor(string memory uri_) ERC1155(uri_) Ownable(msg.sender) {}

    /**
     * @notice Allows the owner to mint new Pokemon tokens.
     * @param account The address to which the tokens will be minted.
     * @param id The ID of the Pokemon token to mint.
     * @param amount The amount of tokens to mint.
     */
    function mint(address account, uint256 id, uint256 amount) external onlyOwner whenNotPaused {
        _mint(account, id, amount, "");
    }

    /**
     * @notice Allows the owner to burn Pokemon tokens.
     * @param account The address from which the tokens will be burned.
     * @param id The ID of the Pokemon token to burn.
     * @param amount The amount of tokens to burn.
     */
    function burn(address account, uint256 id, uint256 amount) external onlyOwner whenNotPaused{
        _burn(account, id, amount);
    }

    /**
     * @notice Allows the owner to pause the game.
     * @dev This function can only be called by the owner of the contract.
     */
    function pause() external onlyOwner {
        _pause();
    }

    /**
     * @notice Allows the owner to unpause the game.
     * @dev This function can only be called by the owner of the contract.
     */
    function unpause() external onlyOwner {
        _unpause();
    }
}
