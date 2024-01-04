//SPDX-License-Identifier: MIT

pragma solidity 0.7.0;

contract ExampleExceptionsRequire {

    mapping(address => uint) public balanceReceived;

    function receiveMoney() public payable {
        balanceReceived[msg.sender] += balanceReceived;
    }

    function withdrawMoney(address payable _to, uint _amount) public {
        
        // check if the amount is less than the balance received
        if(_amount <= balanceReceived[msg.sender]) {
            //decerease the balance Received by the amount
            balanceReceived[msg.sender] -= _amount;
            // transfer the amount
            _to.transfer(_amount);
        }
    }
}