
主要参考:
- [欢迎来到go-ethereum](https://geth.ethereum.org/docs)
- [Getting started with Geth](https://geth.ethereum.org/docs/getting-started)

更新于 2024/05/24。

其他参考:
- [Ethereum Development Tutorials](https://ethereum.org/developers/tutorials/)
- [Ethereum accounts](https://ethereum.org/en/developers/docs/accounts/)

Go-ethereum(又叫做 Geth)是用 Go 写的以太坊客户端。它是原始、最流行的以太坊客户端之一。

本页介绍如何设置 Geth 并使用命令行工具执行一些基本任务。要使用 Geth，必须先安装该软件。根据操作系统和用户选择的安装方法，有多种 Geth 安装方式，例如使用包管理器、容器或从源代码构建。Geth 的安装说明可在[安装和构建页面](安装Geth.md)上找到。

Geth 还需要连接到共识客户端才能作为以太坊节点运行。本页教程假设 Geth 和共识客户端已成功安装，并且已配置防火墙以阻止到 JSON-RPC 端口 8545 的外部流量(请参阅[安全性](安全.md))。

本页提供分步说明，涵盖使用 Geth 的基础知识。这包括创建账户、加入以太坊网络、同步区块链以及在账户之间发送以太币。本教程使用[Clef](https://geth.ethereum.org/docs/tools/clef/tutorial)。Clef 是 Geth 外部的一个账户管理工具，允许用户签署交易。它由 Geth 团队开发和维护。

### 前提条件

为了充分利用本页教程，您需要具备以下技能:
- 命令行使用经验
- 以太坊和测试网基础知识
- HTTP 和 JavaScript 基础知识
- 节点架构和共识客户端基础知识

需要重新学习这些基础知识的用户可以在[这里](https://developer.mozilla.org/en-US/docs/Learn/Tools_and_testing/Understanding_client-side_tools/Command_line)找到与命令行相关的有用资源，以太坊及其测试网在[这里](https://ethereum.org/developers/tutorials/)、[这里](https://developer.mozilla.org/en-US/docs/Web/HTTP)以及 JavaScript 的相关资源在[这里](https://www.javascript.com/learn)。节点架构信息可以在[这里](https://geth.ethereum.org/docs/fundamentals/node-architecture)找到，配置 Geth 连接共识客户端的指南在[这里](https://geth.ethereum.org/docs/getting-started/consensus-clients)。

> 注意:

> 如果 Geth 是在 Linux 上从源代码安装的，make 会将 Geth 的二进制文件及其相关工具保存在 /build/bin 目录中。为了方便运行这些程序，可以将它们从 /go-ethereum 移动到顶层项目目录（例如，运行 mv ./build/bin/* ./）。然后，必须在代码片段的命令前添加 ./ 才能执行特定程序，例如，使用 ./geth 而不是简单的 geth。如果可执行文件未移动，请导航到 bin 目录运行它们（例如，cd ./build/bin 和 ./geth），或者提供它们的路径（例如，./build/bin/geth）。对于其他安装，可以忽略这些说明。

### 背景说明

Geth 是一个用 Go 编写的以太坊客户端。这意味着运行 Geth 会将计算机变成以太坊节点。以太坊是一个点对点网络，信息直接在节点之间共享，而不是由中央服务器管理。每 12 秒随机选择一个节点生成一个新区块，其中包含接收该区块的节点应执行的交易列表。这个"区块提议者"节点将新区块发送给其他节点。每个节点在收到新区块后，都会检查其有效性并将其添加到自己的数据库中。这些离散区块的序列被称为"区块链"。

Geth 使用每个区块中提供的信息来更新其"状态"——以太坊上每个账户的以太币余额以及每个智能合约存储的数据。账户分为两种类型: 外部拥有账户(EOA)和合约账户。合约账户在收到交易时会执行合约代码。EOA 是用户在本地管理的账户，用于签署和提交交易。每个 EOA 都是一对公私钥，其中公钥用于为用户生成唯一的地址，私钥用于保护账户并安全地签署消息。因此，要使用以太坊，首先需要生成一个 EOA(以下简称"账户"）。

在[这里](https://ethereum.org/en/developers/docs/accounts/)阅读有关以太坊账户的更多信息。
