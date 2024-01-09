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
        // What if we dont know that the smart contract we want to send to is a smart contract?
        // Use the encodeEithSignature function
        bytes memory payload = abi.encodeWithSignature("depost()");
         (bool success, ) = _contractOne.call{value: 10, gas: 100000}(payload);
        require (success);

        
        // To make sure that the value specified in deposit actually goes to the addressBalances, use syntax {}
        // and specify a higher gas. send and transfer only allocate 2300gas to be executed. This is far too little. 
        // We can specify higher gas allocation to ensure the funds are sent
        /*ContractOne one = ContractOne(_contractOne);
        one.deposit{value: 10, gas: 100000}();*/
    }
}