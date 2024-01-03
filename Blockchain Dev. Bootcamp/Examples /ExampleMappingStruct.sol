//SPDX-License-Identifier: MIT

pragma solidity 0.8.15;

// Below, we create separate functions to send and withdraw monet
// But this doesnt track a lot, unless you look at a block explorer
contract MappingStructExample {
    mapping(address => uint) balance;

    function depositMoney() public payable {
        balance[msg.sender] += msg.value;
    }

    function withdrawMoney(address payable _to, uint _amount) public {
        balance[msg.sender] -= _amount;

        _to.transfer(_amount);
    }
}