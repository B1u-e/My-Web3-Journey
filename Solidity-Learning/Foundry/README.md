# 什么是 Foundry?
  Foundry 是一个用 Rust 语言编写的，用于以太坊应用程序开发的极快、可移植和模块化的工具包。它提供专业的 Solidity 开发环境和工具链，可以快速、方便地完成依赖项管理、编译、运行测试和部署。Foundry 的构建和测试执行速度很快，支持与其他类型的工程集成，如与 Hardhat 集成。它还具有模块化的特点，可以通过 git submodule 和构建目录映射快速方便地引入依赖。

# Foundry 的主要功能
Foundry 可以用来创建以太坊（Solidity）智能合约应用开发项目，管理以太坊(Solidity)智能合约的依赖项目，创建由 Solidity 语言编写的测试用例并快速执行，支持模糊测试和差异测试等方便、专业的测试方式。此外，Foundry 还可以通过 Cheatcodes（作弊码）在 Solidity 语言编写的测试用例中进行 “EVM环境之外” 的 vm 功能进行交互与断言，例如更换测试用例语句执行者的钱包地址（更换 msg.sender）、对 EVM 外的 Event 事件进行断言。Foundry 还支持执行过程与错误追踪，包括“函数堆栈”级的错误追踪（Traces），部署合约和自动化完成scan上合约的开源验证，在项目中支持完整的gas使用情况追踪，包括合约测试细节的gas用量和gas报告，以及交互式调试器。

# Foundry 的组成
Foundry 项目由 Forge, Cast, Anvil 几个部分（命令行工具）组成

Forge: Foundry 项目中执行初始化项目、管理依赖、测试、构建、部署智能合约的命令行工具;
Cast: Foundry 项目中与 RPC 节点交互的命令行工具。可以进行智能合约的调用、发送交易数据或检索任何类型的链上数据;
Anvil: Foundry 项目中启动的本地测试网/节点的命令行工具。可以使用它配合测试前端应用与部署在该测试网的合约或通过 RPC 进行交互;

# 快速使用 — 创建一个 Foundry 项目
    安装Foundry的方法如下：
    $ curl -L https://foundry.paradigm.xyz | bash
    $ foundryup
    $ forge init hello-world
    $ cd hello-world， 通过tree命令查看项目结构
    $ tree -L 2
    .
    ├── foundry.toml        # Foundry 的 package 配置文件
    ├── lib                 # Foundry 的依赖库
    │   └── forge-std       # 工具 forge 的基础依赖
    ├── script              # Foundry 的脚本
    │   └── Counter.s.sol   # 示例合约 Counter 的脚本
    ├── src                 # 智能合约的业务逻辑、源代码将会放在这里
    │   └── Counter.sol     # 示例合约
    └── test                # 测试用例目录
        └── Counter.t.sol   # 示例合约的测试用例

    执行构建&测试
    $ forge build
    $ forge test


    部署合约
```solidity
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
// 引入合约
import "../src/Counter.sol";

contract CounterScript is Script {
    function setUp() public {
        console2.log("setup ");
    }

    function run() public {
        vm.startBroadcast();
        //生成合约对象
        Counter c = new Counter();

        vm.stopBroadcast();
    }

}
```

    部署到测试网
```bash
forge script script/Counter.s.sol -vvvv --rpc-url=http://127.0.0.1:8545
```
    部署到主网
```bash
forge script script/Counter.s.sol -vvvv --rpc-url=http://127.0.0.1:8545 --broadcast --private-key=privete_key
```


# Foundry Cast的进阶使用
// markdown list
* 查询区块
```bash
# $PRC_MAIN 替换成需要的RPC地址
cast block-number --rpc-url=$RPC_MAIN
```
* 查询交易
```bash
# 跟ethersjs中的 provider.getTransaction 类似
# cast tx <HASH> [FIELD] --rpc-url=$RPC

# 跟ethersjs中的 provider.getTransactionReceipt类似
# cast receipt <HASH> [FIELD] --rpc-url=$RPC

cast tx 0x20e7dda515f04ea6a787f68689e27bcadbba914184da5336204f3f36771f59f0 --rpc-url=$RPC

cast receipt 0x20e7dda515f04ea6a787f68689e27bcadbba914184da5336204f3f36771f59f0 --rpc-url=$RPC

# 只获取logs

cast receipt 0x20e7dda515f04ea6a787f68689e27bcadbba914184da5336204f3f36771f59f0 logs --rpc-url=$RPC
```

* 交易解析
```bash
# cast 4byte <SELECTOR> 解析交易的名称
cast 4byte 0x38ed1739
```
* 交易签名
```bash
cast sig <SIG>
cast sig "swapExactTokensForTokens(uint256,uint256,address[],address,uint256)"
```

* 交易解码
```bash
# 获得calldata
cast tx 0x20e7dda515f04ea6a787f68689e27bcadbba914184da5336204f3f36771f59f0 input --rpc-url=$RPC
```

* 模拟运行
```bash
  cast run --rpc-url <URL> <TXHASH>
```

* 账户管理
 * 新建账户
```bash
  cast wallet new
```
* 账户签名
```bash
  cast wallet sign <MESSAGE> --keystore=<PATH>
```
* 账户验证
```bash
  cast wallet verify --address <ADDRESS> <MESSAGE> <SIGNATURE>
```
* 合约交互
 * 获取合约
 cast etherscan-source <contract address>
 * 下载合约
  cast etherscan-source <contract address> --d
 * 调用合约
```bash
  cast call [OPTIONS] [TO] [SIG] [ARGS]... [COMMAND] --rpc-url=$RPC
```
 * 解析ABI
```bash
  cast interface [OPTIONS] <PATH_OR_ADDRESS>
```


