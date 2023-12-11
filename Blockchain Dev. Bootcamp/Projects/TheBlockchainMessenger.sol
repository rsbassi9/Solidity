//SPDX-License-Identifier: MIT

pragma solidity 0.8.15;

/*

1. Through the constructor make sure you write the address that deployed the contract to a variable
2. Create a message-variable of the type string, that only the deployer-address can update
3. Create a counter, to see how many times the variable was updated.

*/

contract TheBlockchainMessenger {

    uint public changeCounter;

    address public owner;

    string public theMessage;

    constructor() {
        owner = msg.sender;
    }

    function updateTheMessage(string memory _newMessage) public {
        if(msg.sender == owner){
            theMessage = _newMessage;
            changeCounter++;
        }
    }
}