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

    function withdrawAllMoney(address payable _to) public {
       // Transfer the balance received to the sender
        // FIRST apply the effect, THEN have the interaction to prevent a re-entrancy attack
        uint balanceToSendOut = balanceReceived[msg.sender];
        balanceReceived[msg.sender] = 0;
        _to.transfer(balanceToSendOut);
    }
}