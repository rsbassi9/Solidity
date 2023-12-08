//SPDX-License-Identifier: MIT

pragma solidity 0.8.15;

contract ExampleStrings {

    string public myString = "Hello World";
    // Better to use bytes in smart contracts since we can get their length using the .length method.
    // For strings, getting their length may be herder since they are represented as utf8, therefore some characters may be represented by 2 bytes 
    bytes public _myBytes = "Hello World";   

    // Use storage of memory keyword. This removes this data once the transaction is completed
    function setMyString(string memory _myString) public {
        myString = _myString;
    }
        

    function compareTwoStrings(string memory _myString) public view returns(bool){
        
        // return myString == _myString; --> wont work since the == operator is not compatible for strings.
        // Need to use the kecca256 hash to convert the strings to a hash
        return keccak256(abi.encodePacked(myString)) == keccak256(abi.encodePacked(_myString));
    }
}