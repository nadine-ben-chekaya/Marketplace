const { ethers } = require("hardhat")
const MintSaleJSON = require("../artifacts/contracts/MintSale.sol/MintSale.json")

async function main() {
  const abi = MintSaleJSON.abi
  const alchemy = new ethers.providers.AlchemyProvider("maticmum", process.env.ALCHEMY_API_KEY);
  const userWallet = new ethers.Wallet(process.env.PRIVATE_KEY_ACCOUNT3, alchemy);
  const signer = userWallet.connect(alchemy) 
  const MarketContract = new ethers.Contract(process.env.CONTRACT_ADDRESS_NFT, abi, signer)
  const price = ethers.utils.parseEther("2");
  // 3adi l value f sale 
  const tx1 = await MarketContract.createNFTCollection("MetaCollection","meta");
  await tx1.wait();
  console.log("success sell")
  console.log(tx1)
  
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
