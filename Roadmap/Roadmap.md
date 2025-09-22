## 区块链与 Web3 学习路线图

## 区块链与 Web3 基础

### 区块链基础知识

- [区块链技术解释](https://www.youtube.com/watch?v=qOVAbKKSH10)
- [慢雾(SlowMist)区块链入门科普](https://mp.weixin.qq.com/mp/appmsgalbum?__biz=MzU4ODQ3NTM2OA==&action=getalbum&album_id=1378673890158936067&scene=126#wechat_redirect)
- [肖臻老师 - 区块链技术与应用](https://www.bilibili.com/video/BV1Vt411X7JF/?vd_source=7138dfc78c49f602f8d3ed8cfbf0513d)
- [梁培利老师 - 区块链专业前沿](https://space.bilibili.com/220951871/lists/4149583?type=season)
- [加密货币工作原理](https://www.bilibili.com/video/BV11x411i72w/)
- [《精通比特币》](https://github.com/tianmingyun/MasterBitcoin2CN)
- [《精通以太坊》](https://github.com/inoutcode/ethereum_book)

---

### 常用开发工具及框架

#### 基础开发工具

**包管理器**

- [npm](https://www.npmjs.com/)
- [pnpm](https://pnpm.io/)
- [yarn](https://yarnpkg.com/)
- [Git](https://www.w3schools.com/git/git_intro.asp?remote=github)

**IDE**

- **在线编译器**
  - [Remix](https://remix.ethereum.org/)
  - [ChainIDE](https://chainide.com/)
- **本地 IDE**
  - [VS Code](https://code.visualstudio.com/)
  - [Cursor](https://cursor.com/en)
  - [Claude Code](https://www.anthropic.com/claude-code)

#### 常用开发框架

- [Hardhat](https://hardhat.org/) - 推荐
- [Foundry](https://getfoundry.sh/) - 推荐
- [Truffle](https://archive.trufflesuite.com/)
- [Brownie](https://eth-brownie.readthedocs.io/en/stable/)

#### 与智能合约交互

- [NextJs](https://nextjs.org/)
- [React](https://react.dev/)
- [JSON-RPC](https://ethereum.org/en/developers/docs/apis/json-rpc/)
- [RPC Node Providers](https://www.alchemy.com/overviews/rpc-node)
- [viem](https://viem.sh/) - 最新的智能合约交互库
- [ethers.js](https://docs.ethers.org/) - 用于与智能合约交互的库
- [Web3.js](https://web3js.readthedocs.io/)
- [Wagmi](https://wagmi.sh/) - 提供 React Hooks 风格 API 的智能合约交互库
- [RainbowKit](https://www.rainbowkit.com/zh-CN/docs/introduction) - 用于构建 Web3 钱包连接界面的库

#### 去中心化存储

- [IPFS 简明解释](https://www.youtube.com/watch?v=NOazY8qvSts)
- [Filecoin](https://www.youtube.com/watch?v=5Uj6uR3fp-U)
- [Filebase](https://console.filebase.com/)
- [NFT.Storage](https://app.nft.storage/login)
- [Pinata](https://pinata.cloud/)

#### 预言机

- [Oracles 基础知识](https://www.youtube.com/watch?v=m64dLRjJ9Bs)
- [Chainlink](https://docs.chain.link/)

---

### 智能合约开发基础知识

#### 官方文档教程

- [以太坊官方开发教程](https://ethereum.org/zh/developers/docs/)
- [Solidity 官方文档](https://docs.soliditylang.org/zh-cn/latest/)

#### 开发实战教程

- [Web3 实习计划](https://web3intern.xyz/) - ETHPanda 和 LXDAO 社区联合推出，适合新手入门
- [WTF Academy](https://www.wtf.academy/) - 从 Solidity 基础到进阶的课程
- [Solidity by Example](https://solidity-by-example.org/) - 持续更新的 Solidity 教程，很全很干货
- [Chainlink 预言机](https://www.bilibili.com/video/BV1RFsfe5Ek5/?share_source=copy_web&vd_source=7bd10a58392fb81f60972275d32fb810) - 17 小时最全 Web3 教程：ERC20，NFT，Hardhat，CCIP 跨链
- [cyfrin 官网课程](https://updraft.cyfrin.io/courses/full-stack-web3-development-crash-course) - 8 小时 Web3 全栈开发者教程

#### 合约测试

**[Hardhat](https://learnblockchain.cn/docs/hardhat/getting-started/)**

- [单元测试](https://ethereum.org/zh/developers/docs/smart-contracts/testing/#automated-testing-for-smart-contracts)
- [代码覆盖率](https://github.com/sc-forks/solidity-coverage)
- [集成测试](https://ethereum.org/zh/developers/docs/smart-contracts/testing/#integration-testing-for-smart-contracts)

**[Foundry](https://learnblockchain.cn/docs/foundry/i18n/zh/index.html)**

- [模糊测试](https://learnblockchain.cn/docs/foundry/i18n/zh/forge/fuzz-testing.html)
- [不变性测试](https://rareskills.io/post/invariant-testing-solidity)

#### 常用的 ERC 标准

- [ERC-165](https://eips.ethereum.org/EIPS/eip-165) - 接口标准
- [ERC-20](https://eips.ethereum.org/EIPS/eip-20) - 同质化代币标准
- [ERC-721](https://eips.ethereum.org/EIPS/eip-721) - 非同质化代币标准(NFT)
- [ERC-1155](https://eips.ethereum.org/EIPS/eip-1155) - 多代币标准
- [ERC-4626](https://eips.ethereum.org/EIPS/eip-4626) - 代币金库标准
- [ERC-777](https://eips.ethereum.org/EIPS/eip-777) - 可交互性代币标准
- [ERC-2612](https://eips.ethereum.org/EIPS/eip-2612) - 代币批准签名
- [ERC-173](https://eips.ethereum.org/EIPS/eip-173) - 合约所有权标准
- [ERC-191](https://eips.ethereum.org/EIPS/eip-191) - 数据签名标准

**相关资源**

- [以太坊官方 ERC 标准](https://eips.ethereum.org/erc)
- [EIP.Fun](https://eip.fun/)
- [OpenZeppelin Library/Contracts](https://github.com/OpenZeppelin/openzeppelin-contracts)

#### 可升级合约/代理合约

- [不同模式的代理合约](https://ethereum-blockchain-developer.com/110-upgrade-smart-contracts/00-project/)
- [代理合约深入研究](https://proxies.yacademy.dev/)
- [OpenZeppelin Proxy](https://docs.openzeppelin.com/contracts/4.x/api/proxy)

#### DeFi 基础

**推荐课程**

- [梁培利老师 - 区块链金融原理](https://space.bilibili.com/220951871/lists/1219027?type=season)
- [梁培利老师 - DeFi 课程](https://space.bilibili.com/220951871/lists/2824381?type=season)
- [梁培利老师 - Uniswap 专题：从 V1 到 V4](https://space.bilibili.com/220951871/lists/5076602?type=season)

**核心概念**

- [Lending and Borrowing：去中心化借贷平台](https://www.youtube.com/watch?v=aTp9er6S73M)
  - [AAVE](https://www.youtube.com/watch?v=WwE3lUq51gQ)
  - [Compound](https://docs.compound.finance/)
- [DEXs：去中心化交易所](https://www.youtube.com/watch?v=eGbEbFZl4yw)
  - [Uniswap V2 白皮书](https://app.uniswap.org/whitepaper.pdf)
  - [Uniswap V3 白皮书](https://app.uniswap.org/whitepaper-v3.pdf)
  - [Uniswap V4 白皮书](https://app.uniswap.org/whitepaper-v4.pdf)
- [Balancer](https://medium.com/token-terminal/eli5-what-is-balancer-labs-16c8cfe092d9)

  > **Balancer 说明**：Balancer 是一种自动做市商(AMM)协议，它建立在 Uniswap 的功能之上，将 AMM 的使用扩展到由多种权重不均的资产组成的流动性池(LP)

---

### 安全相关

#### 安全入门

- [Knowledge Base 慢雾超全安全知识库](https://github.com/slowmist/Knowledge-Base)
- [慢雾区块链安全入门科普](https://github.com/slowmist/Knowledge-Base/blob/master/blockchain_security_study_notes/README.md)

#### 常见合约漏洞及攻击手段

- [SWC-智能合约漏洞分类](https://swcregistry.io/)
- [智能合约安全指南: 从攻防双向介绍](https://scsfg.io/hackers/)
- [RareSkills: 智能合约安全](https://www.rareskills.io/post/smart-contract-security)
- [Quillhash: Solidity 常见的智能合约攻击手法或漏洞类型库](https://github.com/Quillhash/Solidity-Attack-Vectors)

#### 安全标准与最佳实践

- [Solidity 设计模式与最佳实践文档](https://fravoll.github.io/solidity-patterns/)
- [SCSVSv2 全面的安全检查标准](https://github.com/securing/SCSVS/tree/prerelease/SCSVSv2)
- [ConsenSys 智能合约最佳实践](https://github.com/ConsenSysDiligence/smart-contract-best-practices)
- [Foundry 测试最佳实践](https://learnblockchain.cn/docs/foundry/i18n/zh/tutorials/best-practices.html)

#### 安全工具

- [QuillHash: Web3 安全工具库](https://github.com/Quillhash/Web3-Security-Tools)
- [Echidna](https://github.com/crytic/echidna) - 智能合约专用的模糊测试工具，使用基于合约 ABI 的生成测试方法(property-based fuzzing)，可检测自定义断言失效与复杂状态问题
- [Slither](https://github.com/crytic/slither) - 高效的 Solidity(及 Vyper)静态分析工具，基于 SlithIR 中间表示执行，具备漏洞检测、代码审查支持、性能优化建议等多种功能，可轻松集成到 CI 中
- [Manticore](https://github.com/trailofbits/manticore) - 动态符号执行框架，支持 Ethereum 智能合约与二进制程序的程序状态探索、Bug 定位与路径覆盖

#### CTF 挑战一下

- [OpenZeppelin Ethernaut](https://ethernaut.openzeppelin.com/)
- [Capture the Ether](https://capturetheether.com/)
- [CTF Blockchain Challenges(100+)](https://github.com/minaminao/ctf-blockchain#ethereumcontract-basics)

---

### 推荐的学习网站

- [Hackquest](https://www.hackquest.io/zh-cn) - Web3 技术教育在线学习平台，完成课程学习会有 NFT 奖励
- [WTF Academy](https://wtf.academy/) - 从 Solidity 基础到进阶的课程
- [OpenZeppelin](https://docs.openzeppelin.com/contracts/4.x/)
- [Smart Contract Engineer](https://www.smartcontract.engineer/)
- [Coursera Blockchain Basics](https://www.coursera.org/learn/blockchain-basics) - Coursera 上的区块链基础课程
- [CryptoZombies](https://cryptozombies.io/zh/course/) - 加密僵尸游戏-通过游戏形式学习 Solidity
- [Web3 University](https://www.web3.university/find) - 内容全面的 Web3 在线学习平台
- [LearnWeb3.io](https://learnweb3.io/) - 也是一个 Web3 学习网站

---

### 测试网水龙头

- [Faucet Trade](https://faucet.trade/sepolia-eth-faucet)
- [Google Cloud](https://cloud.google.com/application/web3/faucet/ethereum/sepolia)
- [Getblock](https://getblock.io/faucet/eth-sepolia/)
- [Testnet Help](https://testnet.help/en/ethfaucet/sepolia)
- [PK910](https://sepolia-faucet.pk910.de/)
- [Infura](https://www.infura.io/faucet/sepolia)
- [Polygon](https://faucet.polygon.technology/)
- [Binance Smart Chain](https://www.bnbchain.org/en/testnet-faucet)
- [Chainlink](https://faucets.chain.link/)
- [Alchemy](https://www.alchemy.com/faucets/ethereum-sepolia)
- [QuickNode](https://faucet.quicknode.com/ethereum/sepolia)

---

### 很不错的社区推荐

- [LXDAO](https://forum.lxdao.io/) - LXDAO 是一个研发驱动的 DAO，致力于帮助开源项目和公共物品进入可持续发展的无限循环（Infinite Cycle）
- [ETHPanda](https://ethpanda.org/) - ETHPanda 是一个致力于推动以太坊和 Web3 技术在中文社区发展的开源组织
- [TinTinLand](https://tintinland.com/) - 一个影响力超高的 Web3 开发者社区，经常举办线上共学营、黑客松、Bootcamp 等活动
- [登链社区](https://learnblockchain.cn/) - 国内领先的 Web3 开发者社区、一个技术内容平台，致力于帮助开发者在 Web3 领域快速发展
- [Hackquest](https://www.hackquest.io/zh-cn) - 一个开发者技术教育平台及社区，提供免费课程、黑客松、链上证书等帮助全球开发者掌握区块链领域的最新技能
- [OpenBuild](https://openbuild.xyz/) - 致力于帮助 Web2 开发者更好进入 Web3 的开源社区，有时也会开展线上共学课程、黑客松以及一些 MeetUp 等线下活动

---

### 项目调研及数据分析网站推荐

- [CoinGlass 爆仓数据（Liquidation Data）](https://www.coinglass.com/zh/LiquidationData) - 聚焦加密期货市场的实时爆仓可视化工具，有助于分析市场极端波动和潜在风险
- [CoinMarketCap](https://coinmarketcap.com/) - 最大的加密货币行情网站，提供代币价格、交易量、排名等数据
- [CoinGecko](https://www.coingecko.com/) - 全球知名的加密货币行情网站，支持多链数据与代币信息查询
- [CoinCarp](https://www.coincarp.com/zh/) - 综合性行情与代币信息网站，支持多语言和全球数据查询
- [RootData](https://cn.rootdata.com/) - 区块链项目数据库，可查询项目融资历史、投资机构和团队信息
- [DefiLlama](https://defillama.com/) - DeFi 协议链上数据平台，可查看 TVL、收益率、跨链协议等信息
- [Dune](https://dune.com/home) - 链上数据分析与可视化平台，支持自定义 SQL 查询和图表制作

---

### 资讯、媒体平台推荐

- [Foresight News](https://foresightnews.pro/) - 区块链与 Web3 行业新闻媒体，提供快讯、深度报道、行业趋势分析等内容
- [币安新闻](https://www.binance.com/zh-CN/square/news/all) - 币安官方新闻板块，聚合全球加密货币与区块链最新资讯
- [Odaily](https://www.odaily.news/newsflash) - 又称星球日报，专注区块链快讯、深度报道和行业分析的中文媒体
- [律动](https://www.theblockbeats.info/newsflash) - The Block Beats，提供区块链快讯、市场观察和行业事件追踪
- [PANews](https://www.panewslab.com/zh/newsflash) - 区块链与数字金融新闻平台，涵盖新闻快讯、访谈、报告等内容
- [Chain Catcher](https://www.chaincatcher.com/news) - 中文区块链新闻与研究平台，提供新闻、人物专访、行业分析
- [TechFlow](https://www.techflowpost.com/newsletter/index.html) - Web3 行业深度内容与周报，关注项目研究与市场趋势

---

### 博客推荐

- [Ethereum 官方博客](https://ethereum.org/zh/blog/) - 以太坊官方博客
- [Ethereum Stack Exchange](https://ethereum.stackexchange.com/) - Ethereum 官方 Q&A 社区
- [EthResearch](https://ethresear.ch/) - Ethereum 官方技术论坛
- [Chainlink](https://blog.chain.link/) - Chainlink 官方博客
- [Reddit Web3](https://www.reddit.com/r/web3/) - Reddit 上的 Web3 频道
- [Medium Web3 Topics](https://medium.com/tag/web3) - Medium 上关于 Web3 的话题讨论

---

### 阅读推荐

#### 白皮书

- [比特币白皮书](https://bitcoin.org/bitcoin.pdf)
- [以太坊白皮书](https://ethereum.org/en/whitepaper/)
- [以太坊黄皮书](https://ethereum.github.io/yellowpaper/paper.pdf)

#### 技术书籍

- [《精通比特币》](https://github.com/tianmingyun/MasterBitcoin2CN) - 比特币深入讲解
- [《精通以太坊》](https://github.com/inoutcode/ethereum_book) - 以太坊技术深入分析

#### 开发文档

- [Ethereum 文档](https://ethereum.org/zh/developers/docs/) - 以太坊官方开发文档
- [OpenZeppelin](https://www.openzeppelin.com/) - Solidity 安全开发工具库

#### 安全相关

- [Solidity 安全陷阱和最佳实践 101](https://secureum.substack.com/p/security-pitfalls-and-best-practices-101)
- [Solidity 安全陷阱和最佳实践 201](https://secureum.substack.com/p/security-pitfalls-and-best-practices-201)

#### DeFi 相关

- [How to Defi](https://nigdaemon.gitbook.io/how-to-defi-advanced-zhogn-wen-b) - DeFi 技术深入分析
- [Uniswap V2 白皮书](https://app.uniswap.org/whitepaper.pdf)
- [Uniswap V3 白皮书](https://app.uniswap.org/whitepaper-v3.pdf)
- [Uniswap V4 白皮书](https://app.uniswap.org/whitepaper-v4.pdf)
