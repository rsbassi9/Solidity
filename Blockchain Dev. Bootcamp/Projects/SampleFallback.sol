//SPDX-License-Identifier: MIT

pragma solidity 0.8.14;

contract SampleFallback {

    uint public lastValueSent;

// a Receive function only relies on 2300gas (gas stipend) - which is very low.
// If another contract interacts with this contract, nothing meaningful can really happen due to the low gas amount
    // i.e, if there is no data to send, and only a value transfer without any data attached to the smart contract - it automatically hits the receive function
    receive() external payable {
        lastValueSent = msg.value;
        lastFunctionCalled = "receive";
    }
}