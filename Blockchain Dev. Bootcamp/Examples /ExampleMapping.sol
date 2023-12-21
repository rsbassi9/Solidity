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

    function setMyAddressToTrue() public {
        myAddressMapping[msg.sender] = true;
    }

    function setUintUintBoolMapping(uint _key1, uint _key2, bool _value) public {
        uintUintBoolMapping[_key1][_key2] = _value;
    }
}