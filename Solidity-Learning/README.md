# Solidity 智能合约教程

>**基于 solidity-by-example 的中文 Solidity 教程学习整理**


## 教程目录

### 基础工具
- [00_Tools](./contracts/00_Tools/Tools.md) - 开发环境搭建与工具使用
- [Hardhat](./Hardhat/README.md) - 开发环境搭建与工具使用
- [Foundry](./Foundry/README.md) - 开发环境搭建与工具使用

### 入门基础
- [01_Hello World](./contracts/01_Hello%20World/Hello%20World.md) - 第一个智能合约
- [02_FirstApp](./contracts/02_FirstApp/02_First%20Application.md) - 第一个dapp

### 数据类型与变量
- [03_Primitive Data Types](./contracts/03_Primitive%20Data%20Types/Primitive%20Data%20Types.md) - 基本数据类型
- [04_Variables](./contracts/04_Variables/04_Variables.md) - 变量声明与使用
- [05_Constants](./contracts/05_Constants/Constants.md) - 常量定义
- [06_Immutable](./contracts/06_Immutable/06_Immutable.md) - 不可变变量

### 控制结构与函数
- [07_Reading and Writing to a State Variable](./contracts/07_Reading%20and%20Writing%20to%20a%20State%20Variable/Reading%20and%20Writing%20to%20a%20State%20Variable.md) - 状态变量读写
- [08_Ether and Wei](./contracts/08_Ether%20and%20Wei/08_Ether_and_Wei.md) - 以太币单位转换
- [09_Gas](./contracts/09_Gas/Gas.md) - Gas 费用优化
- [10_IfElse](./contracts/10_IfElse/10_IfElse.md) - 条件判断
- [11_For and While Loop](./contracts/11_For%20and%20While%20Loop/For%20and%20While%20Loop.md) - 循环结构
- [12_Mapping](./contracts/12_Mapping/12_Mapping.md) - 映射类型
- [13_Array](./contracts/13_Array/Array.md) - 数组操作
- [14_Enum](./contracts/14_Enum/14_Enum.md) - 枚举类型
- [15_Structs](./contracts/15_Structs/Structs.md) - 结构体
- [16_DataLocations](./contracts/16_DataLocations/16_DataLocations.md) - 数据位置
- [17_Function](./contracts/17_Function/Function.md) - 函数定义
- [18_View and Pure Functions](./contracts/18_View%20and%20Pure%20Functions/18_View_and_Pure.md) - 视图和纯函数
- [19_Error](./contracts/19_Error/Error.md) - 错误处理
- [20_Function Modifier](./contracts/20_Function%20Modifier/20_Function_Modifier.md) - 函数修饰符

### 高级特性
- [21_Events](./contracts/21_Events/Event.md) - 事件系统
- [22_Constructor](./contracts/22_Constructor/22_Constructor.md) - 构造函数
- [23_Inheritance](./contracts/23_Inheritance/Inheritance.md) - 继承机制
- [24_Shadowing Inherited State Variables](./contracts/24_Shadowing%20Inherited%20State%20Variables/24_Shadowing_Inherited_State_Variables.md) - 继承状态变量遮蔽
- [25_Calling Parent Contracts](./contracts/25_Calling%20Parent%20Contracts/Calling%20Parent%20Contracts.md) - 调用父合约
- [26_Visibility](./contracts/26_Visibility/26_Visibility.md) - 可见性修饰符
- [27_Interface](./contracts/27_Interface/Interface.md) - 接口定义
- [28_Payable](./contracts/28_Payable/28_Payable.md) - 可支付函数
- [29_Sending Ether](./contracts/29_Sending%20Ether%20(transfer,%20send,%20call)/Sending_Ether.md) - 发送以太币
- [30_Fallback](./contracts/30_Fallback/30_Fallback.md) - 回退函数
- [31_Call](./contracts/31_Call/Call.md) - 低级调用
- [32_Delegatecall](./contracts/32_Delegatecall/32_Delegatecall.md) - 委托调用
- [33_Function Selector](./contracts/33_Function%20Selector/Function%20Selector.md) - 函数选择器
- [34_Calling Other Contract](./contracts/34_Calling%20Other%20Contract/34_Calling_Other_Contract.md) - 调用其他合约
- [35_Contract that Creates other Contracts](./contracts/35_Contract%20that%20Creates%20other%20Contracts/Creates_other_Contracts.md) - 合约工厂模式
- [36_TryCatch](./contracts/36_TryCatch/36_TryCatch.md) - 异常处理
- [37_Import](./contracts/37_Import/Import.md) - 导入语句
- [38_Library](./contracts/38_Library/38_Library.md) - 库合约
- [39_ABI Encode](./contracts/39_ABI%20Encode/ABI_Encode.md) - ABI 编码
- [40_ABI Decode](./contracts/40_ABI%20Decode/40_ABI_Decode.md) - ABI 解码
- [41_Hashing with Keccak256](./contracts/41_Hashing%20with%20Keccak256/Hashing_with_Keccak256.md) - Keccak256 哈希
- [42_Verifying Signature](./contracts/42_Verifying%20Signature/42_Verifying_Signature.md) - 签名验证
- [43_Gas Saving Techniques](./contracts/43_Gas%20Saving%20Techniques/Gas_Saving_Techniques.md) - Gas 优化技巧
- [44_Bitwise Operators](./contracts/44_Bitwise%20Operators/44_Bitwise_Operators.md) - 位运算符
- [45_Unchecked Math](./contracts/45_Unchecked%20Math/Unchecked_Math.md) - 未检查数学运算
- [46_Ether Wallet](./contracts/46_Ether%20Wallet/46_Ether_Wallet.md) - 以太币钱包
- [47_Multi-Sig Wallet](./contracts/47_Multi-Sig%20Wallet/Multi-Sig%20Wallet.md) - 多重签名钱包
- [48_Merkle Tree](./contracts/48_Merkle%20Tree/48_Merkle_Tree.md) - 默克尔树
- [49_Iterable Mapping](./contracts/49_Iterable%20Mapping/Iterable_Mapping.md) - 可迭代映射

### 代币标准
- [50_ERC20](./contracts/50_ERC20/50_ERC20.md) - ERC20 代币标准
- [51_ERC721](./contracts/51_ERC721/ERC721.md) - ERC721 NFT 标准

### 高级合约模式
- [52_Simple Bytecode Contract](./contracts/52_Simple%20Bytecode%20Contract/52_Simple_Bytecode_Contract.md) - 简单字节码合约
- [53_Precompute Contract Address with Create2](./contracts/53_Precompute%20Contract%20Address%20with%20Create2/Precompute_Contract_Address_with_Create2.md) - Create2 预计算地址
- [54_Minimal Proxy Contract](./contracts/54_Minimal%20Proxy%20Contract/54_Minimal_Proxy_Contract.md) - 最小代理合约
- [55_Upgradeable Proxy](./contracts/55_Upgradeable%20Proxy/Upgradeable_Proxy.md) - 可升级代理合约
- [56_Deploy Any Contract](./contracts/56_Deploy%20Any%20Contract/56_Deploy_Any_Contract.md) - 部署任意合约
- [57_Write to Any Slot](./contracts/57_Write%20to%20Any%20Slot/Write_to_Any_Slot.md) - 写入任意存储槽
- [58_Uni-Directional Payment Channel](./contracts/58_Uni-Directional%20Payment%20Channel/58_Uni-Directional_Payment_Channel.md) - 单向支付通道
- [59_Bi-Directional Payment Channel](./contracts/59_Bi-Directional%20Payment%20Channel/Bi-Directional_Payment_Channel.md) - 双向支付通道
- [60_English Auction](./contracts/60_English%20Auction/60_English_Auction.md) - 英式拍卖
- [61_Dutch Auction](./contracts/61_Dutch%20Auction/Dutch_Auction.md) - 荷兰式拍卖
- [62_Crowd Fund](./contracts/62_Crowd%20Fund/62_Crowd_Fund.md) - 众筹合约
- [63_Multi Call](./contracts/63_Multi%20Call/Multi_Call.md) - 多重调用
- [64_Multi Delegatecall](./contracts/64_Multi%20Delegatecall/64_Multi_Delegatecall.md) - 多重委托调用
- [65_Time Lock](./contracts/65_Time%20Lock/Time_Lock.md) - 时间锁

### 安全与漏洞
- [66_Re-Entrancy](./contracts/66_Re-Entrancy/66_Re-Entrancy.md) - 重入攻击
- [67_Arithmetic Overflow and Underflow](./contracts/67_Arithmetic%20Overflow%20and%20Underflow/Arithmetic_Overflow_and_Underflow.md) - 算术溢出和下溢
- [68_Self Destruct](./contracts/68_Self%20Destruct/68_Self_Destruct.md) - 自毁合约
- [69_Accessing Private Data](./contracts/69_Accessing%20Private%20Data/Accessing_Private_Data.md) - 访问私有数据
- [70_Delegatecall](./contracts/70_Delegatecall/70_Delegatecall.md) - 委托调用安全
- [71_Source of Randomness](./contracts/71_Source%20of%20Randomness/Source_of_Randomness.md) - 随机数来源
- [72_Denial of Service](./contracts/72_Denial%20of%20Service/72_Denial_of_Service.md) - 拒绝服务攻击
- [73_Phishing with tx.origin](./contracts/73_Phishing%20with%20tx.origin/Phishing_with_tx.origin.md) - tx.origin 钓鱼攻击
- [74_Hiding Malicious Code with External Contract](./contracts/74_Hiding_Malicious_Code_with_External_Contract/74_Hiding_Malicious_Code.md) - 隐藏恶意代码
- [75_Honeypot](./contracts/75_Honeypot/Honeypot.md) - 蜜罐合约
- [76_Front Running](./contracts/76_Front%20Running/76_Front_Running.md) - 抢先交易
- [77_Block Timestamp Manipulation](./contracts/77_Block%20Timestamp%20Manipulation/Block_Timestamp_Manipulation.md) - 区块时间戳操纵
- [78_Signature Replay](./contracts/78_Signature%20Replay/78_Signature_Replay.md) - 签名重放攻击
- [79_Bypass Contract Size Check](./contracts/79_Bypass%20Contract%20Size%20Check/Bypass_Contract_Size_Check.md) - 绕过合约大小检查
- [80_Echidna](./contracts/80_Echidna/80_Echidna.md) - Echidna 模糊测试

### DeFi 协议
- [81_Chainlink Price Oracle](./contracts/81_Chainlink%20Price%20Oracle/Chainlink_Price_Oracle.md) - Chainlink 价格预言机
- [82_Staking Rewards](./contracts/82_Staking%20Rewards/82_Staking_Rewards.md) - 质押奖励
- [83_Discrete Staking Rewards](./contracts/83_Discrete%20Staking%20Rewards/Discrete_Staking_Reward.md) - 离散质押奖励
- [84_Vault](./contracts/84_Vault/84_Vault.md) - 金库合约
- [85_Constant Sum AMM](./contracts/85_Constant%20Sum%20AMM/Constant_Sum_AMM.md) - 恒定和 AMM
- [86_Constant Product AMM](./contracts/86_Constant%20Product%20AMM/86_Constant_Product_AMM.md) - 恒定乘积 AMM
- [87_Stable Swap AMM](./contracts/87_Stable%20Swap%20AMM/Stable_Swap_AMM.md) - 稳定交换 AMM


