//SPDX-License-Identifier: MIT

pragma solidity 0.7.0;

contract ExampleExceptionsRequire {

    mapping(address => uint) public balanceReceived;

    function receiveMoney() public payable {
        balanceReceived[msg.sender] += msg.value;
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

/*
NOTES:
Require is here for user-input validation and if it evaluates to false, it will throw an exception.

For example require(false) or require(1 == 0) will throw an exception. You can optionally add an error message require(false, "Some Error Message")

DEPLYING AND RUNNING THE CONTRACT:
**Make sure the contract is being run on the correct version**
Deploy the Smart Contract. Head over to the "Deploy & Run Transactions" Plugin and Deploy it.
Copy your address into the withdraw money field.
Enter a number, like 1000, and
Hit withdrawMoney --- If you enter a higher amount than 1000, you get the error in the log window

 */