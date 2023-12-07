//SPDX-License-Identifier: MIT

//What are Overflows or Underflows?¶

//In previous versions of Solidity (prior Solidity 0.8.x) an integer would automatically roll-over to a lower or higher number. If you would decrement 0 by 1 (0-1) on an unsigned integer, the result would not be -1, or an error, the result would simple be: type(uint).max.

//For this example I want to use uint8. In our previous example worked with uint256 and uint8 and did not roll over. Uint8 is going from 0 to 2^8 - 1. In other words: uint8 ranges from 0 to 255. If you increment 255 it will automatically be 0, if you decrement 0, it will become 255 if the operation is unchecked. No warnings, no errors. For example, this can become problematic, if you store a token-balance in a variable and decrement it without checking.

//Let's do an actual example!

pragma solidity 0.7.0;

contract ExampleWrapAround {

    uint8 public myUint8 = 250; 

    function decrement() public {
        myUint8--;
    }

    function increment() public {
        myUint8++;
    }
}


//If you deploy this and run "increment" more than 5 time, the myUint8 will just magically start from 0 again. No warning.

//Of course, sometimes this behavior is actually beneficial. Imagine you want to run something indefinitely and just do something on every even number. To save gas, you'd naturally use an uint8 and do var % 2 == 0. That way it rolls over and nobody actually cares.

//The problem is, those cases are actually pretty rare. Normally, we don't want an integer to roll over. That's why in 0.8 it changed to be the default behavior to error out if the maximum/minimum value is reached. But you can still enforce this behavior. With an unchecked block. Let's see an example.

//Solidity 0.8 unchecked example¶

//If you take the following contract as an example, you see two functions. One is decrementing the myUint without checking for rollovers (highlighted in yellow) and one in the normal way.

//Please mint: The contract is now solidity 0.8.15 instead of 0.7.0!

pragma solidity 0.8.15;

contract ExampleWrapAround {
    uint256 public myUint;

    function decrementUintUnchecked() public {
        unchecked {
            myUint--;
        }
    }

    function decrementUint() public {
        myUint--;
    }
}

//If you run decrementUintUnchecked it will go from 0 to the 2^256 - 1.