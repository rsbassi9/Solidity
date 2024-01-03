//SPDX-License-Identifier: MIT

pragma solidity 0.8.15;

contract wallet {

    PaymentReceived public payment;

    function payContract() public payable {
        payment = new PaymentReceived(msg.sender, msg.value);
    }
}

contract PaymentReceived {
    address public from;
    uint public amount;

    constructor(address _from, uint _amount) {
        from = _from;
        amount = _amount;
    }
}

// How the same goal can be achieved with a  struct:
    // Structs are needed to :
            // a) save gas. Using a struct in this case saved about 2.5x less gas
            // b) Complexity.
            // c) to prevent repetition and increase simplicity

contract wallet2 {

    struct PaymentReceivedStruct {
        address from;
        uint amount;
    }

    PaymentReceivedStruct public payment;

    // Now we can use the struct in the function, without the need for the "new" keyword
    function payContract() public payable {
        payment = PaymentReceivedStruct(msg.sender, msg.value);

        // Alternatively, we can have the payment variable above broken up for clarity:
       // payment.from = msg.sender;
       // payment.amount = msg.value;
    }
}