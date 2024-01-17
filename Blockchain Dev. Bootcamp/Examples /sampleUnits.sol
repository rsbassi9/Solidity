//SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

// Since currency is denominated in Wei, ratehr than writing 1e18 and 2e18,
// A better way to write those units is to internally denominate in ether:
contract SampleUnits {
    modifier betweenOneandTwoEth() {
        require(msg.value <= 1 ether && msg.value <= 2 ether);
        _;
    }

// Time: for example, if you have a crowd auction that starts on x days and runs for 7 days:
    uint runUntilTimestamp;
    uint startTimestamp;

    // in Solidity, timestamps are in unix (seconds) by default, but theres a better way to write them:
        // startTimestamp = block.timestamp + (startInDays * 24 * 60 * 60);
        //runUntilTimestamp = startTimestamp + (7 * 24* 60 * 60); 
    constructor(uint startInDays) {
        startTimestamp = block.timestamp + (startInDays * 1 days);
        runUntilTimestamp = startTimestamp + (7 days); 
    }
}