// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.0;

import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";// beacause this smart contract is going to receive erc721
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";// to retieving an url to the nft image and metadata
import "@openzeppelin/contracts/utils/Counters.sol"; //easy way to increment our token id
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";//the modifier ensures that the function can only be executed once at a time 


contract MintSale is ERC721URIStorage, ReentrancyGuard, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    address payable holder;// the address that is going to receive the nft
    uint256 listingFee = 0.0025 ether;//for anyone he wants to sell nfts 
    
     
    struct List {// LIST FOR SELL
        uint256 tokenId;
        address payable seller;
        address payable holder;
        uint256 price;
        bool sold;// To track if the item has been sold or not
    }
    
    mapping(uint256 => List) public vaultItems;// to map all items in sell ( with tokenid) 
    //event collection
    event CollectionCreated(address collectionAddress, string name, string symbol, address owner);

    
    // event to know when a token got sold(listed) + To track and update the SC after the event 
    event NFTListCreated (
        uint256 indexed tokenId,
        address seller,
        address holder,
        uint256 price,
        bool sold
    );
    
    function getListingFee() public view returns (uint256) {
        return listingFee;
        }
    

    constructor() ERC721("MetaCulture","meta"){
        holder = payable(msg.sender);
    }

    function createNFTCollection(string memory _name, string memory _symbol) public returns (address) {
        ERC721 newNFTCollection = new ERC721(_name, _symbol);
        
        emit CollectionCreated(address(newNFTCollection), _name, _symbol, msg.sender);
        return address(newNFTCollection);
    }
    
    function mintNFT(address _collectionAddress, address _to, uint256 _tokenId, string memory _tokenURI) public {
        ERC721(_collectionAddress).mint(_to, _tokenId);
        ERC721(_collectionAddress).setTokenURI(_tokenId, _tokenURI);
    }

    //mint nft to ourselves
    // function mintList(string memory tokenURI, uint256 price)
    //     public
    //     payable 
    //     nonReentrant
    // {
    //     //Mint
    //     uint256 newItemId = _tokenIds.current();
    //     _mint(msg.sender, newItemId);
    //     _setTokenURI(newItemId, tokenURI);

    //     _tokenIds.increment();
    //     setApprovalForAll(address(this), true);
        
    //     // ListSale
    //     vaultItems[newItemId] =  List(newItemId, payable(msg.sender), payable(address(this)), price, false);
    //   //seller send the nft to the market. SC + The nft collection SC need to setApproval for all 
    //   IERC721(address(this)).transferFrom(msg.sender, address(this), newItemId);
    //   // kEEP TRACK OF THE EVENT
    //   emit NFTListCreated(newItemId, msg.sender, address(this), price, false);

    //     //return newItemId;
    // }


}