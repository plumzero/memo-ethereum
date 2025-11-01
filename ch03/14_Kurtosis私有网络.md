
主要参考:
- [Private Networks via Kurtosis](https://geth.ethereum.org/docs/fundamentals/kurtosis)

更新于 2024/07/02。

本指南讲解如何使用 [Kurtosis](https://docs.kurtosis.com/basic-concepts/)（一款用于运行容器化软件包的工具）搭建由多个 Geth 节点及其对应的共识客户端组成的私有网络。如果节点未连接到主网或任何测试网，则以太坊网络是私有的。此处的私有仅指保留或隔离，而非受保护或安全。完全受控的私有以太坊网络可作为核心开发者处理网络/区块链同步等相关问题时的后端。私有网络对于测试多区块和多用户场景的 Dapp 开发者也非常有用。

> 注意: Geth 仅支持以太坊 PoS 共识机制。这是一种无需许可的算法，这意味着任何能够访问私有网络并拥有足够以太币（仅限该网络内部）的人都可以成为验证者并提议区块。

### 前提条件

要学习本页教程，您需要先安装并运行 Kurtosis（安装说明请点击[此处](https://docs.kurtosis.com/install/)），并安装 [Docker](https://docs.docker.com/get-started/get-docker/)。此外，了解 Geth 的基础知识也很有帮助（请参阅[入门指南](https://geth.ethereum.org/docs/getting-started)）。

### 私有网络

私有网络由多个以太坊节点组成，这些节点只能彼此连接。搭建一个全新的 PoS 网络涉及诸多细节。例如: 必须为执行客户端和共识客户端生成创世区块。创世区块还将包含验证者用于在网络上进行质押的存款合约。然后，必须根据创世区块文件设置执行客户端 (EL) 和共识客户端 (CL)。Kurtosis [ethereum-package](https://github.com/ethpandaops/ethereum-package) 将在后台处理所有这些工作，并可根据需要进行自定义。

#### 选择一个 network ID

以太坊主网的网络 ID 为 1。Geth 还可以通过提供替代链 ID 来连接许多其他网络，其中一些是测试网，另一些是基于 Geth 源代码分叉构建的替代网络。提供一个尚未被现有网络或测试网使用的网络 ID，意味着使用该网络 ID 的节点只能相互连接，从而创建一个私有网络。[Chainlist.org](https://chainlist.org) 上提供了当前网络 ID 的列表。

2.基本配置

Kurtosis 基于 Starlark 配置运行。将以下内容写入名为 `network_params.yaml` 的文件中:
```s
participants:
  - el_type: geth
    cl_type: lighthouse
    count: 2
  - el_type: geth
    cl_type: teku
network_params:
  network_id: "585858"
additional_services:
  - dora
```

这描述了所需的网络结构。该网络将由 3 个客户端对（执行和共识）组成。其中 2 个运行 geth/lighthouse，1 个运行 geth/teku。每个客户端对将拥有相同数量的验证者。它们将共享一个创世区块，并相互连接。对于私有网络，最好指定一个不冲突的网络 ID。如果未指定 ID，kurtosis 将选择一个默认 ID（撰写本文时，默认值为 3151908）。

#### 启动网络

配置完成后，启动网络就很简单了。运行以下命令:
```s
  kurtosis run github.com/ethpandaops/ethereum-package --args-file ./network_params.yaml --image-download always
```

这表示 ethereum-package 是一个依赖项，它定义了上述字段的含义。`--image-download always` 确保始终使用最新的镜像。运行成功后，将产生如下输出:
```s
INFO[2024-06-03T18:05:23+02:00] ===================================================
INFO[2024-06-03T18:05:23+02:00] ||          Created enclave: dusty-soil          ||
INFO[2024-06-03T18:05:23+02:00] ===================================================
Name:            dusty-soil
UUID:            1a33b911bfa4
Status:          RUNNING
Creation Time:   Mon, 03 Jun 2024 18:04:43 CEST
Flags:

========================================= Files Artifacts =========================================
UUID           Name
48ecd031ac60   1-lighthouse-geth-0-63-0
4d9057965009   2-lighthouse-geth-64-127-0
287a1079d7a7   3-teku-geth-128-191-0
760206ace8ae   dora-config
61bcf0e4a182   el_cl_genesis_data
72fa0877e1f0   final-genesis-timestamp
c30d6e459e5d   genesis-el-cl-env-file
3e1aa28cadf3   genesis_validators_root
41e32b09194d   jwt_file
3a555e3e1238   keymanager_file
1ffd63ba783c   prysm-password
a9eabb55db42   validator-ranges

========================================== User Services ==========================================
UUID           Name                                             Ports                                         Status
35dbe5e28986   cl-1-lighthouse-geth                             http: 4000/tcp -> http://127.0.0.1:54607      RUNNING
                                                                metrics: 5054/tcp -> http://127.0.0.1:54605
                                                                tcp-discovery: 9000/tcp -> 127.0.0.1:54606
                                                                udp-discovery: 9000/udp -> 127.0.0.1:56102
2758e9a955e3   cl-2-lighthouse-geth                             http: 4000/tcp -> http://127.0.0.1:54610      RUNNING
                                                                metrics: 5054/tcp -> http://127.0.0.1:54608
                                                                tcp-discovery: 9000/tcp -> 127.0.0.1:54609
                                                                udp-discovery: 9000/udp -> 127.0.0.1:55675
5e648790d930   cl-3-teku-geth                                   http: 4000/tcp -> http://127.0.0.1:54613      RUNNING
                                                                metrics: 8008/tcp -> 127.0.0.1:54611
                                                                tcp-discovery: 9000/tcp -> 127.0.0.1:54612
                                                                udp-discovery: 9000/udp -> 127.0.0.1:62286
1f961bcf0ef7   dora                                             http: 8080/tcp -> http://127.0.0.1:54628      RUNNING
f8a7764be245   el-1-geth-lighthouse                             engine-rpc: 8551/tcp -> 127.0.0.1:54586       RUNNING
                                                                metrics: 9001/tcp -> 127.0.0.1:54587
                                                                rpc: 8545/tcp -> http://127.0.0.1:54589
                                                                tcp-discovery: 30303/tcp -> 127.0.0.1:54588
                                                                udp-discovery: 30303/udp -> 127.0.0.1:51523
                                                                ws: 8546/tcp -> 127.0.0.1:54590
33a1aa3734f0   el-2-geth-lighthouse                             engine-rpc: 8551/tcp -> 127.0.0.1:54595       RUNNING
                                                                metrics: 9001/tcp -> 127.0.0.1:54596
                                                                rpc: 8545/tcp -> http://127.0.0.1:54598
                                                                tcp-discovery: 30303/tcp -> 127.0.0.1:54597
                                                                udp-discovery: 30303/udp -> 127.0.0.1:61026
                                                                ws: 8546/tcp -> 127.0.0.1:54599
22ec7e014303   el-3-geth-teku                                   engine-rpc: 8551/tcp -> 127.0.0.1:54602       RUNNING
                                                                metrics: 9001/tcp -> 127.0.0.1:54603
                                                                rpc: 8545/tcp -> http://127.0.0.1:54600
                                                                tcp-discovery: 30303/tcp -> 127.0.0.1:54604
                                                                udp-discovery: 30303/udp -> 127.0.0.1:60590
                                                                ws: 8546/tcp -> 127.0.0.1:54601
c4655f3e76da   validator-key-generation-cl-validator-keystore   <none>                                        RUNNING
349a3759d6c8   vc-1-geth-lighthouse                             metrics: 8080/tcp -> http://127.0.0.1:54621   RUNNING
deed7eacfd93   vc-2-geth-lighthouse                             metrics: 8080/tcp -> http://127.0.0.1:54623   RUNNING
```

就这样。Kurtosis 已启动了配置中指定的所有网络组件，这些组件位于一个安全区中。需要使用安全区的名称（例如，上述运行中为 `dusty-soil`）才能与服务进行交互。现在，网络应该已经开始生成和验证新区块了。为了深入了解每个客户端，可以查看日志。
```s
> kurtosis service logs dusty-soil el-1-geth-lighthouse

[el-1-geth-lighthouse] INFO [06-04|07:59:05.048] Chain head was updated                   number=495 hash=2f3200..673eee root=d3d92f..d3bd27 elapsed=3.429333ms
[el-1-geth-lighthouse] INFO [06-04|07:59:13.008] Starting work on payload                 id=0x03c53477e90934c9
[el-1-geth-lighthouse] INFO [06-04|07:59:13.008] Updated payload                          id=0x03c53477e90934c9 number=496 hash=e995db..f5310d txs=0 withdrawals=0 gas=0 fees=0 root=36638a..e3c9a9 elapsed="379.542µs"
[el-1-geth-lighthouse] INFO [06-04|07:59:17.007] Stopping work on payload                 id=0x03c53477e90934c9 reason=delivery
[el-1-geth-lighthouse] INFO [06-04|07:59:17.041] Imported new potential chain segment     number=496 hash=e995db..f5310d blocks=1 txs=0 mgas=0.000 elapsed=20.254ms     mgasps=0.000 snapdiffs=98.81KiB triediffs=454.03KiB triedirty=79.69KiB
[el-1-geth-lighthouse] INFO [06-04|07:59:17.047] Chain head was updated    
```

#### 区块浏览器

您可能已经注意到，上面的配置中请求了一个名为 dora 的附加服务。[Dora](https://github.com/ethpandaops/dora) 是一个轻量级区块浏览器。上面的 kurtosis 日志表明 dora 已成功启动为一项服务，并且可以通过 `http://127.0.0.1:54628` 访问以查看区块链。

#### 与 geth 交互

与任何 geth 节点交互最直接的方式是通过 JSON-RPC。这些节点已启动，RPC 服务器正在运行，并且 kurtosis 已将这些端口暴露给主机，如日志所示。例如，可以通过 `http://127.0.0.1:54589` 访问第一个 geth 节点。因此，可以通过以下方式获取当前区块编号:
```s
  > curl -X POST -H "Content-Type: application/json" --data '{"method":"eth_blockNumber","params":[],"id":1,"jsonrpc":"2.0"}' http://127.0.0.1:54589

  {"jsonrpc":"2.0","id":1,"result":"0x332"}
```

最终，Kurtosis 服务是 Docker 镜像。也可以通过 Shell 访问它们并进行操作，例如加载控制台。Kurtosis 通过以下命令实现 Shell 访问:
```s
> kurtosis service shell dusty-soil el-1-geth-lighthouse
No bash found on container; dropping down to sh shell...
/ # geth --datadir /data/geth/execution-data/ attach
Welcome to the Geth JavaScript console!

instance: Geth/v1.14.4-unstable-a6751d6f/linux-arm64/go1.22.3
at block: 830 (Tue Jun 04 2024 09:07:29 GMT+0000 (UTC))
 datadir: /data/geth/execution-data
  modules: admin:1.0 debug:1.0 engine:1.0 eth:1.0 miner:1.0 net:1.0 rpc:1.0 txpool:1.0 web3:1.0

  To exit, press ctrl-d or type exit
  >
```

### 更多了解

本教程介绍了使用 Kurtosis 启动网络的基础知识。ethereum-package 的功能和选项远超本教程的范围。ethPandaOps 的[指南](https://ethpandaops.io/posts/kurtosis-deep-dive/)还涵盖了更高级的功能，例如部署 MEV 协议栈、影子分叉等。
