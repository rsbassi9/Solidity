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