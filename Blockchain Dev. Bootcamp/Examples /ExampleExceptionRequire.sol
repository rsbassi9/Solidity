//SPDX-License-Identifier: MIT

pragma solidity 0.7.0;

contract ExampleExceptionsRequire {

    mapping(address => uint) public balanceReceived;

    function receiveMoney() public payable {
        balanceReceived[msg.sender] += balanceReceived;
    }

    function withdrawMoney(address payable _to, uint _amount) public {
        
        // check if the amount being sent is less than the balance received
        if(_amount <= balanceReceived[msg.sender]) {
            //decerease teh balance Received by the amount
            balanceReceived[msg.sender] -= _amount;
            // transfer teh amount
            _to.transfer(_amount);
        }
    }
}