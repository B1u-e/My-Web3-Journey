require("@nomicfoundation/hardhat-toolbox");

// 申请alchemy的api key
const ALCHEMY_API_KEY = "KEY";

const GOERLI_PRIVATE_KEY = "YOUR GOERLI PRIVATE KEY";

module.exports = {
  solidity: "0.8.9", // solidity的编译版本
  networks: {
    goerli: {
      url: `https://eth-goerli.alchemyapi.io/v2/${ALCHEMY_API_KEY}`,
      accounts: [GOERLI_PRIVATE_KEY]
    }
  }
};