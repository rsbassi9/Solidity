// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// We run NFTs off of the ERC 721 token, based on deeds from real estate: https://docs.openzeppelin.com/contracts/5.x/erc721
// The ERC721 is an ERC20 token where each token has a unique ID and can have an URL for more MetaData.
//It actually has its roots in real estate deeds. A big misconception is that NFT MetaData should be immutable. But the initial idea was that the Token itself, the logic to mint, transfer and potentially even burn tokens, is in a Smart Contract. But the MetaData - so, who owns the building - is changeable. Or can be even extended.

//That's why a good practice is to put the MetaData, which is just a regular json file, somewhere on a regular host.


// Use the openzeppelin contract wizard for ERC721 to generate this: https://docs.openzeppelin.com/contracts/5.x/wizard
/*
Set the Name and Symbol as "Spacebear" and "SBR"
Set the Base-URI as "https://ethereum-blockchain-developer.com/2022-06-nft-truffle-hardhat-foundry/nftdata/"
Check Mintable with Auto-Increment IDs. So every time you mint a token it gets a new number.
Enable URI Storage, so your token URIs for MetaData are not the token-ID but can be different. You'll see in a second why. 
*/

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Spacebear is ERC721, ERC721URIStorage, Ownable {
    uint256 private _nextTokenId;

    constructor(address initialOwner)
        ERC721("Spacebear", "SBR")
        Ownable(initialOwner)
    {}

    function _baseURI() internal pure override returns (string memory) {
        return "https://ethereum-blockchain-developed.com/2022-06-nft-truffle-hardhat-foundry/nftdata/";
    }

    function safeMint(address to, string memory uri) public onlyOwner {
        uint256 tokenId = _nextTokenId++;
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
    }

    // The following functions are overrides required by Solidity.

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}