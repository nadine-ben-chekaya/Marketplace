const { ethers } = require("hardhat")

async function main() {
  const Marketplace = await ethers.getContractFactory("Marketplace");
  const hardhatMarketplace = await Marketplace.deploy();
  await hardhatMarketplace.deployed()
  console.log(`Contract successfully deployed to ${hardhatMarketplace.address}`)
}

main()
  .then(() => process.exit(0))
  .catch((error) => { 
    console.error(error);
    process.exit(1);
  });
//Contract successfully deployed to 0x5B74435ea228d4aB437caA3007894faAbAB0505f