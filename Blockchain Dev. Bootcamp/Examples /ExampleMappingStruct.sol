//SPDX-License-Identifier: MIT

pragma solidity 0.8.15;

// Below, we create separate functions to send and withdraw monet
// But this doesnt track a lot, unless you look at a block explorer
contract MappingStructExample {

        // instead of  something like this: mapping(address => uint) balance;
      //use a struct to record  a transaction:
    struct Transaction {
        uint amount;
        uint timestamp;
    }

    // use another struct to keep the balance instead of using a simple unsigned integer
        // Here we track the current balance, number of deposits, actual deposits, number of withdrawals and the actual withdrawals
    struct Balance {
        uint totalBalance;
        uint numDeposits;
        //a mapping to track the transaction for each deposit
        mapping(uint => Transaction) deposits;
        uint numWithdrawals;
        //a mapping to track the transaction for each withdrawal
        mapping(uint => Transaction) withdrawals;
    }


    // Then we replace: mapping(address => uint) balance;
    mapping (address => Balance) public balances;

    //a function to ge the number of deposits
    function getDepositNum(address _from, uint _numDeposit) public view returns(Transaction memory) {
        return balances[_from].deposits[_numDeposit];
    }

    function depositMoney() public payable {
       // Now, we can replace: balance[msg.sender] += msg.value;
    // We can access variables from our struct using "." . Below, we want to increase out totalBalance by the msg.value, but also want to record a new transaction
       balances[msg.sender].totalBalance += msg.value;

       Transaction memory deposit = Transaction(msg.value, block.timestamp);
       // now place this transaction on the current position of deposits (i.e, iots an array of [0,1,...], and then increment the number of deposits
       // So, for the current address that deposits, we get the deposits, access the number of deposits and assign it as the deposit
       balances[msg.sender].deposits[balances[msg.sender].numDeposits] = deposit;
       balances[msg.sender].numDeposits++;
       
    }

    // Do the same for withdrawals
    function withdrawMoney(address payable _to, uint _amount) public {
        balances[msg.sender].totalBalance-= _amount;

        Transaction memory withdrawal = Transaction(_amount, block.timestamp);
        balances[msg.sender].withdrawals[balances[msg.sender].numWithdrawals] = withdrawal;
        balances[msg.sender].numWithdrawals++;

        _to.transfer(_amount);
    }
}