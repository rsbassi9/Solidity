//SPDX-License-Identifier: MIT

pragma solidity 0.8.15;

contract ExampleViewPure {

    uint public myStorageVariable;

    //both view and pure functions are reading operations

    // view functions can access storage variables / variables outside the scope of the function, but cannot write them
    function getMyStorageVariable() public view returns(uint) {
        return myStorageVariable;
    }

    // pure functions can only call varibales that are not storage variables, or other pure functions
    // in this example, a and b are not storage variables, just parameters
    function getAddition(uint a, uint b) public pure returns(uint){
        return a+b;
    }

    // An example of a writing function:

    function setMyStorageVariable(uint _newVar) public {
        myStorageVariable = _newVar;
    }

    // Writing functions usually dont have return variables - these are strictly used to interact with other smart contracts, eg. do not use something like this:

   /* function setMyStorageVariable(uint _newVar) public returns(uint) {
        myStorageVariable = _newVar;
        return newVar;
    }
    */
}

/*

Writing, View and Pure Functions

So far, we have mostly interacted and modified state variables from our Smart Contract. For example, when we write the address, we modify a state variable. When we update an uint variable, we also modify the state.

For this, we needed to send a transaction. That works very transparently in Remix and also looks instantaneous and completely free of charge, but in reality it isn't. Modifying the State costs gas, is a concurrent operation that requires mining and doesn't return any values.

Reading values, on the other hand, is virtually free and doesn't require mining.

There are two types of reading functions:

view: Accessing state variables
pure: Not accessing state variables

Writing Functions:
As before, let's quickly create a state-modifing writing function:

//SPDX-License-Identifier: MIT

pragma solidity 0.8.15;

contract ExampleViewPure {

    uint public myStorageVariable;

    function setMyStorageVariable(uint _newVar) public returns(uint) {
        myStorageVariable = _newVar;
        return _newVar;
    }


}
As you can see here, a writing function can have return variables, but they won't actually return anything to the transaction initializer. There are several reason for it, but the most prominent one is: at the time of sending the transaction the actual state is unknown. It is possible that someone sends a competing transaction that alters the state and from there it only depends on the transaction ordering - which is something that happens on the miner side. You will see that extensively in the next section.

What's the return variable for then?

It's for Smart Contract communication. It is used to return something when a smart contract calls another smart contract function.

How to return variables then in Solidity? With Events! Something we're talking about later on.

View Functions:
A view function is a function that reads from the state but doesn't write to the state. A classic view function woule be a getter-function. Let's extend the smart contract and write one:

//SPDX-License-Identifier: MIT

pragma solidity 0.8.15;

contract ExampleViewPure {

    uint public myStorageVariable;

    function getMyStorageVariable() public view returns(uint) {
        return myStorageVariable;
    }

    function setMyStorageVariable(uint _newVar) public returns(uint) {
        myStorageVariable = _newVar;
        return _newVar;
    }


}
Pure Functions:
A pure function is a function that neither writes, nor reads from state variables. It can only access its own arguments and other pure functions. Let me give you an example:

//SPDX-License-Identifier: MIT

pragma solidity 0.8.15;

contract ExampleViewPure {

    uint public myStorageVariable;

    function getMyStorageVariable() public view returns(uint) {
        return myStorageVariable;
    }

    function getAddition(uint a, uint b) public pure returns(uint) {
        return a+b;
    }

    function setMyStorageVariable(uint _newVar) public returns(uint) {
        myStorageVariable = _newVar;
        return _newVar;
    }


}

*/