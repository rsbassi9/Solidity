// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./SimpleStorage.sol";

// Inheritance: have the ExtraStorage contract be a child of the SimpleStorage contract. It will inherit all the functionality of SimpleStorage. use 'is' keyword.
// this will allow us to add different functions to the ExtaStorage contract, that will include all the functionality of the SimpleStorage contract

contract ExtraStorage is SimpleStorage {
    
    // SimpleStorage just assigns the new number we provide it with to the global variable favoriteNumber. this then become the new favoriteNumber
    // In the function below, we want to + 5 to the favoriteNumber. 
    // use override: 
        //virtual -- added to the original function in 'SimpleStorage.sol'
        //override -- added to the new function that is overriding theoriginal function

    function store(uint256 _favoriteNumber) public override{
        favoriteNumber = _favoriteNumber + 5;
    }
}
