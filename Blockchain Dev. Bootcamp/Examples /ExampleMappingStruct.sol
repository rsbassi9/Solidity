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
        uint numwithdrawals;
        //a mapping to track the transaction for each withdrawal
        mapping(uint => Transaction) withdrawals;
    }


    function depositMoney() public payable {
        balance[msg.sender] += msg.value;
    }

    function withdrawMoney(address payable _to, uint _amount) public {
        balance[msg.sender] -= _amount;

        _to.transfer(_amount);
    }
}