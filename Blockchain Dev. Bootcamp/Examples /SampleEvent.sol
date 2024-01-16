//SPDX-License-Identifier: MIT

pragma solidity 0.8.16;

contract EventExample {

    mapping(address => uint) public tokenBalance;

    constructor() {
        tokenBalance[msg.sender] = 100;
    }

    function sendToken(address _to, uint _amount) public returns(bool) {
        require(tokenBalance[msg.sender] >= _amount, "Not enough tokens");
        tokenBalance[msg.sender] -= _amount;
        tokenBalance[_to] += _amount;

        return true;
    }
}

/*
NOTES:
Dealing with Events really comes into play with DApps when using JavaScript (or other non-solidity languages). So, from outside of the Ethereum Sandbox.
Consider the files below to create a UI:

JAVASCRIPT:
const enableMetaMaskButton = document.querySelector('.enableMetamask');
const statusText = document.querySelector('.statusText');
const listenToEventsButton = document.querySelector('.startStopEventListener');
const contractAddr = document.querySelector('#address');
const eventResult = document.querySelector('.eventResult');

enableMetaMaskButton.addEventListener('click', () => {
  enableDapp();
});
listenToEventsButton.addEventListener('click', () => {
  listenToEvents();
});

let accounts;
let web3;

async function enableDapp() {

  if (typeof window.ethereum !== 'undefined') {   // MetaMask injects itself into the website. Its reachable with window.ethereum. So, if the window.ethereum is not undefined, there's a good reason to believe MetaMask is installed.
    try {
      accounts = await ethereum.request({       // MetaMask has a security procedure in place, that prevents a website reading the Address without the user giving explicit permission. This is in addition to the transaction-confirmation popups. This piece of code triggers the connection.
        method: 'eth_requestAccounts'
      });
      web3 = new Web3(window.ethereum);
      statusText.innerHTML = "Account: " + accounts[0];

      listenToEventsButton.removeAttribute("disabled");
      contractAddr.removeAttribute("disabled");
    } catch (error) {
      if (error.code === 4001) {
        // EIP-1193 userRejectedRequest error
        statusText.innerHTML = "Error: Need permission to access MetaMAsk";
        console.log('Permissions needed to continue.');
      } else {
        console.error(error.message);
      }
    }
  } else {
    statusText.innerHTML = "Error: Need to install MetaMask";
  }
};

let abi = [{
    "inputs": [],
    "stateMutability": "nonpayable",
    "type": "constructor"
  },
  {
    "anonymous": false,
    "inputs": [{
        "indexed": false,
        "internalType": "address",
        "name": "_from",
        "type": "address"
      },
      {
        "indexed": false,
        "internalType": "address",
        "name": "_to",
        "type": "address"
      },
      {
        "indexed": false,
        "internalType": "uint256",
        "name": "_amount",
        "type": "uint256"
      }
    ],
    "name": "TokensSent",
    "type": "event"
  },
  {
    "inputs": [{
        "internalType": "address",
        "name": "_to",
        "type": "address"
      },
      {
        "internalType": "uint256",
        "name": "_amount",
        "type": "uint256"
      }
    ],
    "name": "sendToken",
    "outputs": [{
      "internalType": "bool",
      "name": "",
      "type": "bool"
    }],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [{
      "internalType": "address",
      "name": "",
      "type": "address"
    }],
    "name": "tokenBalance",
    "outputs": [{
      "internalType": "uint256",
      "name": "",
      "type": "uint256"
    }],
    "stateMutability": "view",
    "type": "function"
  }
];
async function listenToEvents() {
  let contractInstance = new web3.eth.Contract(abi, contractAddr.value);
  contractInstance.events.TokensSent().on("data", (event) => {
  	eventResult.innerHTML = JSON.stringify(event) + "<br />=====<br />" + eventResult.innerHTML;
  });
}


HTML:
<button class="enableMetamask">
Enable MetaMask
</button>
<h2><span class="statusText"></span></h2>

<input type="text" id="address" placeholder="Contract Address" disabled="true" />
<button class="startStopEventListener" disabled="true" >
Listen to Events
</button>

<span class="eventResult">
  
</span>
<br />
<small>
This is an example of Events from <a href="https://ethereum-blockchain-developer.com">Ethereum-Blockchain-Developer.com</a>
</small>


****How long events are stored, depends on future developments of the Ethereum chain. Right now, at the time of writing this text, you can access all events that ever happened on archive nodes.
 You can query any block and get the events. But if a chain pruninig happens some time in the futurer, events might not be accessible anymore.
 That's why it is maybe better to store events in a different system, such as a Database for larger DApps that depend on historical events.


Event Topics¶
Topics are used to describe events and allows to quickly go through the underlying bloom filter. If you look at raw block headers, you will see they contain a logsBloom field (which are normally decoded for you right away). If you are searching for logs, then the bloom filter efficiently does this for you and can find out which blocks contain a certain log with a certain topic.

Here is how the topics work:

The first topic is usually the Event Signature, which is the keccak256(TokensSent(address,uint256)) in our example. Then you can have up to three more indexed fields, which gives you log0 to log4.

If we filter for certain events, we can do that with JavaScript later on very efficiently:
 
 contractInstance.getPastEvents("TokensSent",{filter: {_to: ['0x123123123...']}, fromBlock:0 }).then(event => {
    console.log(event)
  });
}

The problem is, our smart contract specifies no indexed data yet. So, it will just output all events, because it cannot efficiently filter them.

Let's update the smart contract and add the "indexed" keyword to the event.

    event TokensSent(address indexed _from, address indexed _to, uint _amount);

Remember, you can have up to 3 indexed parameters, which allow for easier filtering. You cannot filter by range (e.g. >= 5 or < 100), but you can filter by a specific value, such as a receiver address or a sender address.

Cost of Events¶
In previous lectures we were creating a mapping with elements of Transfers for deposit and withdrawals. Doing this is not gas efficient at all. It's much much better to simply emit an event for these transactions.
As a rule of thumb, events are about 10-100x cheaper than actually storing something in storage variables.
 */