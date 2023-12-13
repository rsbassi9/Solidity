//SPDX-License-Identifier: MIT

pragma solidity 0.8.14;

contract MyContract {

    string public ourString = "Hello World";

    // use 'payable' keyword to be able to sedn ether when we update out String
        // if statement used to perform a check and make usre ether is sent when the string is update - it will not update if we dotn send 1 ether with it
    function updateOurString(string memory _updateString) public payable{
        if(msg.value == 1 ether) {
            ourString = _updateString;
        } else {    // To send money stored in a smart contract back to an address(which must be payable):
            payable(msg.sender).transfer(msg.value);
        } 
    }
}