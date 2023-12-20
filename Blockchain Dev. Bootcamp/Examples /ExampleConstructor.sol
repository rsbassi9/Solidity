//SPDX-License-Identifier: MIT

pragma solidity 0.8.15;

/*

The constructor is a special function. It is automatically called during Smart Contract deployment. And it can never be called again after that.

It also has a special name! It's simply called constructor() { ... }.

Let's see how that works to our advantage. Let's extend the Smart Contract we wrote before to make it a bit more secure.

constructor(): is a special function that is called only once during contract deployment. It can have arguments, like here. But it also has the same global objects available as in any other transaction. So in msg.sender is the address of the person who deployed the Smart Contract, which you can use.

*/

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