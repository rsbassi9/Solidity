//SPDX-License-Identifier: MIT

// In versions of solidity <0.8, if an Unsigned integer (Uint) is at 0, and we decrement, it rolls over to 2^256-1. i.e, still non negative, 
// but this time, the function will work (as opposed to 0-- which would be negative in solidity >0.8, therefore 
// making the function unable to be executed

//To get this behaviour 
pragma solidity 0.8.15;

contract ExampleWrapAround {
    // setting a default value for this (uint public myUint = 0) will cost gas. Leave blank if possible.
    // uint is alias for uint256 i.e, can store values of 0 - (2^256 -1)
    uint public myUint;

    uint8 public myUint8 = 250; // max is 0-255, i.e, 0 to (2^8)-1

    function setMyUint(uint _myUint) public {
        myUint = _myUint;
    }

    // In versions of solidity <0.8, if an Unsigned integer (Uint) is at 0, and we decrement, it rolls over to 2^256-1. i.e, still non negative, 
    // but this time, the function will work (as opposed to 0-- which would be negative in solidity >0.8, therefore 
    // making the function unable to be executed
    // To get this functionality back, wrap in an "unchecked block"
    // This replaces the need to use libraries like safemath
    function decrementUint() public {
        unchecked{
        myUint--;
        }
    }

    function incrementUint8() public {
        myUint8++; // if we keep calling this function, we get an error once we increment it to past 255
    }
}