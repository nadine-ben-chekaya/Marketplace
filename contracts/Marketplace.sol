// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./CreateCollection.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract Marketplace{
    mapping (address => address) public collectionOwners;
    event CollectionCreated(address collectionAddress, address owner);
    
    function createCollection() public {
        CreateCollection newCollection = new CreateCollection(address(this));
        address collectionAddress = address(newCollection);
        collectionOwners[collectionAddress] = msg.sender;
        emit CollectionCreated(collectionAddress, msg.sender);
    }
    
    // function mintNFT(address collectionAddress, string memory tokenuri) public payable nonReentrant {
    //     require(collectionOwners[collectionAddress] != address(0), "Collection does not exist");
    //     setApprovalForAll(address(this), true);
    //     CreateCollection(collectionAddress).mint(tokenuri);
    // }

}