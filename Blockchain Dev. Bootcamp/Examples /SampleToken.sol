// SPDX-License-Identifier: MIT

// Source code: https://docs.openzeppelin.com/contracts/5.x/wizard
// Remix automatically uses npm to install openzeppelin libraries
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract CoffeeToken is ERC20, AccessControl {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    event CoffeePurchased(address indexed receiver);

    constructor(address defaultAdmin, address minter) ERC20("CoffeeToken", "CFE") {
        _grantRole(DEFAULT_ADMIN_ROLE, defaultAdmin);
        _grantRole(MINTER_ROLE, minter);
    }

    // mint is a public function, that can be callet externally
    function mint(address to, uint256 amount) public onlyRole(MINTER_ROLE) {
        _mint(to, amount);
    }

    // Create the ability to use tokens to buy a coffee
    function burOneCoffee() public {
        _burn(_msgSender(), 1);
        emit CoffeePurchased(_msgSender());
    }
}