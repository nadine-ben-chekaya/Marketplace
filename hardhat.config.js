require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();
const { MUMBAI_API_URL, PRIVATE_KEY_ACCOUNT3,PRIVATE_KEY_ACCOUNT1, GOERLI_API_URL  } = process.env;
/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.18",
  networks: {
    mumbai1: {
       url: MUMBAI_API_URL,
       accounts: [`${PRIVATE_KEY_ACCOUNT1}`],
       },
      
    mumbai2: {
        url: MUMBAI_API_URL,
        accounts: [`${PRIVATE_KEY_ACCOUNT3}`],
        },
    goerli: {
          url: GOERLI_API_URL,
          accounts: [`${PRIVATE_KEY_ACCOUNT1}`],
          },

    }
};
