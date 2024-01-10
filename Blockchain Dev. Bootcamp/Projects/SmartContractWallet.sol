//SPDX-License-Identifier: MIT

pragma solidity 0.8.16;

contract SmartContractWallet {

    address payable owner;

    // Allowance functionality to spend a certain amount of funds
    mapping(address => uint) public allowance;
    mapping(address => bool) public isAllowedToSend;

    // Set the owner of the wallet
    constructor() {
        owner = payable(msg.sender);
    }

    // Setter function to prevent sending if you are not allowed to
    function setAllowance(address _for, uint _amount) public {
        require(msg.sender == owner, "You are not the owner, aborting!");
        allowance[msg.sender] = _amount;

        if(_amount > 0) {
            isAllowedToSend[_for] = true;
        } else {
            isAllowedToSend[_for] = false;
        }
    }

    // Transferrability of funds
    function transfer(address payable _to, uint _amount, bytes memory _payload) public returns(bytes memory) {
        //require(msg.sender == owner, "You are not the owner, aborting!");
        if(msg.sender != owner) {
            require(allowance[msg.sender] >= _amount, "You are trying to send more than you are allowed, aborting");
            require(isAllowedToSend[msg.sender], "You are not allowed to send anything from this smart contract, aborting");

            //reduce teh allowance once sent
            allowance[msg.sender] -= _amount;
        }

        (bool success, bytes memory returnData) = _to.call{value: _amount}(_payload);
        require(success, "Aborting, call was not successful");
        return returnData;
    }

    // Allow the wallet to receiver funds no matter what
    receive() external payable {}

    

}