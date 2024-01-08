//SPDX-License-Identifier: MIT

pragma solidity 0.8.15;

contract WillThrow {
    //a function that inevitably throws an error message
    function aFunction() public pure{
        require(false, "Error Message");
    }
}

// To catch this: but it needs to be caught from within another smart contract
contract ErrorHandling {
    //create an event to log the error. We wll come back to events later.
    event ErrorLogging(string reason)
;    function catchTheError() public {
        WillThrow will = new WillThrow();
        try will.aFunction() {
            // if it works, add code here
        } catch Error(string memory reason) {
            emit ErrorLogging(reason);
        }
    }
}