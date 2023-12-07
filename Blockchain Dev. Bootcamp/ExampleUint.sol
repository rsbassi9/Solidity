//SPDX-License-Identifier: MIT

pragma solidity 0.8.14;

contract ExampleUint {
    // setting a default value for this (uint public myUint = 0) will cost gas. Leave blank if possible.
    // uint is alias for uint256 i.e, can store values of 0 - (2^256 -1)
    uint public myUint;

    uint8 public myUint8 = 250; // max is 0-255, i.e, 0 to (2^8)-1

    int public myInt = -10; // -2^128 to +2^128 - 1

    function setMyUint(uint _myUint) public {
        myUint = _myUint;
    }

    //This function will fail if myUint is at 0, since Uints are non-negative
    function decrementUint() public {
        myUint--;
    }

    function incrementUint8() public {
        myUint8++; // if we keep calling this function, we get an error once we increment it to past 255
    }

    function incrementInt() public {
        myInt++;
    }
}