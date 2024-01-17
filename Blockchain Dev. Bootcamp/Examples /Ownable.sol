//SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

// Place the owner into its own smart contract and call it in the other - inheritance
contract Owner{
    address owner;

    constructor(){
        owner = msg.sender;
    }

    // Syntax for a modifier
    modifier onlyOwner() {
        require(msg.sender == owner, "You are not allowed");
        _;
    }
}