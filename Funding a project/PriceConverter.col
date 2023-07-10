// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// instead of copying the Aggregators code and retreiving its API, you can import the github code as shown below (https://docs.chain.link/data-feeds/using-data-feeds)
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    // Create a function to get the price of our token in terms of USD. Use Chainlink Data feeds for this

    function getPrice() internal view returns(uint256) {
        // This is an instance of us calling a function outside of our project. Therefore, we need: 
            // ABI
            // Address from (Chainlink --> Data Feeds --> Price feed addresses --> Sepolia) 0x694AA1769357215DE4FAC081bf1f309aDC325306
            AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
            
            // ETH in terms of USD. The commas represent the rest of the variables that are included in the Aggregators code. We juts care about price
            // 3000.00000000
            (,int256 price,,,) = priceFeed.latestRoundData();
            return uint256(price * 1e10); // the price output is given to 8 decimals, but Wei has 18 0's. so we need to convert the price to the smae sig. figs
    }

    function getVersion() internal view returns (uint256){
        AggregatorV3Interface preiceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        return preiceFeed.version();
    }

    // Now we need to convert the msg.value to USD from ETH
    function getConversionRate(uint256 ethAmount) internal view returns (uint256) {
        uint256 ethPrice = getPrice();
        // eg, 3000_000000000000000000 = ETH / USD price
        // 1_000000000000000000 ETH amount
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18; // both ethPrice and ethAmount have 18 decimal places. if we dont divide by 1e18, the answer will have 36 decimals
        return ethAmountInUsd; // 3000
    }

}
