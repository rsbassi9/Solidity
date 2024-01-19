// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// We could import our SampleToken contract here in place of the ERC20 contract below
// https://ethereum.org/en/developers/docs/standards/tokens/erc-20
abstract contract ERC20 {
    function transferFrom(address _from, address _to, uint256 _value) public virtual returns (bool success);
    function decimals() public virtual view returns (uint8);

    contract TokenSale {

    uint public tokenPriceInWei = 1 ether;

    ERC20 public token;
    address tokenOwner;

    constructor(address _token){
        tokenOwner = msg.sender;
        token = ERC20(_token);
    } 

    function pusrchaseACoffee() public payable {
        require(msg.value >= tokenPriceInWei, "Not enough money sent");


        // Only allow sending of whole numbers. if a partial token is send, eg 1.5 ETH, send back 0.5 ETH
        uint tokensToTransfer = msg.value / tokenPriceInWei;
        uint remainder = msg.value - tokensToTransfer * tokenPriceInWei;
        token.transferFrom(tokenOwner, msg.sender, tokensToTransfer * 10 ** token.decimals());
        payable(msg.sender).transfer(remainder);
    }

}