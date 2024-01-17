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

// Make some changes and remove the owner definition from the second contract as it is already defined in the first
// Specify that this contract has a base smart contract - Owner, to allow it to inherit from it
contract InheritanceModifierExample is Owner{

    mapping(address => uint) public tokenBalance;

    uint tokenPrice = 1 ether;

    constructor() {
        tokenBalance[msg.sender] = 100;
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