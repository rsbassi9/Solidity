// SPDX-License-Identifier: MIT

// Source code: https://docs.openzeppelin.com/contracts/5.x/wizard
// Remix automatically uses npm to install openzeppelin libraries
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyToken is ERC20, Ownable {
    constructor(address initialOwner)
        ERC20("MyToken", "MTK")
        Ownable(initialOwner)
    {}

// mint is a public function, that can be callet externally
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount); //_mint is an internal function that can only be called from our smart contract
    }
}