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

/*
NOTES:
So far we relied on simple datatypes like addresses, uint or booleans. Previously, we also grouped them together into structs and I showed you the difference between using smart contracts as data-stores vs structs as data-stores. But what if that's not enough and you need to track them in an array-like data-structure? 
Maybe you want to track the timestamp when a deposit happened. You want to track every single deposit from every user. 
You want to track how many deposits happened, and many more details.

For the sake of this example, think about it like this:

While you are tracking the current balance with a mapping that maps address to uint (mapping( address => uint ) balanceReceived) with something schematically like balanceReceived[THE-ADDRESS] = THE-UINT, with a struct you would access the children with a . (period), while still retaining the mapping.

Let's say you have a struct
MyStruct {
    uint abc;
}

mapping(address => MyStruct) someMapping;

Then you would write to the mapping like this someMapping[THE-ADDRESS].abc = THE-UINT. Why is this useful? Let's have a look into our Smart Contract!


NB:
Mappings have no length. It's important to understand this. Arrays have a length, but, because how mappings are stored differently, they do not have a length.
Let's say you have a mapping mapping(uint => uint) myMapping, then all elements myMapping[0], myMapping[1], myMapping[123123], ... are already initialized with the default value. 
If you map uint to uint, then you map key-type "uint" to value-type "uint".

**Note on structs:
Similar to anything else in Solidity, structs are initialized with their default value as well.

If you have a struct

struct Transaction {
    uint amount;
    uint timestamp;
}
and you have a mapping mapping(uint => Transaction) myMapping, then you can access already all possible uint keys with the default values. This would produce no error:
myMapping[0].amount, or myMapping[123123].amount, or myMapping[5555].timestamp.

Similar, you can set any value for any mapping key:

myMapping[1].amount = 123 is perfectly fine.


In our smart contract above:
struct Transaction {
        uint amount;
        uint timestamp;
    }

    struct Balance {
        uint totalBalance;
        uint numDeposits;
       ** mapping(uint => Transaction) deposits; **
        //...
    }

    mapping(address => Balance) public balanceReceived;
    //...

Because mappings have no length, we can't do something like balanceReceived.length or payments.length. It's technically not possible. In order to store the length of the deposits mapping, we have an additional helper variable numDeposits.

So, if you want to the first payment for address 0x123... you could address it like this: balanceReceived[0x123...].deposits[0].amount = .... 
But that would mean we have static keys for the payments mapping inside the Balance struct. We actually store the keys in numDeposits, that would mean, the current payment is in balanceReceived[0x123...].numDeposits. 
If we put this together, we can do balanceReceived[0x123...].deposits[balanceReceived[0x123...].numDeposits].amount = ....

 */