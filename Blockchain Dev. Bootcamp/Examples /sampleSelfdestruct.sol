//SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

contract StartStopUpdateExample {

    receive() external payable {}

// A function that destroys the smart contract and has an argument for the contract to receive the money that is stored in it
// This address receives the money even if it does not have  receive function, a fallback function etc.
// In this case, the address is that of the person that calls the smart contract
    function destroySmartContract() public {
        selfdestruct(payable(msg.sender));
    }
}
