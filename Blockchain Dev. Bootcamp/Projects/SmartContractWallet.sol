//SPDX-License-Identifier: MIT

pragma solidity 0.8.16;

// Add a Consumer wallet to test interactability of our main contract
contract Consumer {
    function getBalance() public view returns (uint){
        return address(this).balance;
    }

    function deposit() public payable {}
}

contract SmartContractWallet {

    address payable public owner;

    // Allowance functionality to spend a certain amount of funds
    mapping(address => uint) public allowance;
    mapping(address => bool) public isAllowedToSend;

    //Set the owner to a different address by a minimum of 3 guardians in case the funds are lost (e.g, the owner loses their private key)
    mapping(address => bool) public guardians;
    
    // We will the want the ability to set a new owner automatically when 3 the guardians agree on teh new owner
    address payable nextOwner;
    // A Way to keep track of whether a guardian has voted on the address or not
    mapping(address => mapping(address => bool)) nextOwnerGuardiantVotedBool;
    uint guardiansResetCount;
    uint public constant confirmationsFromGuardianForReset = 3;

    // Set the owner of the wallet
    constructor() {
        owner = payable(msg.sender);
    }

    // Make the guardians
    function setGuardian(address _guardian, bool _isGuardian) public {
        require(msg.sender == owner, "You are not the owner, aborting!");
        guardians[_guardian] = _isGuardian;
    }

    // Make a function to set the new owner after the guardians agree
    function proposeNewOwner(address payable _newOwner) public {
        require(guardians[msg.sender], "You are not a guardian of this wallet, aborting!");
        require(nextOwnerGuardiantVotedBool[_newOwner][msg.sender] == false, "You already voted, aborting");
        // set the new owner of the wallet, and then reset the guardian count
        if(_newOwner != nextOwner) {
            nextOwner = _newOwner
            guardiansResetCount = 0;
        }

        guardiansResetCount++;

        // Count the guardians that vote until all 3 vote.
        if(guardiansResetCount >= confirmationsFromGuardianForReset) {
            owner = nextOwner;
            nextOwner = payable(address(0)); 
        }
    }

    // Setter function to prevent sending if you are not allowed to spend any funds
    function setAllowance(address _for, uint _amount) public {
        require(msg.sender == owner, "You are not the owner, aborting!");
        allowance[_for] = _amount;

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