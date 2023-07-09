// Get funds from users
// Withdraw funds
// Set a minimum funding value in USD

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// instead of copying the Aggregators code and retreiving its API, you can import the github code as shown below (https://docs.chain.link/data-feeds/using-data-feeds)
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe {

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

        require(msg.value >= minimumUsd, "Didn't send enough"); //18 decimal places due to Wei value in ETH
        funders.push(msg.sender); // msg.sender is an always available function like msg.value
        addressToAmountFunded[msg.sender] = msg.value;
    }

    // Create a function to get the price of our token in terms of USD. Use Chainlink Data feeds for this

    function getPrice() public view returns(uint256) {
        // This is an instance of us calling a function outside of our project. Therefore, we need: 
            // ABI
            // Address from (Chainlink --> Data Feeds --> Price feed addresses --> Sepolia) 0x694AA1769357215DE4FAC081bf1f309aDC325306
            AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
            
            // ETH in terms of USD. The commas represent the rest of the variables that are included in the Aggregators code. We juts care about price
            // 3000.00000000
            (,int256 price,,,) = priceFeed.latestRoundData();
            return uint256(price * 1e10); // the price output is given to 8 decimals, but Wei has 18 0's. so we need to convert the price to the smae sig. figs
    }

    // Now we need to convert the msg.value to USD from ETH
    function getConversionRate(uint256 ethAmount) public view returns (uint256) {
        uint256 ethPrice = getPrice();
        // eg, 3000_000000000000000000 = ETH / USD price
        // 1_000000000000000000 ETH amount
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18; // both ethPrice and ethAmount have 18 decimal places. if we dont divide by 1e18, the answer will have 36 decimals
        return ethAmountInUsd; // 3000
    }

    //function withdraw(){}
}
