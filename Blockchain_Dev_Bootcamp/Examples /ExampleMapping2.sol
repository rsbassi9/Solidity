//SPDX-License-Identifier: MIT

pragma solidity 0.8.15;

contract ExampleMappingWithdrawals {

    // Use a mapping to track the balances received
    mapping(address=>uint) public balanceReceived;

    function sendMoney() public payable {
        balanceReceived[msg.sender] +=  msg.value;
    }

    function getBalance() public view returns(uint){
        return address(this).balance;
    }

    // A function to withdraw only partial funds
    function withdrawMoney(address payable _to, uint _amount) public {
        require(_amount <= balanceReceived[msg.sender], "not enough funds");
        balanceReceived[msg.sender] -= _amount;
        _to.transfer(_amount);
    }

    function withdrawAllMoney(address payable _to) public {
       // Transfer the balance received to the sender
        // FIRST apply the effect, THEN have the interaction to prevent a re-entrancy attack
        uint balanceToSendOut = balanceReceived[msg.sender];
        balanceReceived[msg.sender] = 0;
        _to.transfer(balanceToSendOut);
    }
}

/*When someone sends money using the "sendMoney" function, we track the msg.value (amount in Wei) with the balanceReceived mapping for the person who interacted with the Smart Contract.

If that same person tries to withdraw money again using "withdrawAllMoney", we look in that mapping how much he sent there previously, then reset the mapping and send the amount. */