const { ethers } = require("hardhat")

async function main() {
  const CreateCollection = await ethers.getContractFactory("CreateCollection");
  const hardhatMintSale = await CreateCollection.deploy();
  await hardhatMintSale.deployed()
  console.log(`Contract successfully deployed to ${hardhatMintSale.address}`)
  //"Metacollection","meta","this is collection", "sport"
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
//Contract successfully deployed to 0x238c9335C2d4Fbf95b07A2226D2a0BB51aD7da7F