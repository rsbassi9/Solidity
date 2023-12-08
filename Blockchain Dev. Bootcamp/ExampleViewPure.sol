//SPDX-License-Identifier: MIT

pragma solidity 0.8.15;

contract ExampleViewPure {

    uint public myStorageVariable;

    //both view and pure functions are reading operations

    // view functions can access storage variables / variables outside teh scope of the function, but cannot write them
    function getMyStorageVariable() public view returns(uint) {
        return myStorageVariable;
    }

    // pure functions can only call varibales that are not storage variables, or other pure functions
    // in this example, a and b are not storage variables
    function getAddition(uint a, uint b) public pure returns(uint){
        return a+b;
    }
}