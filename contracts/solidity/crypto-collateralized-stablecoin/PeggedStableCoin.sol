// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

// DISCLAIMER: This code is for educational purposes only and should not be used on mainnet as a "real" contract without proper security audits, edits, and testing.

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {AccessControl} from "@openzeppelin/contracts/access/AccessControl.sol";

/**
 * @title ETHPeggedStableCoin
 * @dev A simple ERC20 token that represents a stablecoin pegged to Ethereum.
 * 
 * This contract mints an initial supply of tokens to the deployer's address.
 */
contract PeggedStableCoin is ERC20, AccessControl {
    // Define the roles
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant BURNER_ROLE = keccak256("BURNER_ROLE");

    address public immutable owner;
    address public immutable vault;

    /**
     * @dev Constructor that sets the name and symbol of the token, and grants the deployer the minter and burner roles.
     * @param _name The name of the token.
     * @param _symbol The symbol of the token.
     * @param _vault The address of the vault that will handle minting and burning.
     */
    constructor(
        string memory _name,
        string memory _symbol,
        address _vault
    ) ERC20(_name, _symbol) {
        // Set the owner of the token and the vault
        owner = msg.sender;
        vault = _vault;

        // Grant the deployer the minter and burner roles
        _grantRole(DEFAULT_ADMIN_ROLE, owner);
        _grantRole(MINTER_ROLE, vault);
        _grantRole(BURNER_ROLE, vault);
    }

    // Only the vault should be able to mint new tokens
    function mint(address to, uint256 amount) external onlyRole(MINTER_ROLE) {
        // Mint new tokens to the specified address
        _mint(to, amount);
    }

    // Only the vault should be able to burn tokens
    function burn(address from, uint256 amount) external onlyRole(BURNER_ROLE) {
        // Burn tokens from the specified address
        _burn(from, amount);
    }
}