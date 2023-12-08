//SPDX-License-Identifier: MIT

pragma solidity 0.8.15;

contract ExampleAddress {

    address public someAddress;

    function setSomeAddress(address _someAddress) public {
        someAddress= _someAddress;
    }

    // To get the balance of an address in wei (1 ETH = 1-^18 wei)
    function getAddressBalance() public view returns(uint) {
        return someAddress.balance;
    }
}
