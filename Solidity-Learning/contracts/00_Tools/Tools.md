# remix 和 remix 的用法

新手入门推荐使用 remix 来开发简单合约和快速学习 Solidity。remix 是以太坊官方推荐的智能合约开发 IDE（集成开发环境），适合新手，可以在浏览器中快速部署测试智能合约，你不需要在本地安装任何程序。
网址：[remix.ethereum.org](https://remix.ethereum.org)
在浏览器打开 remix 进入主界面，在左侧界面中点击+号新建工作空间并命名（例命名为 Solidity by Example）。
![0-1.png](./img/0-1.png)
![0-2.png](./img/0-2.png)
最左边的菜单有四个按钮，分别对应文件，搜索，编译，部署。点新建（Create New File）按钮，就可以创建一个空白的 solidity 合约。
![0-3.png](./img/0-3.png)

## 1. 文件浏览器

新建智能合约，右键文件夹后选择“New File”创建一个新的智能合约。
![0-4.png](./img/0-4.png)

## 2. Solidity 编译器

当编写完智能合约代码后选中你的合约进行编译。下图中“COMPILER”一栏需要你选择 solidity 的版本，solidity 版本迭代很快可能同样的代码在上个版本成功运行，这个版本就会报错。其默认为最新版本。一般情况下可以勾选自动编译（Auto compile）
![0-5.png](./img/0-5.png)

## 3. 部署&运行交易

如果编译没有发生错误就可以开始部署合约，在“ENVIRONMENT”一栏需要选择部署环境，在“Remix VM”环境下你会将合约部署在本地中不会连接节点，可以用于测试之中；在“Injected Provider - MetaMask”下你会启用网页插件部署合约比如使用率高的 MetaMask；请确认无误后再部署以免造成损失。
之后在“ACCOUNT”一栏输入你要部署的账户，在“GAS LIMIT”下输入所消耗燃料的上限后即可点击下方按钮部署合约。
![0-6.png](./img/0-6.png)

## 4.安装 ETHERSCAN - CONTRACT VERIFICATION 插件

1. 在主界面点击左下角插件管理（PLUGIN MANAGER）按钮。
   ![0-7.png](./img/0-7.png)
2. 搜索 etherscan - contract verification，并点击激活（Activate）按钮。
   ![0-8.png](./img/0-8.png)
3. 点击左侧工具栏中的 etherscan - contract verification 图标，并输入 API Key，点击 按钮 Save API Key。
   ![0-9.png](./img/0-9.png)

## 5.验证合约

1. 编译合约，选中 Sepolia 测试网并进行部署。
   ![0-10.png](./img/0-10.png)
2. 点击 view on etherscan 获取部署合约地址。
   ![0-11.png](./img/0-11.png)
3. 打开验证合约插件，选择待验证的合约名字，输入构造参数的十六进制数据和合约地址，点击按钮 Verify Contract。
   ![0-12.png](./img/0-12.png)
4. 进入合约地址查看验证是否通过。
   ![0-13.png](./img/0-13.png)

### 中文 solidity 资料推荐：

[Solidity 中文文档](https://solidity-cn.readthedocs.io/zh/develop/introduction-to-smart-contracts.html)（官方文档的中文翻译）
