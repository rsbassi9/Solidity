//SPDX-License-Identifier: MIT

pragma solidity 0.8.15;

contract WillThrow {
    //a function that inevitably throws an error message
    function aFunction() public pure{
        require(false, "Error Message");
    }
}