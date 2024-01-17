//SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

// Since currency is denominated in Wei, ratehr than writing 1e18 and 2e18,
// A better way to write those units is to internally denominate in ether:
contract SampleUnits {
    modifier betweenOneandTwoEth() {
        require(msg.value <= 1 ether && msg.value <= 2 ether);
        _;
    }
}