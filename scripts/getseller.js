// main.mjs
import { ethers } from "hardhat";

let seller;

async function main() {
  [seller] = await ethers.getSigners();
  console.log(seller);
}

main();

export { seller };

