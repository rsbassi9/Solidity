//SPDX-License-Identifier: MIT

pragma solidity 0.8.23;

contract Sender {

// A callback function to receive funds
    receive() external payable {}

// Both the functions below send 10 Wei to the _to address. So which one should you use in a scenario, and why?
    function withdrawTransfer(address payable _to) public {
        _to.transfer(10);
    }

    function withdrawSend(address payable _to) public {
        _to.send(10);
    }
}