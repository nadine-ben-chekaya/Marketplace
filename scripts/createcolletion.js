const { ethers } = require("hardhat")
const MarketJSON = require("../artifacts/contracts/Marketplace.sol/Marketplace.json")

async function main() {
  const abi = MarketJSON.abi
  const alchemy = new ethers.providers.AlchemyProvider("maticmum", process.env.ALCHEMY_API_KEY);
  const userWallet = new ethers.Wallet(process.env.PRIVATE_KEY_ACCOUNT3, alchemy);
  const signer = userWallet.connect(alchemy) 
  const MarketContract = new ethers.Contract(process.env.CONTRACT_ADDRESS_MARKET, abi, signer)
  const price = ethers.utils.parseEther("2");
  //3adi l value f sale 
  const tx1 = await MarketContract.createCollection();
  await tx1.wait();
  console.log("success sell")
  console.log(tx1)


// Send the mintNFT() transaction
// try {
//   //const tx = await MarketContract.mintNFT(process.env.CONTRACT_ADDRESS_NFT,"nft1").estimateGas();
//   const tx2 = await MarketContract.mintNFT(process.env.CONTRACT_ADDRESS_NFT,"nft1",{gasLimit: 210000,})
//   console.log('Transaction sent:', tx2.hash);
//   const receipt = await tx2.wait();
//   console.log('Transaction confirmed in block:', receipt.blockNumber);
// } catch (error) {
//   console.error('Failed to send transaction:', error);
// }
  
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
