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