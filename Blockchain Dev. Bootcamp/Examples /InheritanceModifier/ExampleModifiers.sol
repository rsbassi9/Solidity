//SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;


//IMPORTS:
    // Golbal level:
        //import "filename";
    // import all members of a file:
        //import * as symbolName from "filename";
    //import specific members of a file:
        // import {symbol as alias, symbol2} from "filename";

// Import statement to read the Owner smart contract file
import "./Ownable.sol";

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

/*
INSTRUCTIONS:
Select Account#1 from the Accounts Dropdown
Deploy the Contract

Buy Tokens¶
Switch over to Account #2
Enter 1 into the value field
Select "Ether" from the Dropdown
Buy 1 Token for 1 Ether by hitting the purchase button

Get the Token Balance¶
Now lets look if you have the right balance. Copy your address, fill it into the input field for "tokenBalance" and see if the balance is 1

Burn Tokens¶
Now lets see what happens if you stay on Account#2 and try to burn tokens:

Try to burn with Account #2
Observe the Error message
Which is coming from the require statement

 */