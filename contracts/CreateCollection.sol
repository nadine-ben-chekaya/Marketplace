// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol"; //easy way to increment our token id
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";// to retieving an url to the nft image and metadata
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract CreateCollection is ERC721URIStorage, ReentrancyGuard {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    address marketplaceAddress;
    address owner;
    constructor(address marketAddress) ERC721("My NFT Collection", "MNFT") {
        marketplaceAddress= marketAddress;
    }
    
    function mint(string memory tokenURI) public payable nonReentrant{
        //_safeMint(recipient, tokenId);
        uint256 newItemId = _tokenIds.current();
        _mint(msg.sender, newItemId);
        _setTokenURI(newItemId, tokenURI);
        
        if (msg.sender == owner){
            setApprovalForAll(marketplaceAddress, true);

        }
        

        _tokenIds.increment();
    }
    
    

}