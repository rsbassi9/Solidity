//SPDX-License-Identifier: MIT

pragma solidity 0.7.0;

contract ExampleExceptionsRequire {

    mapping(address => uint) public balanceReceived;

    function receiveMoney() public payable {
        balanceReceived[msg.sender] += balanceReceived;
    }

    function withdrawMoney(address payable _to, uint _amount) public {

       /*  Below, if the amount withdrawn entered by the user is greater than the balance received, then the transaction simply doesnt go through
        // check if the amount being sent is less than the balance received
        if(_amount <= balanceReceived[msg.sender]) {
            //decerease the balance Received by the amount
            balanceReceived[msg.sender] -= _amount;
            // transfer the amount
            _to.transfer(_amount);
        }
        */

        // In order to provide the user with a better experience, we want them to know why it failed. here we use require:
        // If the first argument is false, the entire transaction is rolled bakc, and the error message is displayed
        require(_amount <= balanceReceived[msg.sender], "Not enough funds, aborting!");
            //decerease the balance Received by the amount
            balanceReceived[msg.sender] -= _amount;
            // transfer the amount
            _to.transfer(_amount);
    
    }
}