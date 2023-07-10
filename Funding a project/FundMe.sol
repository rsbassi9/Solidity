// Get funds from users
// Withdraw funds
// Set a minimum funding value in USD

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import"./PriceConverter.sol";

contract FundMe {

    using PriceConverter for uint256;

    uint256 public minimumUsd = 50 * 1e18;

    // Create an array of funders of all teh addresses that send funds

    address [] public funders;

    // Create a mapping of address to how much money each sends
    mapping(address => uint256) public addressToAmountFunded;


    // payable keyword allows the function to have the ability to be read as a transaction function

    function fund() public payable{
        // Want to be able to set a minimum fund amount in USD
        // 1. How do we send ETH to this contract

        // require (a , b) if a is false, return b. if a is not true, then the transaction is cancelled and any prior work is undone
        //msg.value is the value of ETH/wei/gwei we input in the Value section of the Deploy and Run tab. 
        // 1ETH = 1 * 10^18 wei. 
        
        // Below, we have set the require function to value (in terms of ETH/wei/gwei) but have our value set to minimumUSD. If there are insufficient funds being sent, the statement will fail
        // USD is a concept given to the price of ETH outside the blockchain, thus, solidity does not know what the USD value of ETH is. For this, we will need to use
        // a decentralized oracle network to attain the value of ETH in USD from outside the Blockchain. 
        
        //msg.value gets the native blockchain tokens value

        require(msg.value.getConversionRate() >= minimumUsd, "Didn't send enough"); //18 decimal places due to Wei value in ETH
        funders.push(msg.sender); // msg.sender is an always available function like msg.value
        addressToAmountFunded[msg.sender] = msg.value;
    }

    //function withdraw(){}
}
