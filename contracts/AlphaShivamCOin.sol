/*
Write a smart contract to create your own token on a local HardHat network. Once you have your contract,
 you should be able to use remix to interact with it. From remix, 
the contract owner should be ale to mint tokens to a provided address. 
Any user should be able to burn and transfer tokens.

OpenZeppelin is a library of reusable, secure, and community-vetted smart contracts. It provides 
implementations of various token standards, including ERC20, as well as other components like access control
*/


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
// ERC20 is a widely-used standard for creating and managing fungible tokens on the Ethereum blockchain

contract shivamTokenCompany is ERC20, Ownable {
    // Token details
    string private constant _name = "AlphaCoin";
    string private constant _symbol = "ASG";

    uint256 private _totalSupply = 0;

    constructor(uint256 initialSupply) ERC20(_name, _symbol) Ownable(msg.sender) {
        // Mint initial supply to the contract deployer (owner)
        uint256 initialSupplyWithDecimals = initialSupply;
        _mint(msg.sender, initialSupplyWithDecimals);
        _totalSupply = initialSupplyWithDecimals;
    }

    // Override decimals function to specify the number of decimal places
    function decimals() public view virtual override returns (uint8) {
        return 2;
    }

    // Function to mint new tokens, only the owner can call this
    function mintTokens(address to, uint256 amount) external onlyOwner {
        uint256 amountWithDecimals = amount;
        _mint(to, amountWithDecimals);
        _totalSupply += amountWithDecimals;
    }

    // Function to burn tokens from the caller's account
    function burnTokens(uint256 amount) external {
        uint256 amountWithDecimals = amount;
        _burn(msg.sender, amountWithDecimals);
        _totalSupply -= amountWithDecimals;
    }

    // Function to check the token balance of the caller
    function myBalance() external view returns (uint256) {
        return balanceOf(msg.sender);
    }

    // Function to transfer tokens to another address
    function transferTokens(address to, uint256 amount) external {
        uint256 amountWithDecimals = amount;
        _transfer(msg.sender, to, amountWithDecimals);
    }

    // Function to get the total supply of tokens
    function totalSupply() public view virtual override returns (uint256) {
        return _totalSupply;
    }
}
