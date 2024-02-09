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

/*
"Virtual" and "override":
The base contract should have the name "virtual" to indicate that it can be re-written in any other contracts that inherit from it
The base function should have the name "override" if it is taking base functionality from a base contract and is planning to be able to override it.

If a function has both, it could be an intermediary contract, i.e, inherits from a base contract and 
has the ability to override the base function(override keyword), but also in itself can be overriden when used in another smart contract (virtual keyword)

function name() public view virtual ovveride returns (string memory){
    return _name;
}

 */