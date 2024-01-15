//SPDX-License-Identifier: MIT

pragma solidity 0.8.16;

contract MyContract {

    uint public myUint = 123;

    function setMyUint(uint newUint) public {
        myUint = newUint;
    }
}

// To interact with this contract using Web3.js, you would deploy this contract, get the contract address and the ABI:
