# 介绍 Hardhat
    solidty的开发测试部署工具， 对使用js的同学比较容易上手， 对比truffle和foundry ,更加简单，更加轻量级，更加快速。
# 如何安装 Hardhat, 并使用 Hardhat 创建一个新项目
    npm install --save-dev hardhat
    创建空白项目配置文件, hardhat.config.js
    npm install --save-dev @nomicfoundation/hardhat-toolbox
    将插件添加到 hardhat.config.js 中

```javascript
require("@nomicfoundation/hardhat-toolbox");
    /** @type import('hardhat/config').HardhatUserConfig */
    module.exports = {
    solidity: "0.8.9",
    };
```



# 如何使用 Hardhat 编写并编译合约
    合约详见./contracts/ERC20.sol

   npx hardhat compile

# 如何运行简单的测试
    测试case
```javascript
const { expect } = require('chai');
const { ethers } = require('hardhat');
describe("ERC20 合约测试", ()=>{
it("合约部署", async () => {
    // ethers.getSigners,代表eth账号  ethers 是一个全局函数，可以直接调用
    const [owner, addr1, addr2] = await ethers.getSigners();
    // ethers.js 中的 ContractFactory 是用于部署新智能合约的抽象，因此这里的 ERC20 是我们代币合约实例的工厂。ERC20代表contracts 文件夹中的 ERC20.sol 文件
    const Token = await ethers.getContractFactory("ERC20");
    // 部署合约, 传入参数 ERC20.sol 中的构造函数参数分别是 name, symbol 这里我们都叫做WTF
    const hardhatToken = await Token.deploy("WTF", "WTF");
    // 获取合约地址
    const ContractAddress = await hardhatToken.address;
    expect(ContractAddress).to.properAddress;
});
})
```

    npx hardhat test

# 如何部署合约
    先编写部署脚本deploy.js, 然后运行部署脚本

```javascript
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
```
    npx hardhat run scripts/deploy.js --network rinkeby

# 如何配置多个网络，例如 Goerli 测试网络和 mainnet，rinkeby 等
    在 hardhat.config.js 中配置

```javascript
require("@nomicfoundation/hardhat-toolbox")
// 申请alchemy的api key
const ALCHEMY_API_KEY = "KEY";

//将此私钥替换为测试账号私钥
//从Metamask导出您的私钥，打开Metamask和进入“帐户详细信息”>导出私钥
//注意:永远不要把真正的以太放入测试帐户
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
 ```
