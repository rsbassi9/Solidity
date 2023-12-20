//SPDX-License-Identifier: MIT

pragma solidity 0.8.15;

contract ExampleStrings {

    string public myString = "Hello World";
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

    // Better to use bytes in smart contracts since we can get their length using the .length method.
    // For strings, getting their length may be harder since they are represented as utf8, therefore some characters may be represented by 2 bytes 
    function getBytesLength() public view returns(uint) {
        return _myBytes.length;
    }
}

/*

NOTES:

Strings are actually Arrays, very similar to a bytes-array.
If that sounds too complicated, let me break down some quirks for you that are somewhat unique to Solidity:

1. Natively, there are no String manipulation functions.
2. No even string comparison is natively possible
3. There are libraries to work with Strings
4. Strings are expensive to store and work with in Solidity (Gas costs, we talk about them later)
5. As a rule of thumb: try to avoid storing Strings, use Events instead (more on that later as well!)

There are no native string comparison functions in Solidity. There is still a way to compare two strings: by comparing their keccak256 hashes.

Strings are actually arbitrary long bytes in UTF-8 representation. Strings do not have a length property, bytes do have that.

*/

