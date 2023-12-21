//SPDX-License-Identifier: MIT

pragma solidity 0.8.15;

contract ExampleMapping {

    //This works very much like an array - with all uint values assigned the default value of the boolean
    // i.e false
    mapping(uint => bool) public myMapping;

    // A useful case for this for addresses is whitelisting, or having a maximum withdraw amount, for example
    mapping(address => bool) public myAddressMapping;

    // Mappings of mappings can be used too
    mapping(uint => mapping(uint => bool)) public uintUintBoolMapping;

    //A function to take a uint and change its value to true
    function setValue(uint _index) public {
        myMapping[_index] = true;
    }

//This function does several things:
// It accesses the global msg-object and gets the senders address. So, if you are interacting with a specific address, then for the Smart Contract that address will be in msg.sender
// It accesses the myAddressMapping mapping and sets the value "true" for the current address.
    function setMyAddressToTrue() public {
        myAddressMapping[msg.sender] = true;
    }

    function setUintUintBoolMapping(uint _key1, uint _key2, bool _value) public {
        uintUintBoolMapping[_key1][_key2] = _value;
    }
}

/*
NOTES:
Mapping are an interesting datatype in Solidity. 
They are accessed like arrays, but they have one major advantage: All key/value pairs are initialized with their default value.

We can access a mapping with the brackets []. If we want to access the key "123" in our myMapping, then we'd simply write myMapping[123].

Our mappings here are public, so Solidity will automatically generate a getter-function for us. That means, if we deploy the Smart Contract, we will automatically have a function that looks technically like this:

function myMapping(uint index) returns (bool) {
    return myMapping[index];
}


*/