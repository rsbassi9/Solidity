// Get funds from users
// Withdraw funds
// Set a minimum funding value in USD

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FundMe {

    uint256 public minimumUsd = 50;


    // payable keyword allows the function to have the ability to be read as a transaction function

    function fund() public payable{
        // Want to be able to set a minimum fund amount in USD
        // 1. How do we send ETH to this contract

        // require (a , b) if a is false, return b. if a is not true, then the transaction is cancelled and any prior work is undone
        //msg.value is the value of ETH/wei/gwei we input in the Value section of the Deploy and Run tab. 
        // 1ETH = 1 * 10^18 wei. 
        
        // Below, we have set the rewuire function to value (in terms of ETH/wei/gwei) but have our value set to minimumUSD.
        // USD is a concept given to the price of ETH outside the blockchain, thus, solidity does not know what the USD value of ETH is. For this, we will need to use
        // a decentralized oracle network to attain the value of ETH in USD from outside the Blockchain  

        require(msg.value >= minimumUsd, "Didn't send enough"); 

    }

    //function withdraw(){}
}
