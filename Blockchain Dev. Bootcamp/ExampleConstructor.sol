//SPDX-License-Identifier: MIT

pragma solidity 0.8.15;


contract ExampleConstructor {

     address public myAddress;

     // A constructor is a  special function that does not carry the function keyword:
     // It has no visibility specifier
     // The special thing is that it is DEIRECTLY CALLED ONCE during depolyment of a smart contract. It cannot be overloaded.
     // You cannot NOT call it.
     constructor(address _someAddress) { 
        myAddress = _someAddress;
     }

     function setMyAddress(address _myAddress) public {
        myAddress = _myAddress;
     }

    function setMyAddressToMsgSender() public {
        myAddress = msg.sender;
    }
}   