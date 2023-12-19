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

    // if there is data:
// note: payable is optional here. 
    // if you want a function thats called in case no other function matches the data, thjis function is called.
    // if you want the fallback to also be able to receive a value - add the payable modifier
    fallback() external payable{
        lastValueSent = msg.value;
        lastFunctionCalled = "fallback";
    }
}