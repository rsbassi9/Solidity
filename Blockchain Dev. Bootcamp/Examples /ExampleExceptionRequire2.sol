//SPDX-License-Identifier: MIT

pragma solidity 0.7.0;

contract ExampleExceptionsRequire {

// Use uint8 to optimize for gas by making variable types small
// The issue with this is rollover. Since uint8 represets 0-255, if we send 257Wei, it rolles over,
// i.e, 256 =0, 257=1....etc
    mapping(address => uint8) public balanceReceived;

    function receiveMoney() public payable {
        // to prevent the above from happening, use assert statements:
        // this works kind of a require satement. if the statement evaluates to false, the execution of the smart contract is stopped.
        // here we assert that the msg.value is the same ase the unsigned interger8 of our msg.value. However, since this cannot be true due to the rollback functionality
        // what happens with an assert statement (in this case, for example, since the numbers cannot match) is that the contract goes into a panic mode, eats all the gas, and ensures that this cannot be executed.
        assert(msg.value == uint8(msg.value));
        balanceReceived[msg.sender] += uint8(msg.value);
    }

    function withdrawMoney(address payable _to, uint8 _amount) public {
         require(_amount <= balanceReceived[msg.sender], "Not enough funds, aborting!");
            //decerease the balance Received by the amount
            balanceReceived[msg.sender] -= _amount;
            // transfer the amount
            _to.transfer(_amount);
    
    }
}