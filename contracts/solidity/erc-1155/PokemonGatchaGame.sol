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

    error DropNotFound(uint256 dropId);
    error IncorrectRollPrice(uint256 sent, uint256 expected);
    error ExceedsMaxDropId(uint256 maxDropId);

    // Constants
    uint256 public constant ROLL_PRICE = 0.00001 ether;
    uint256 constant public MAX_DROP_ID = 9999;
    uint8 constant public GOLD = 0;
    uint8 constant public GOLD_DECIMALS = 18;

    // Tracks which ids are available for minting.
    // This allows the owner to add more drops and remove drops as needed.
    mapping (uint256 => bool) availableDrops;

    /**
     * @dev Initializes the contract with the metadata URI. 
     * The contract starts in a paused state.
     * @param uri_ The base URI for the metadata of the tokens.
     */
    constructor(string memory uri_) ERC1155(uri_) Ownable(msg.sender) {
        _pause(); // Start the contract in a paused state

        // Start with GOLD as the only available drop and add more later
        availableDrops[GOLD] = true;
    }

    /**
     * @notice Allows the owner to mint new Pokemon tokens.
     * @param account The address to which the tokens will be minted.
     */
    function roll(address account) external payable whenNotPaused {
        if (msg.value != ROLL_PRICE) {
            revert IncorrectRollPrice(msg.value, ROLL_PRICE);
        }

        uint256 id = _getRandomDropId();
        uint256 amount = _getAmountForDrop(id);
        
        _mint(account, id, amount, "");
    }

    /**
     * @dev Internal function to enforce logic for getting a drop to mint
     * 
     */
    function _getRandomDropId() internal view returns (uint256) {
        // This is a placeholder for the actual random logic.
        // In a real implementation, you would use a secure random number generator.
        // For now, we will just return a fixed value for demonstration purposes.
        return GOLD; // Always returns GOLD for now
    }

    function _getAmountForDrop(uint256 id) internal pure returns (uint256) {
        // For now, we will just return 1 for all drops.
        // In a real implementation, this could vary based on the drop type.
        return 1;
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

    /**
     * @notice Allows the owner to add a new drop.
     * @dev This function can only be called by the owner of the contract.
     * @param id the id of the new drop to be added.
     */
    function addDrop(uint256 id) external onlyOwner {
        if (id >= MAX_DROP_ID) revert ExceedsMaxDropId(MAX_DROP_ID);

        require(id <= MAX_DROP_ID, "Drop ID exceeds maximum limit");
        require(!availableDrops[id], "Drop already exists");
        availableDrops[id] = true;
    }

    function removeDrop(uint256 id) external onlyOwner {
        if (!_isDropAvailable(id)) revert DropNotFound(id);
        availableDrops[id] = false;
    }

    function uri(uint256 id) public view override returns (string memory) {
        if (!_isDropAvailable(id)) revert DropNotFound(id);
        
        return super.uri(id);
    }

    /**
     * @notice Allows the owner to add a new drop.
     * @param id The ID of the new drop to be added.
     */
    function _isDropAvailable(uint256 id) internal view returns (bool) {
        return availableDrops[id];
    }
}
