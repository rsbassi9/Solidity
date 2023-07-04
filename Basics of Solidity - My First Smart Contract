// make licensing and sharing code easeir using SPDX comment below:
// SPDX-License-Identifier: MIT

// First we need to add the version of Solidity to use
pragma solidity ^0.8.18;

// Any chain that is an EVM can have smart contracts written in Solidity - Avalanche, Fantom, Polygon

// Define our contract. Similar to a class in JS
contract SimpleStorage {
    // Data types: boolean, uint (only positive), int (can be positive or negative), address, bytes. Need to declare types of variables in Solidity.
    // bool hasFavoriteNumber = true;
    // uint256 favoriteNumber =5;  this declares 256 bytes of storage to our variable. Default, if size is not declared, is set to 256. Lowest is 8, incrementing by 8
    // string favoriteNumberInText = "Five";
    // int256 favoriteInt = -5;
    // address myAddress = 0x.......;
    // bytes32 favoriteBytes = "cat"; 

    uint256 favoriteNumber;         // sets it to 0 if no value provided. if we omit public keyword, our value stored as favorite Number is not displayed as it is private
    
    mapping(string => uint256) public nameToFavoriteNumber;  // mapping data structure to find a persons favorite number without having to search manually. just type their name and their favorite number will be logged
    
    // create a struct 
    struct People {
        uint256 favoriteNumber;
        string name;
    }

    // create a dynamic array: we havent declared the size of the array. if we had People[3], it can only be of size 3 maximum
    People[] public people;

    // functions in Solidity work the same as in JS
    function store(uint256 _favoriteNumber) public {
        favoriteNumber = _favoriteNumber;
        // uint256 testVar = 5;
        // retrieve();    <--retreive here would cost gas since it is in a fucntion that would cost gas
    }


    // view and pure functions do not take gas since they do not modify the blockchain state. BUT: if these are called in a function that costs gas, they are not free

    // example of a view fucniton. only reading the state from a contract. no modification
    function retreive() public view returns(uint256){
        return favoriteNumber;
    }

    // example of a pure function - no reading, no output
   /*
   function add() public pure returns (uint256){
        return(1+1);
    } 
    */


    // People refest to our struct People (capital P) whereas people is our variable array. wo here, say we are pushing to our array (people), a new People with a _favoriteNumber and a _name
    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        People memory newPerson = People({favoriteNumber: _favoriteNumber, name: _name});
        // alternatively, if we wnat to be a littel bit less explicit here, we can use:
        // People memory newPerson = People(_favoriteNumber, _name); Note, we have to list the inputs as the appear in the order we declared them earlier
        people.push(newPerson);
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }

    //when you dont explicitly create  new person, you can omit the memory keyword:
    /*
    function addPerson(string memory _name, uint256 _favoriteNumber) public {
    people.push(People(_favoriteNumber, _name));
    }
    */
}
