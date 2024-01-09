//SPDX-License-Identifier: MIT

pragma solidity 0.8.23;

contract Sender {

// A callback function to receive funds
    receive() external payable {}

// Both the functions below send 10 Wei to the _to address. So which one should you use in a scenario, and why?
    //this function throws an exception when the transfer fails
    function withdrawTransfer(address payable _to) public {
        _to.transfer(10);
    }

    // This function returns a bool. 
    // In case you are using a low level interaction with smart contracts, the send function is a low level interaction.
    // It doesnt care about whats happening on the other side. All it cares about is sending the Wei, and if sucessful, returns a boolean.
    function withdrawSend(address payable _to) public {
       bool isSent = _to.send(10);

       require(isSent, "Sending the funds was unsuccessful.");
    }
}

//to explain the difference, note the contract below
    // The first is a receiver function that has no action and receives any funds
    // It simply receives the funds 
contract ReceiverNoAction {
    
    //give it the ability to return a balance
    function balance() public view returns(uint) {
        return address(this).balance;
    }
    receive() external payable {} // 
}

    // The second has an action, where it writes to a storage variable (balanceReceived).
    // This costs a lot of gase, especially the first time this write happens
contract ReceiverAction {
    uint public balanceReceived;

    receive() external payable {
        balanceReceived += msg.value;
    }

    //give it the ability to return a balance
    function balance() public view returns(uint) {
        return address(this).balance;
    }
}