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

/*
Notes:
The data on the blockchain is forever, but the state is not. 
That means, we can not erase information from the Blockchain, but we can update the current state so that you can't interact with an address anymore going forward. 
Everyone can always go back in time and check what was the value on day X, but, once the function selfdestruct() is called, you can't interact with a Smart Contract anymore.

The contract should be easily readable and the only surprise will be, what happes when you interact with the smart contract after it has been destroyed. 
Once you call destroySmartContract, the address of the Smart Contract will contain no more code. 
You can still send transactions to the address and transfer Ether there, but there won't be any code that could send you the Ether back.

 */
