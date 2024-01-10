//SPDX-License-Identifier: MIT

pragma solidity 0.8.16;

address payable owner;

    // Set the owner of the wallet
    constructor() {
        owner = payable(msg.sender);
    }