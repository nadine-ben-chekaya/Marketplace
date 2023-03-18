const { ethers } = require("hardhat")
const NftmultiJSON = require("../artifacts/contracts/Nftmulti.sol/Nftmulti.json")


async function main() {
  //const [seller, buyer] = await ethers.getSigners();
  const abi = NftmultiJSON.abi
  //const provider  = new ethers.providers.AlchemyProvider("maticmum", process.env.ALCHEMY_API_KEY);
  const alchemyEndpoint = process.env.MUMBAI_API_URL;

  // Create a new JsonRpcProvider for the Alchemy endpoint
  const provider = new ethers.providers.JsonRpcProvider(alchemyEndpoint);
  
  // Get an array of Signer objects from the provider
  const signers = await provider.getSigners();

  //const signers = await provider.getSigners();
  console.log(signers);
  // const userWallet = new ethers.Wallet(process.env.PRIVATE_KEY_NFT1, alchemy);
  // const signer = userWallet.connect(alchemy) 
  // const NftmultiContract = new ethers.Contract(process.env.CONTRACT_ADDRESS_NFT, abi, deployer)
  // const tx1 = await NftmultiContract.mint("nft4");
  // await tx1.wait()
  
  // console.log("success mint0..")
  // console.log(tx1)
  
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
