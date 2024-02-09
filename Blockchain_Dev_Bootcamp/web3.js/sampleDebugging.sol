//SPDX-License-Identifier: MIT

pragma solidity 0.8.16;

contract MyContract {

    uint public myUint = 123;

    function setMyUint(uint newUint) public {
        myUint = newUint;
    }
}

// To interact with this contract using Web3.js, you would deploy this contract, get the contract address and the ABI:
// Run the updateUint.js file containing the script below to see how to make changes to this smart contract from a web3.js file:
/*
(async() => {
    // both of these are manually implemented to get access to the functions location
    const address = "0xd8b934580fcE35a11B58C6D73aDeE468a2833fa8";
    const abiArray = [
	{
		"inputs": [],
		"name": "myUint",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "newUint",
				"type": "uint256"
			}
		],
		"name": "setMyUint",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	}
];

    const contractInstance = new web3.eth.Contract(abiArray, address);

    console.log(await contractInstance.methods.myUint().call())

    // To alter the setMyUint variable from this file:
    let accounts = await web3.eth.getAccounts();
    //specify whice account we are making the change to:
    let txResult = await contractInstance.methods.setMyUint(345).send({from: accounts[0]})

    console.log(await contractInstance.methods.myUint().call())
    console.log(txResult);
})()

 */


/*
NOTES:

ABI stands for Application Binary Interface.

When you compile a smart contract then you get bytecode which gets deployed. Inside there are assembly opcodes telling the EVM during execution of a smart contract where to jump to. Those jump destinations are the first 4 bytes of the keccak hash of the function signature.

Best is, we're looking through the lens of the debugger into the execution of a smart contract and run through that.

INSTRUCTIONS:
In Remix, go to the Plugins and enable the Debugger plugin.
Deploy the Smart Contract
update the myUint through setMyUint
Then hit the "debug" button in the console window
The debugger will open up. On the left side, you see a horizontal scrollbar. Scroll it all the way to the beginning.
If you scroll (or step into) until instruction 041, you should see something like PUSH4 e492fd84, which means, its now pushing the 4 bytes e492fd84 onto the stack and then in 046 its comparing it to the first 4 bytes of the calldata, which, incidentally also contains e492fd84 as the first 4 bytes.

Where are they coming from?

It's the first 4 bytes of the function signature bytes4(keccak256(setMyUint(uint256))).

As you know with hashes, once you hashed a value its hard to go back, unless you have a rainbow table or do brute forcing of some sorts.

And web3js tries to offer nice functions to interact with a smart contract. So, in web3js, you can do things like contractInstance.methods.setMyUint(123), all with auto-completion. That's only possible, if we provide the information what functions exist on a smart contract to web3js.

This is what the ABI array does.

The ABI Array contains all functions, inputs and outputs, as well as all variables and their types from a smart contract.

If you open up the artifacts/MyContract.json file in the file-explorer, you can scroll all the way to the bottom. There you find the ABI array:

If you want to interact with a smart contract from web3js, you need two things:

the ABI array
the contract address (or you deploy the contract through web3js)
Run the web3js script above.
Then right-click on the file and run the script.
 */