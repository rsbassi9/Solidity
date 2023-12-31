//SPDX-License-Identifier: MIT

pragma solidity 0.8.14;


//We're going to expand the functionality of this function now and charge for every string change 1 Eth
contract MyContract {

    string public ourString = "Hello World";

    // The 'payable' modifier tells solidity that the function is expecting eth to receive
        // if statement used to perform a check and make usre ether is sent when the string is update - it will not update if we dotn send 1 ether with it
    function updateOurString(string memory _updateString) public payable{
        if(msg.value == 1 ether) {
            ourString = _updateString;
        } else {    // To send money stored in a smart contract back to an address(which must be payable):
            payable(msg.sender).transfer(msg.value);
        } 
    }
}
//every time you send 1 eth, you can update the string. But if you send less or more, you just get refunded.

// msg.sender = address that sends the transaction
// msg.value = amount of ETH that was sent within the transaction to the smart contract
