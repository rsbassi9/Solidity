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


/*

NOTES:

Ethereum supports transfer of Ether and communication between Smart Contracts. Those reside on an address. Addresses can be stored in Smart Contracts and can be used to transfer Ether from the Smart Contract to to an address stored in a variable.

That's where variables of the type address come in.

In general, a variable of the type address holds 20 bytes. 

IMPORTANT:
please pay special attention to the following few concepts here which are really important and different than in any other programming language:

1. The Smart Contract is stored under its own address
2. The Smart Contract can store an address in the variable "someAddress", which can be its own address, but can be any other address as well.
3. All information on the blochain is public, so we can retrieve the balance of the address stored in the variable "someAddress"
4. The Smart Contract can transfer funds from his own address to another address. But it cannot transfer the funds from another address.
5. Transferring Ether is fundamentally different than transferring ERC20 Tokens or NFTs, as you will see later.


Ethereum denominations:
Unit	Wei Exp	Wei
wei	1	1
Kwei	10^3	1,000
Mwei	10^6	1,000,000
Gwei	10^9	1,000,000,000
Ether	10^18	1,000,000,000,000,000,000

*/