// SPDX-License-Identifier: MIT LICENSE

pragma solidity >=0.8.0;

import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";// beacause this smart contract is going to receive erc721
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";//the modifier ensures that the function can only be executed once at a time 
import "@openzeppelin/contracts/access/Ownable.sol";

contract NFTMarketResell is IERC721Receiver, ReentrancyGuard, Ownable {

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
  //I want to ask when i deploy the SC to: give me the collection SC that you want users to be able to sell and buy nfts from my marketplace
  //ERC721Enumerable nft; //nft is a storage for enumerable and it's the address of the nft SC

   constructor() {
    holder = payable(msg.sender);
  }

  function listSale(address nftContract, uint256 tokenId, uint256 price) public payable nonReentrant {
      require(IERC721(nftContract).ownerOf(tokenId) == msg.sender, "NFT not yours");
      require(vaultItems[tokenId].tokenId == 0, "NFT already listed");
      require(price > 0, "Amount must be higher than 0");
      require(msg.value == listingFee, "Please transfer 0.0025 crypto to pay listing fee");
      //add the new nft for sell in the vaultItems
      vaultItems[tokenId] =  List(tokenId, payable(msg.sender), payable(address(this)), price, false);
      //seller send the nft to the market. SC + The nft collection SC need to setApproval for all 
      IERC721(nftContract).transferFrom(msg.sender, address(this), tokenId);
      // kEEP TRACK OF THE EVENT
      emit NFTListCreated(tokenId, msg.sender, address(this), price, false);
      
      
  }

  function buyNft(address nftContract, uint256 tokenId) public payable nonReentrant {
      uint256 price = vaultItems[tokenId].price;
      require(msg.value == price, "Transfer Total Amount to complete transaction");
      //Pay the seller
      vaultItems[tokenId].seller.transfer(msg.value);

      //transfer the listing fee
      //payable(msg.sender).transfer(listingFee);

      //Transfer the nft from the marketplace SC to the buyer
      IERC721(nftContract).transferFrom(address(this), msg.sender, tokenId);
      // to show that the nft is sold
      vaultItems[tokenId].sold = true;
      //To delete this tokenID (nft) from the listing
      delete vaultItems[tokenId];
  }

  function cancelSale(address nftContract, uint256 tokenId) public nonReentrant {
      require(vaultItems[tokenId].seller == msg.sender, "NFT not yours");
      IERC721(nftContract).transferFrom(address(this), msg.sender, tokenId);
      delete vaultItems[tokenId];
  }
  
  function getPrice(uint256 tokenId) public view returns (uint256) {
      uint256 price = vaultItems[tokenId].price;
      return price;
  }

 //Display all the nft
 // The "memory" keyword indicates that this array is only stored in memory and will not be stored on the blockchain. 

//  function nftListings(address nftContract) public view returns (List[] memory) {
//     uint256 nftCount = IERC721(nftContract).totalSupply();
//     uint currentIndex = 0;
//     // declaring a table od list with length nftcount
//     List[] memory items = new List[](nftCount);
//     for (uint i = 0; i < nftCount; i++) {
//         if (vaultItems[i + 1].holder == address(this)) {
//         uint currentId = i + 1;

//         /*By using a "storage" pointer to an existing array,
//          you can avoid copying the entire array into a new storage variable,
//         which can save gas and reduce the contract's storage footprint.*/
//         List storage currentItem = vaultItems[currentId];
//         items[currentIndex] = currentItem;
//         currentIndex += 1;
//       }
//     }
//     return items;
//   }

  function onERC721Received(
        address,
        address from,
        uint256,
        bytes calldata
    ) external pure override returns (bytes4) {
      require(from == address(0x0), "Cannot send nfts to Vault directly");
      return IERC721Receiver.onERC721Received.selector;
    }
  
    function withdraw() public payable onlyOwner() {
      require(payable(msg.sender).send(address(this).balance));
    }
  
}
