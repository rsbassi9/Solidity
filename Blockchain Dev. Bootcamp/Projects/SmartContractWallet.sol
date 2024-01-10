//SPDX-License-Identifier: MIT

pragma solidity 0.8.16;

contract SmartContractWallet {

address payable owner;

    // Set the owner of the wallet
    constructor() {
        owner = payable(msg.sender);
    }

    // Allow the waller to receiver funds no matter what
    receive() external payable {}

}