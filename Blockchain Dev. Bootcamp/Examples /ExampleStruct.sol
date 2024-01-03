//SPDX-License-Identifier: MIT

pragma solidity 0.8.15;

// If you deploy the "Wallet" smart contract and send 1 wei to the payContract function (1) , it will use up 221530 gas (2). Why? Because it deploys a new contract "PaymentReceived", then links it.
// If you now want to interact with the contract, you actually need to tell Remix where to find its address (3) and then interact with it because its a normal contract (4).

// Now,  this is the "normal" way for everyone who is coming from an object oriented language out there. And there are good reasons to do so normally, but with Solditiy you are facing the challenge of limited resources
contract Wallet {

    PaymentReceived public payment;

    function payContract() public payable {
        payment = new PaymentReceived(msg.sender, msg.value);
    }
}

contract PaymentReceived {
    address public from;
    uint public amount;

    constructor(address _from, uint _amount) {
        from = _from;
        amount = _amount;
    }
}

// How the same goal can be achieved with a  struct:
    // Structs are needed to :
            // a) save gas. Using a struct in this case saved about 2.5x less gas
            // b) Complexity.
            // c) to prevent repetition and increase simplicity

 //Let's change the Smart Contract above to use a struct instead. A struct is a way to generate a new DataType, by basically grouping several simple Data Types together - or group groups of simple types together, like a mapping.

//If you interact with the contract now, and you send the same 1 wei to the payContract function you will witness two things:
    //It suddenly costs only 75394 gas (almost 3 times less!)
    //You can directly interact with the payment public getter function without interacting with a separate contract.
contract wallet2 {

    struct PaymentReceivedStruct {
        address from;
        uint amount;
    }

    PaymentReceivedStruct public payment;

    // Now we can use the struct in the function, without the need for the "new" keyword
    function payContract() public payable {
        payment = PaymentReceivedStruct(msg.sender, msg.value);

        // Alternatively, we can have the payment variable above broken up for clarity:
       // payment.from = msg.sender;
       // payment.amount = msg.value;
    }
}

/*

If you come from an object oriented programming language, you are normally used to declare a new class for logical group of variables.

In solidity you could define a new contract and give it certain properties, but usually that's extremely gas inefficient.

Solidity uses structs to define new datatypes and group several variables together.


What is better: Solidity struct vs Child Contract?¶
Most of the time, its better to save on gas costs and use structs. This can also include very complex data structures as you will see later.

Good reasons to use Structs over Child Contract:

-Saving Gas Costs! Deploying Child Contracts is simply more expensive.
-Saving Compexity: Every time you need to access a child contracts property or variable, it needs to go through the child contracts address. For structs, internally, that's just an keccak hash for a lookup at the storage location.
-DRY/KISS principle (Don't repeat yourself, keep is simple, stupid): Contracts are code. Every time you deploy the same contract with the same code you basically repeated yourself. And its not really simple either.
-Attack Vector: Contracts are running on its own address. If you have a set of getter and setter functions, there is a chance you need to have access lists or permissions that need to be managed separately.

Having said all this, there are also good reasons for using Child Contracts over Structs:
-Contract can have any code you want and that means the power of composability. You can put the contracts together like lego pieces and each contrac can have its own logic built in.
-Smaller Contracts if the code is split across several contracts. In the particular example above, you don't need to get payments from the wallet contract, you can get the payments from the child contract.
-Access: Contracts have their own address, can have their own data structures and their own interfaces.

*/