// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// We could import our SampleToken contract here in place of the ERC20 contract below
// https://ethereum.org/en/developers/docs/standards/tokens/erc-20
abstract contract ERC20 {
    function transferFrom(address _from, address _to, uint256 _value) public virtual returns (bool success);
    function decimals() public virtual view returns (uint8);
}