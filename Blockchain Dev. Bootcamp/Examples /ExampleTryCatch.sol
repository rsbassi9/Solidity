//SPDX-License-Identifier: MIT

pragma solidity 0.8.23;

contract WillThrow {
    error NotAllowedError(string); // we can make our own custom exceptions at the beginning of a smart contract
    //a function that inevitably throws an error message
    function aFunction() public pure{
       // require(false, "Error Message");
       // assert(false);
       revert NotAllowedError("You are not allowed"); // In console: web3.utils.toAscii("0x00...") to convert lowLevelData to string
    }
}

// To catch this: but it needs to be caught from within another smart contract
contract ErrorHandling {
    //create an event to log the error. We wll come back to events later.
    event ErrorLogging(string reason);
    event ErrorLogCode(uint code);
    event ErrorLogBytes(bytes lowLevelData);
    function catchTheError() public {
        WillThrow will = new WillThrow();
        try will.aFunction() {
            // if it works, add code here
        } catch Error(string memory reason) {  // For require that fails
            emit ErrorLogging(reason);
        } catch Panic(uint errorCode) {         // For panic that fails (assert)
            emit ErrorLogCode(errorCode);
        } catch(bytes memory lowLevelData){
            emit ErrorLogBytes(lowLevelData);   // For all other fails
        }                     
    }
}