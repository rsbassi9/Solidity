//SPDX-License-Identifier: MIT

pragma solidity 0.8.15;

contract ExampleMappingWithdrawals {


    function sendMoney() public payable {

    }

    functtion getBalance() public view returns(uint){
        return address(this).balance;
    }
}