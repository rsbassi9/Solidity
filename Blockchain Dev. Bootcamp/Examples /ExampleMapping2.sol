//SPDX-License-Identifier: MIT

pragma solidity 0.8.15;

contract ExampleMappingWithdrawals {

    // Use a mapping to track the balances received
    mapping(address=>uint) public balanceReceived;
    
    function sendMoney() public payable {

    }

    functtion getBalance() public view returns(uint){
        return address(this).balance;
    }

    function withdrawAllMoneu(address payable _to) public {
        _to.trasfer(getBalance());
    }
}