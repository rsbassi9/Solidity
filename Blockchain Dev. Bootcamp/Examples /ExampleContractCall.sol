//SPDX-License-Identifier: MIT

pragma solidity 0.8.23;

contract ContractOne {

    mapping (address=> uint) public addressBalances;

    function deposit() public payable {
        addressBalances[msg.sender] += msg.value;
    }
}

contract ContractTwo {
    receive() external payable {}

    function depositOnContractOne(address _contractOne) public {
        ContractOne one = ContractOne(_contractOne);
        // To make sure that the value specified in deposit actually goes to the addressBalances, use syntax {}
        // and specify a higher gas. send and transfer only allocate 2300gas to be executed. This is far too little. 
        // We can specify higher gas allocation to ensure the funds are sent
        one.deposit{value: 10, gas: 100000}();
    }
}