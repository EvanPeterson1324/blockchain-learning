// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

// Code example from: https://www.cyfrin.io/glossary/payable-solidity-code-example

// DISCLAIMER: This code is for educational purposes only and should not be used on mainnet as a "real" contract without proper security audits, edits, and testing.

contract Payable {
    address payable public owner;

    error TransferFailed();

    constructor() payable {
        // msg.sender addr is NOT payable type by default
        //   - _owner --> payable address
        //   - msg.sender --> address
        //   - payable(msg.sender) --> payable address
        owner = payable(msg.sender);
    }

    // Takes the amount of eth sent in msg.value and adds it to the contract balance
    function deposit() public payable {
        // The EVM automatically sends eth to address(this).balance
        // msg.value is the amount of eth sent in the transaction}
    }

    function notPayable() public {
        // This function cannot receive Ether
        // If you try to send Ether to this function, it will revert
    }

    function withdrawAll() public {
        // Get the ETH balance of this contract
        uint256 amount = address(this).balance;

        // Use "call" to send Ether to the owner
        (bool success,) = owner.call{value: amount}("");

        if (!success) revert TransferFailed();
    }

    // _to needs to be marked as payable to receive Ether
    function transfer(address payable _to, uint256 _amount) public {
        (bool success,) = _to.call{value: _amount}("");
        if (!success) revert TransferFailed();
    }
}