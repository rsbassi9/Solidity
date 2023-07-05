// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// import the smart contract we want to run in this file
import "./SimpleStorage.sol";

// make our new contract. this contract allows us to create SimpleStorage contracts, and saves it to the simpleStorageArray which we can then call different functions on
contract StorageFactory {
    // Create a global variable ( type, visibility, variableName ) as an array to keep track oft all the simpleStorage deployments 
    SimpleStorage[] public simpleStorageArray;

// now, create a function to delpoy the SimpleStorage function
    function createSimpleStorageContract() public {
        
        // new keyword tells Solidity that this is a new SimpleStorage contract
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorageArray.push(simpleStorage);
    }


// create interactability to allow us to call the store function on all of our SimpleStorage.sol from the StorageFactory (whjich is basically a manager of all of the SimpleStorages
    function sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber) public {
        // to interact with any contract, we ALWAYS need: 
            //Address
            //ABI = Application Binary Interface (automatically imported since we imported "./SimpleStorage.sol"; which has its own ABI [compiler --> compilation details --> ABI]
        simpleStorageArray[_simpleStorageIndex].store(_simpleStorageNumber); 

    }

 // Once stored, create a function to read from the SimpleStorage contract, from the StorageFactory  
    function sfGet(uint256 _simpleStorageIndex) public view returns(uint256){
        return simpleStorageArray[_simpleStorageIndex].retreive();
        
    }
}
