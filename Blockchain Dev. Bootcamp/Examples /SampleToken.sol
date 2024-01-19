// SPDX-License-Identifier: MIT

// Source code: https://docs.openzeppelin.com/contracts/5.x/wizard
// Remix automatically uses npm to install openzeppelin libraries
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract CoffeeToken is ERC20, AccessControl {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    event CoffeePurchased(address indexed receiver, address indexed buyer);

    constructor(address defaultAdmin, address minter) ERC20("CoffeeToken", "CFE") {
        _grantRole(DEFAULT_ADMIN_ROLE, defaultAdmin);
        _grantRole(MINTER_ROLE, minter);
    }

    // mint is a public function, that can be callet externally
    function mint(address to, uint256 amount) public onlyRole(MINTER_ROLE) {
        _mint(to, amount);
    }

    // Create the ability to use tokens to buy a coffee
    function buyOneCoffee() public {
        _burn(_msgSender(), 1);
        emit CoffeePurchased(_msgSender());
    }

    // A person can give other people the allowance to buy coffees in his name
    function buyOneCoffeeFrom(address account) public {
       _spendAllowance(account, _msgSender(), 1); 
       _burn(account, 1);
       emit CoffeePurchased(_msgSender(), account);
    }
}

/*
NOTES:

 RFC stands for Request for Comment. And ERC was the early version of this for Ethereum: Ethereum Request for Comment.

 The number 20 simply refers to the 20th ERC that was posted by someone. That person proposed a general interface for a fungible token.

 Nowadays the ERC's are called EIPs: Ethereum Improvement Proposals. Because the majority of newcomers did not understand any difference between EIPs and ERCs they were merged.

 What's a fungible token? That is, where each token doesn't have any sort of unique serial number and they are all worth equally much. Like Euro or Dollar coins. You take out the coins in your pocket and 50 cents are 50 cents, doesn't matter if the coin is old and used or new and shiny.

 ***Minting Tokens¶
The OpenZeppelin implementation always has an internal _mint function. The visibility specifier defines the function as internal, that means, another function must actually call this function upon a certain event.

There are two large groups of implementations for tokens:

Fixed Supply Tokens
Variable Supply Tokens
The difference is mainly in how the mint functionality is used. If you use OpenZeppelin smart contracts, then with fixed supply, the mint function is callable only in the constructor once. That means, once the token is deployed, there is no more access for the internal mint functionality, the supply of tokens remains fixed.

The Variable Supply Tokens implement some sort of functionality, so that its possible to mint more tokens after the contract is deployed.

***Burning Tokens¶
The OpenZeppelin implementation of the ERC20 token also has an internal _burn function. Again, it is internal, that means, another function must actually call this function when using the ERC20 contract as a base contract.

***Ownership and Access Control¶
OpenZeppelin also has ownership covered in two flavors:

The simple Ownable, which we used before
A more elaborate Access Control structure with Roles
I'm not explaining again the simple Ownership functionality, we already did that with mappings. But the Access Control and Roles are something that is actually pretty cool.

You can define roles, such as a MINTER_ROLE or a BURNER_ROLE, which is basically just a keccak256 hash of the role name

    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
Then, the internal function grantRole can be called to grant a specific address a specific role. This function, itself, is checking if the person who is calling is the admin allowed to do so, and so on and so forth...

Then use can extend the Access Control Smart Contract and use the modifier onlyRole to make sure only a specific role has access to the function.

***Deploying a Token¶
Let's use a sample contract from OpenZeppelin to deploy a token. This token could represent anything - for example a voucher for coffees.

The flow could be:

We can give users tokens for coffees
The user can spend the coffee token in his own name, or give it to someone else
Coffee tokens get burned when the user gets his coffee.
 */