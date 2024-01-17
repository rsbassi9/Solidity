//SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

contract InheritanceModifierExample{

    mapping(address => uint) public tokenbalance;

    address owner;

    uint tokenPrice = 1 ether;

    constructor() {
        owner = msg.sender;
        tokenBalance[owner] = 100;
    }

    // Syntax for a modifier. When this is injected into functions, the code before _; is called, then the function the modifier is injected into is called.
    modifier onlyOwner() {
        require(msg.sender == owner, "You are not allowed");
        _;
    }

// Only the owner can create and burn tokens. Specify the Modifier and remove old repetitive code
    function createNewToken() public onlyOwner {
        tokenBalance[owner]++;
    }

    function burnToken() public onlyOwner {
        tokenBalance[owner]--;
    }

// A function to allow purchase of tokens
    function purchaseToken() public payable {
        require((tokenBalance[owner] * tokenPrice) / msg.value > 0, "not enough tokens");
        tokenBalance[owner] -= msg.value / tokenPrice;
        tokenBalance[msg.sender] += msg.value / tokenPrice;
    }

// A function to allow sending of tokens
    function sendToken(address _to, uint _amount) public {
        require((tokenBalance[msg.sender] >= _amount), "not enough tokens");
        tokenBalance[msg.sender] -= _amount;
        tokenBalance[_to] += _amount;
    }

}