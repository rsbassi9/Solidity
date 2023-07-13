// Get funds from users
// Withdraw funds
// Set a minimum funding value in USD

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./PriceConverter.sol";

// Save gas by storing out error as a fixed function, rather than stating each character in our require statements. This saves gas since we dont have to store each character
// in "Sender is not owner!" on the blockchain
error NotOwner();

contract FundMe {
    using PriceConverter for uint256;

    //constant keyword used so that it doesnt take up a storage spot on our smart contract --> less gas used
    // constant variables are typically written in all upper case
    uint256 public constant MUNIMUM_USD = 50 * 1e18;

    // Create an array of funders of all the addresses that send funds

    address[] public funders;

    // Create a mapping of address to how much money each sends
    mapping(address => uint256) public addressToAmountFunded;

    // make a constructor. This function gets called immediately when a contract is deployed
    // We want the withdraw function to be called only by the owner of the contract:
    // immutable used to save gas since we wont change this variable. immutable variables are written with the i_" prefix
    address public immutable i_owner;

    constructor() {
        i_owner = msg.sender; // whoever deploys the contract = owner
    }

    // payable keyword allows the function to have the ability to be read as a transaction function

    function fund() public payable {
        // Want to be able to set a minimum fund amount in USD
        // 1. How do we send ETH to this contract

        // require (a , b) if a is false, return b. if a is not true, then the transaction is cancelled and any prior work is undone
        //msg.value is the value of ETH/wei/gwei we input in the Value section of the Deploy and Run tab.
        // 1ETH = 1 * 10^18 wei.

        // Below, we have set the require function to value (in terms of ETH/wei/gwei) but have our value set to MUNIMUM_USD. If there are insufficient funds being sent, the statement will fail
        // USD is a concept given to the price of ETH outside the blockchain, thus, solidity does not know what the USD value of ETH is. For this, we will need to use
        // a decentralized oracle network to attain the value of ETH in USD from outside the Blockchain.

        //msg.value gets the native blockchain tokens value

        require(
            msg.value.getConversionRate() >= MUNIMUM_USD,
            "Didn't send enough"
        ); //18 decimal places due to Wei value in ETH
        funders.push(msg.sender); // msg.sender is an always available function like msg.value
        addressToAmountFunded[msg.sender] = msg.value;
    }

    // When we withdraw funds to use, we will need to reset the funders array and addressToAmountFunded to 0. Use of for loop
    // by placing our modifier after public, we tell the function to first look at our morifier, do whats in it (i.e, set the address to that of the owner) then execute the rest of the code (_;)
    function withdraw() public onlyOwner {
        for (
            uint256 funderIndex = 0;
            funderIndex < funders.length;
            funderIndex++
        ) {
            address funder = funders[funderIndex]; // set the funder address to each index of the Funders array
            addressToAmountFunded[funder] = 0; // reset the amount funded by the funders address to 0
        }
        //reset the array. funders now equals a new address array, with (0) elements to start.
        funders = new address[](0);

        //withdraw the funds: 3 ways
        //transfer ( if gas > 2300, throws error)
        //msg.sender = address
        //payable(msg.sender) = payable address
        //payable(msg.sender).transfer(address(this).balance);

        //send (if gas > 2300, throws bool. Therefore need to manage the bool with a require method)
        //bool sendSuccess = payable(msg.sender).send(address(this).balance);
        //require(sendSuccess, "Send failed");

        //call (very powerful. dont need ABI to use this function on any other function in Ethereum)  (No gas limit. throws bool. Therefore need to manage the bool with a require method)
        //.call("") -- place any info you want to call from another function in the double quotes
        // below, we will use this like a transaction, so we need to use msg.value
        // since the function below returns 2 alues, we need to store them in ( , ). If we leave teh second variable blank (after the comma)
        // we are stating that we know theres a second variable returned, but we dont care to emphasize what to name it.
        (bool callSuccess, ) = payable(msg.sender).call{
            value: address(this).balance
        }("");
        require(callSuccess, "Call failed");
    }

    // create a modifier to insert
    modifier onlyOwner() {
        //require(msg.sender == i_owner, "Sender is not owner!"); // takes up too much space by having to store the characters on the blockchain. Instead:
        if (msg.sender != i_owner) revert NotOwner(); // this is more gas efficient. It does the same thig the require statement does, without the conditional beforehand

        _; // means execute the code in the function. here we are saying that the owner address needs to be verified before teh rest of the withdraw function executes
        // if _; was placed above the require statement, then the function the modifier is used on would execute first, and then verify the owner.
    }

    // what happens if someone sends this contract ETH without calling the fund function?
    // if people send money to this contract, but the function doesnt exist / is called incorrectly, we can still trigger the fund function using:
    // This happens if someone sends funds using a wallet, rather than going directly through the fund function in FundMe.sol
    
    receive() external payable {
        fund();
    }
    fallback() external payable {
        fund();
    }
}
