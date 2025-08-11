const hre = require("hardhat");

async function main() {
  const Contract = await hre.ethers.getContractFactory("ERC20");
  const token = await Contract.deploy("WTF","WTF");

  await token.deployed();

  console.log("成功部署合约:", token.address);
}

// 运行脚本
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});