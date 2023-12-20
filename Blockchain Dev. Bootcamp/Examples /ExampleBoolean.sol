//SPDX-License-Identifier: MIT

pragma solidity 0.8.14;

contract ExampleBoolean {

// Default value for Bool is false in Solidity
// The getter function is not called until we declare this as public
    bool public myBool;

// Delare a setter Function
// unless this is set to false, any other value will be set to true
// myBool = !_myBool will set myBool to false if we set it as true
    function setMyBool(bool _myBool) public {
        myBool = _myBool;
    }

}