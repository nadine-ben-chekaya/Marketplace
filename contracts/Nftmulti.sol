// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";// to retieving an url to the nft image and metadata
import "@openzeppelin/contracts/utils/Counters.sol"; //easy way to increment our token id
import "@openzeppelin/contracts/access/Ownable.sol";


contract Nftmulti is ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    //the address of the marketplace that will buy/sell the nfts
    address contractAddress;
    

    constructor(address marketContract) ERC721("NftMeta", "MetaCul") {
        contractAddress = marketContract;
    }
    
    //mint nft to ourselves
    function mint(string memory tokenURI)
        public
        returns (uint256)
    {
        uint256 newItemId = _tokenIds.current();
        _mint(msg.sender, newItemId);
        _setTokenURI(newItemId, tokenURI);

        _tokenIds.increment();
        setApprovalForAll(contractAddress, true);
        return newItemId;
    }


}