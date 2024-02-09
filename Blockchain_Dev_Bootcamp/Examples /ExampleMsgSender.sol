//SPDX-License-Identifier: MIT

pragma solidity 0.8.15;

contract ExamplesgSender {

    address public someAddress;

    function updateSomeAddress() public {
       // msg object is public object available throughout all our contracts. 
       // It contains the address of the account interacting with the smart contract
        someAddress = msg.sender;
    }
}