
*因为遗失了一些东西，所以很多事情不得不从头开始...*

### 说明

- Geth 和 Lighthouse 均采用最新版本测试，其中 Geth 版本为 v1.16.5，Lighthouse 版本为 8.0.1。
- 低配置机器下应使用 Ephemery 测试网测试。在笔者机器(CPU:4 Memory:8G Disk(avail):120G bandwith: 100Mbps)上，只有 Ephemery 较为顺利。
- 浏览器选择 google chrome。

### 内容

- [以太坊概述](ch01)
  - [区块链技术](ch01/01_区块链技术.md)
  - [以太坊架构](ch01/02_以太坊架构.md)
  - [以太坊地址](ch01/03_以太坊地址.md)
  - [DApp概述](ch01/04_DApp概述.md)
  - [智能合约](ch01/05_智能合约.md)
- [功能客户端](ch02)
  - [节点架构](ch02/01_节点架构.md)
  - [安装配置](ch02/02_安装配置.md)
  - [初次运行](ch02/03_初次运行.md)
  - [数据同步](ch02/04_数据同步.md)
  - [账户管理](ch02/05_账户管理.md)
  - [对等节点](ch02/06_对等节点.md)
  - [日志信息](ch02/07_日志信息.md)
  - [配置文件](ch02/08_配置文件.md)
- [Remix环境](ch03)
  - [熟悉环境](ch03/01_熟悉环境.md)
  - [示例操作](ch03/02_示例操作.md)
  - [程序调试](ch03/03_程序调试.md)
  - [QuickDapp插件](ch03/04_QuickDapp.md)
- [Solidity语言](ch04)
  - [变量类型](ch04/01_变量类型.md)
  - [变量存储](ch04/02_变量存储.md)
  - [合约函数](ch04/03_合约函数.md)
  - [内建对象](ch04/04_内建对象.md)
  - [断言处理](ch04/05_断言处理.md)
  - [合约事件](ch04/06_合约事件.md)
  - [面向对象](ch04/07_面向对象.md)
  - [导入依赖](ch04/08_导入依赖.md)
- [智能合约](ch05)
  - [合约开发](ch05/01_合约开发.md)
  - [ERC标准](ch05/02_ERC标准.md)
  - [Go调用](ch04/03_Go调用.md)
  - [Python调用](ch04/04_Python调用.md)

- [安全问题](ch06)
  - [重入漏洞](ch06/01_重入漏洞.md)
  - [整型溢出](ch06/02_整型溢出.md)
  - [权限管理]
  - [前端劫持]
- [工程级开发](ch07)
  - [RemixD]
  - [Hardhat]
  - [Fundary]

- [Geth更多](ch08)
  - [数据存储](ch08/01_数据存储.md)
  - [备份和恢复](ch08/02_备份和恢复.md)
  - [历史修剪](ch08/03_历史修剪.md)
  - [数据库修剪](ch08/04_数据库修剪.md)
  - [下载Era](ch08/05_下载Era.md)
  - [存档模式](ch08/06_存档模式.md)
  - [Kurtosis私有网络](ch08/07_Kurtosis私有网络.md)
- [JSON-RPC接口](ch07)

### 网站

- 以太坊
  - [Ethereum Whitepaper](https://ethereum.org/whitepaper#ethereum-whitepaper)
  - [Protocol Wiki](https://epf.wiki/#/)
  - [Proof of Work](https://ethereum.org/developers/docs/consensus-mechanisms/pow/)
  - [Proof of Stake](https://ethereum.org/developers/docs/consensus-mechanisms/pos/)
  - [Ethereum Stack Exchange](https://ethereum.stackexchange.com/)
  - [Ethereum Improvement Proposals](https://eips.ethereum.org/)

- 主网相关
  - [Ethereum (ETH) Blockchain Explorer](https://etherscan.io/)

- 测试网络
  - Sepolia
    - [Ethereum Sepolia Faucet](https://cloud.google.com/application/web3/faucet/ethereum/sepolia)
    - [TESTNET Sepolia (ETH) Blockchain Explorer](https://sepolia.etherscan.io/)
    - [ETH Testnet Bridge by LayerZero](https://testnetbridge.com/sepolia)
    - [sepolia dev](https://sepolia.dev/)
  - Ephemery
    - [ephemery dev](https://ephemery.dev/)
    - [Otterscan](https://otter.bordel.wtf/)
    - [Ephemery testnet](https://explorer.ephemery.dev/)
    - [Github: ephemery-resources](https://github.com/ephemery-testnet/ephemery-resources)
    - [Ephemery Testnet - Client Implementation](https://octant.app/project/8/0xd6f2C2d99Dd39B39f62D44f4842e58cF32b2F90F)
  - Hoodi
    - []()
  - Holesky
    - [Holesky explorer](https://eth-holesky.blockscout.com/)

- 检查点
  - [Ethereum Beacon Chain checkpoint sync endpoints](https://eth-clients.github.io/checkpoint-sync-endpoints/)

- 执行端
  - [Geth](https://coinmarketcap.com/academy/glossary/geth)
  - [go-ethereum](https://geth.ethereum.org/)
  - [Ethereum Development with Go](https://goethereumbook.org/en/)
  - [Execution clients](https://ethereum.org/developers/docs/nodes-and-clients/#execution-clients)
  - [go-ethereum github](https://github.com/ethereum/go-ethereum)

- 共识端
  - [Lighthouse Book](https://lighthouse-book.sigmaprime.io/)
  - [Lighthouse Release Version](https://github.com/sigp/lighthouse/tags)

- 开发者
  - [Ethereum Development Tutorials](https://ethereum.org/developers/tutorials/)
  - [Ethereum development documentation](https://ethereum.org/en/developers/docs)
  - [solidity language abi spec](https://docs.soliditylang.org/en/develop/abi-spec.html)

- 信息站
  - [ChainList](https://chainlist.org/)
  - [Cryptocurrency Prices, Charts And Market Capitalizations | CoinMarketCap](https://coinmarketcap.com/)

- 未知站
  - [Your Multi-Chain Gateway to Blockchain Development | QuickNode](https://www.quicknode.com/chains)
  - [How to buy Ethereum (ETH)](https://ethereum.org/get-eth/)

- 技术站
  - [HTTP: Hypertext Transfer Protocol](https://developer.mozilla.org/en-US/docs/Web/HTTP)
  - [Learn Javascript](https://www.javascript.com/learn)

### 问题

- [ubuntu20.04安装好搜狗输入法无法输入中文，只能输入英文的问题](https://blog.csdn.net/ccsodefhy/article/details/123122200)
