
主要参考:
- [Getting started with Geth](https://geth.ethereum.org/docs/getting-started)
- [Introduction to Clef](https://geth.ethereum.org/docs/tools/clef/introduction)

其他参考:
- [google faucet for ethereum](https://cloud.google.com/application/web3/faucet/ethereum/sepolia)
- [sepolia etherscan](https://sepolia.etherscan.io/)

本教程将指导用户创建账户、向账户充值以太币以及将部分以太币发送到另一个地址。

### 步骤1: 创建账户

在 Geth 中生成账户的方法有很多种。本教程演示如何使用 Clef 生成账户，这被认为是最佳实践，主要是因为它将用户的密钥管理与 Geth 分离，使其更加模块化和灵活。它也可以通过安全的 U 盘或虚拟机运行，从而提供更高的安全性。为了方便起见，本教程将在运行 Geth 的同一台计算机上执行 Clef，尽管也有更安全的选项（请参阅[此处](https://geth.ethereum.org/docs/tools/clef/setup)）。

一个帐户是一对密钥(公钥和私钥)。Clef 需要知道将这些密钥保存在哪里，以便以后可以检索它们。此信息作为参数传递给 Clef。这可以通过以下命令实现:
```s
  clef newaccount --keystore ~/geth-home/keystore
```
Clef 中用于生成新账户的特定功能是 newaccount，它接受一个参数 `--keystore`，用于指定新生成的密钥的存储位置。

本例中 Clef 将在终端中返回以下结果:
```s
WARNING!

Clef is an account management tool. It may, like any software, contain bugs.

Please take care to
- backup your keystore files,
- verify that the keystore(s) can be opened with your password.

Clef is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
PURPOSE. See the GNU General Public License for more details.

Enter 'ok' to proceed:
> 
```

这是重要信息。~/geth-home/keystore 目录很快会包含一个密钥，可用于访问新账户中的任何资金。如果密钥被盗，资金可能会被盗。如果密钥丢失，则无法找回资金。本教程仅使用没有实际价值的虚拟资金，但在以太坊主网上重复这些步骤时，确保密钥库的安全并进行备份至关重要。

在终端中输入 ok 并按回车键，Clef 会提示输入密码。Clef 要求密码长度至少为 10 个字符，最佳做法是使用数字、字符和特殊字符的组合。输入合适的密码并按回车键，终端将返回以下结果:
```s
...
## New account password

Please enter a password for the new account to be created (attempt 1 of 3)
> 
-----------------------
INFO [10-23|14:46:46.856] Your new key was generated               address=0x96Dc2fba6fAaAb9a83FEDEF83E9f0da074330eBe
WARN [10-23|14:46:46.856] Please backup your key file!             path=/home/tester/geth-home/keystore/UTC--2025-10-23T06-46-44.948694828Z--96dc2fba6faaab9a83fedef83e9f0da074330ebe
WARN [10-23|14:46:46.856] Please remember your password!
Generated account 0x96Dc2fba6fAaAb9a83FEDEF83E9f0da074330eBe
```

将账户地址和密码保存在安全的地方非常重要。本教程后面会再次用到它们。请注意，以上代码片段和后续教程中显示的账户地址仅为示例，后续教程的学习者生成的账户地址可能有所不同。以上生成的账户可在本教程的剩余部分用作主账户。但是，为了演示账户之间的交易，还需要第二个账户。只需重复上述步骤并提供相同的密码，即可将第二个账户添加到同一个密钥库。
```s
## New account password

Please enter a password for the new account to be created (attempt 0 of 3)
> 
-----------------------
INFO [10-23|16:19:59.573] Your new key was generated               address=0x91Bd437a198BDec2c9FE44E4d8e1903B2ccAd897
WARN [10-23|16:19:59.573] Please backup your key file!             path=/home/tester/geth-home/keystore/UTC--2025-10-23T08-19-57.612719530Z--91bd437a198bdec2c9fe44e4d8e1903b2ccad897
WARN [10-23|16:19:59.573] Please remember your password!
Generated account 0x91Bd437a198BDec2c9FE44E4d8e1903B2ccAd897
```

### 步骤2: 启动 Clef

前面的命令使用 Clef 的 newaccount 功能将新的密钥对添加到密钥库中。Clef 使用密钥库中保存的私钥对交易进行签名。为此，Clef 需要在 Geth 运行时启动并保持运行，以便两个程序能够相互通信。

要启动 Clef，需要运行 `clef` 可执行文件，并将密钥库文件位置、配置目录位置和链 ID 作为参数传递。配置目录默认位于`~/.clef`下。链 ID 是一个整数，用于定义要连接到哪个以太坊网络。以太坊主网的链 ID 为 1。在本教程中，我们使用的链 ID 为 11155111，即 Sepolia 测试网的链 ID。务必将此链 ID 参数设置为 11155111——Clef 使用链 ID 对消息进行签名，因此必须确保其正确无误。以下命令将在 Sepolia 上启动 Clef:
```s
  clef --keystore ~/geth-home/keystore --configdir ~/.clef --chainid 11155111
```
运行上述命令后，Clef 会要求用户输入"ok"才能继续。输入"ok"并按下回车键后，Clef 会在终端返回以下内容:
```s
INFO [10-23|15:43:00.830] Using CLI as UI-channel
INFO [10-23|15:43:01.132] Loaded 4byte database                    embeds=268,621 locals=0 local=./4byte-custom.json
## Master Password

Please enter the password to decrypt the master seed
> 
-----------------------
INFO [10-23|15:43:20.940] Starting signer                          chainid=11,155,111 keystore=/home/tester/geth-home/keystore light-kdf=false advanced=false
WARN [10-23|15:43:20.943] Failed to start Ledger hub, disabling: unsupported platform
WARN [10-23|15:43:20.943] Failed to start HID Trezor hub, disabling: unsupported platform
WARN [10-23|15:43:20.943] Failed to start WebUSB Trezor hub, disabling: unsupported platform
INFO [10-23|15:43:20.943] Smartcard socket file missing, disabling err="stat /run/pcscd/pcscd.comm: no such file or directory"
INFO [10-23|15:43:20.943] Audit logs configured                    file=audit.log
INFO [10-23|15:43:20.945] IPC endpoint opened                      url=/home/tester/.clef/clef.ipc

------- Signer info -------
* intapi_version : 7.0.1
* extapi_version : 6.1.0
* extapi_http : n/a
* extapi_ipc : /home/tester/.clef/clef.ipc

------- Available accounts -------
0. 0x96Dc2fba6fAaAb9a83FEDEF83E9f0da074330eBe at keystore:///home/tester/geth-home/keystore/UTC--2025-10-23T06-46-44.948694828Z--96dc2fba6faaab9a83fedef83e9f0da074330ebe
```

此结果表明 Clef 正在运行。在本教程期间，此终端应保持运行。如果教程停止并稍后重新启动，也必须通过运行上面的命令来重新启动 Clef。

### 步骤3: 启动 Geth

Geth 是以太坊客户端，它将计算机连接到以太坊网络。本教程中使用的网络是 Sepolia，一个以太坊测试网。测试网用于在不存在任何实际价值风险的环境中测试以太坊客户端软件和智能合约。要启动 Geth，需要运行 `geth` 可执行文件，并传递参数，该参数定义了数据目录(Geth 需要在其中保存区块链数据）、签名者(将 Geth 指向 Clef)、网络 ID 和同步模式。本教程建议使用 Snap 同步(原因请参见[此处](https://blog.ethereum.org/2021/03/03/geth-v1-10-0)）。传递给 Geth 的最后一个参数是 `--http` 标志。这将启用 http-rpc 服务器，允许外部程序通过向 Geth 发送 http 请求与 Geth 交互。默认情况下，http 服务器仅使用 8545 端口在本地公开: `localhost:8545`。还需要使用 `--authrpc` 为共识客户端授权部分流量，并使用 `--jwt-secret` 在已知位置设置 JWT 密钥令牌。

在新终端中运行如下命令，与运行 Clef 的终端分开:
```s
  cd ~
  geth --sepolia --datadir geth-home --authrpc.addr localhost --authrpc.port 8551 --authrpc.vhosts localhost --authrpc.jwtsecret geth-home/jwtsecret --http --http.api eth,net --signer=.clef/clef.ipc --http
```
运行上述命令即可启动 Geth。除非存在一个共识客户端，该客户端能够向 Geth 传递有效的同步头，否则 Geth 将无法正确同步区块链。在另一个终端中启动一个共识客户端。一旦共识客户端同步成功，Geth 也会开始同步。

终端应该会快速显示类似于以下状态更新。要查看日志的含义，请参阅[日志页面](https://geth.ethereum.org/docs/fundamentals/logs)。
```s
INFO [10-23|15:59:00.887] Starting Geth on Sepolia testnet...
INFO [10-23|15:59:00.889] Maximum peer count                       ETH=50 total=50
INFO [10-23|15:59:00.890] Smartcard socket not found, disabling    err="stat /run/pcscd/pcscd.comm: no such file or directory"
INFO [10-23|15:59:00.891] Using external signer                    url=.clef/clef.ipc
INFO [10-23|15:59:00.897] Set global gas cap                       cap=50,000,000
INFO [10-23|15:59:00.898] Initializing the KZG library             backend=gokzg
INFO [10-23|15:59:00.903] Allocated trie memory caches             clean=154.00MiB dirty=256.00MiB
INFO [10-23|15:59:00.904] Defaulting to pebble as the backing database
INFO [10-23|15:59:00.904] Allocated cache and file handles         database=/home/tester/geth-home/geth/chaindata cache=512.00MiB handles=524,288
INFO [10-23|15:59:01.093] Opened ancient database                  database=/home/tester/geth-home/geth/chaindata/ancient/chain readonly=false
INFO [10-23|15:59:01.093] Opened Era store                         datadir=/home/tester/geth-home/geth/chaindata/ancient/chain/era
INFO [10-23|15:59:01.094] State schema set to default              scheme=path
WARN [10-23|15:59:01.094] Head block is not reachable
INFO [10-23|15:59:01.095] Initialising Ethereum protocol           network=11,155,111 dbversion=<nil>
INFO [10-23|15:59:01.096] Load database journal from disk
INFO [10-23|15:59:01.194] Opened ancient database                  database=/home/tester/geth-home/geth/chaindata/ancient/state readonly=false
INFO [10-23|15:59:01.194] State snapshot generator is not found
INFO [10-23|15:59:01.194] Starting snapshot generation             root=56e81f..63b421 accounts=0 slots=0 storage=0.00B dangling=0 elapsed="14.086µs"
INFO [10-23|15:59:01.194] Initialized path database                triecache=154.00MiB statecache=102.00MiB buffer=256.00MiB state-history="last 90000 blocks" journal-dir=/home/tester/geth-home/geth/triedb
INFO [10-23|15:59:01.194] Writing custom genesis block
INFO [10-23|15:59:01.195] Resuming snapshot generation             root=56e81f..63b421 accounts=0 slots=0 storage=0.00B dangling=0 elapsed="849.52µs"
INFO [10-23|15:59:01.195] Generated snapshot                       accounts=0 slots=0 storage=0.00B dangling=0 elapsed=1.022ms
INFO [10-23|15:59:01.196] 
INFO [10-23|15:59:01.196] ---------------------------------------------------------------------------------------------------------------------------------------------------------
INFO [10-23|15:59:01.196] Chain ID:  11155111 (sepolia)
INFO [10-23|15:59:01.196] Consensus: Beacon (proof-of-stake), merged from Ethash (proof-of-work)
INFO [10-23|15:59:01.196] 
INFO [10-23|15:59:01.196] Pre-Merge hard forks (block based):
INFO [10-23|15:59:01.196]  - Homestead:                   #0       
INFO [10-23|15:59:01.196]  - Tangerine Whistle (EIP 150): #0       
INFO [10-23|15:59:01.196]  - Spurious Dragon/1 (EIP 155): #0       
INFO [10-23|15:59:01.196]  - Spurious Dragon/2 (EIP 158): #0       
INFO [10-23|15:59:01.196]  - Byzantium:                   #0       
INFO [10-23|15:59:01.196]  - Constantinople:              #0       
INFO [10-23|15:59:01.196]  - Petersburg:                  #0       
INFO [10-23|15:59:01.196]  - Istanbul:                    #0       
INFO [10-23|15:59:01.196]  - Muir Glacier:                #0       
INFO [10-23|15:59:01.196]  - Berlin:                      #0       
INFO [10-23|15:59:01.196]  - London:                      #0       
INFO [10-23|15:59:01.196] 
INFO [10-23|15:59:01.196] Merge configured:
INFO [10-23|15:59:01.196]  - Total terminal difficulty:  17000000000000000
INFO [10-23|15:59:01.196]  - Merge netsplit block:       #1735371 
INFO [10-23|15:59:01.196] 
INFO [10-23|15:59:01.196] Post-Merge hard forks (timestamp based):
INFO [10-23|15:59:01.196]  - Shanghai:                    @1677557088
INFO [10-23|15:59:01.196]  - Cancun:                      @1706655072 blob: (target: 3, max: 6, fraction: 3338477)
INFO [10-23|15:59:01.196]  - Prague:                      @1741159776 blob: (target: 6, max: 9, fraction: 5007716)
INFO [10-23|15:59:01.196]  - Osaka:                       @1760427360 blob: (target: 6, max: 9, fraction: 5007716)
INFO [10-23|15:59:01.196]  - BPO1:                        @1761017184 blob: (target: 10, max: 15, fraction: 8346193)
INFO [10-23|15:59:01.196]  - BPO2:                        @1761607008 blob: (target: 14, max: 21, fraction: 11684671)
INFO [10-23|15:59:01.196] 
INFO [10-23|15:59:01.196] All fork specifications can be found at https://ethereum.github.io/execution-specs/src/ethereum/forks/
INFO [10-23|15:59:01.196] 
INFO [10-23|15:59:01.196] ---------------------------------------------------------------------------------------------------------------------------------------------------------
INFO [10-23|15:59:01.196] 
INFO [10-23|15:59:01.198] Loaded most recent local block           number=0 hash=25a5cc..3e6dd9 age=4y1mo1w
INFO [10-23|15:59:01.199] Initialized transaction indexer          range="last 2350000 blocks"
INFO [10-23|15:59:02.251] Enabled snap sync                        head=0 hash=25a5cc..3e6dd9
INFO [10-23|15:59:02.252] Gasprice oracle is ignoring threshold set threshold=2
INFO [10-23|15:59:02.252] Registered sync override service
INFO [10-23|15:59:02.253] Starting peer-to-peer node               instance=Geth/v1.16.5-stable-737ffd1b/linux-amd64/go1.25.1
INFO [10-23|15:59:02.285] New local node record                    seq=1,761,206,342,284 id=97c69ef22e0cccb9 ip=127.0.0.1 udp=30303 tcp=30303
INFO [10-23|15:59:02.287] Started P2P networking                   self=enode://0826ce5ba37d050daaf87c6be8fa03bf95162d9c615dc302ca6b5446e545058e77a4d69ca53fa6dc58cd3b3713ca401869413e53aa5ad222a7bd1a749b527484@127.0.0.1:30303
INFO [10-23|15:59:02.288] IPC endpoint opened                      url=/home/tester/geth-home/geth.ipc
INFO [10-23|15:59:02.288] Generated JWT secret                     path=geth-home/jwtsecret
INFO [10-23|15:59:02.288] HTTP server started                      endpoint=127.0.0.1:8545 auth=false prefix= cors= vhosts=localhost
INFO [10-23|15:59:02.289] WebSocket enabled                        url=ws://127.0.0.1:8551
INFO [10-23|15:59:02.289] HTTP server started                      endpoint=127.0.0.1:8551 auth=true  prefix= cors=localhost vhosts=localhost
INFO [10-23|15:59:02.290] Started log indexer
WARN [10-23|15:59:02.291] Failed to open wallet                    url=extapi://.clef/clef.ipc         err="operation not supported on external signers"
INFO [10-23|15:59:03.418] New local node record                    seq=1,761,206,342,285 id=97c69ef22e0cccb9 ip=183.193.34.23 udp=4277  tcp=30303
WARN [10-23|15:59:37.255] Beacon client online, but no consensus updates received in a while. Please fix your beacon client to follow the chain!
INFO [10-23|16:01:15.308] New local node record                    seq=1,761,206,342,286 id=97c69ef22e0cccb9 ip=183.193.34.23 udp=4582  tcp=30303
```

默认情况下，Geth 使用 snap-sync 机制，它会从相对较新的区块(而非创世区块)开始顺序下载区块。数据保存在 `~/geth-home/geth/chaindata/` 的文件中。验证完区块头的顺序后，Geth 会下载区块主体和状态数据，然后启动"状态修复"阶段，以更新新到达数据的状态。终端上打印的日志可以确认这一点。终端中应该会显示一个快速增长的日志序列，其语法如下(当前测试未出现):
```s
INFO [04-29][15:54:09.238] Looking for peers             peercount=2 tried=0 static=0
INFO [04-29][15:54:19.393] Imported new block headers    count=2 elapsed=1.127ms  number=996288  hash=09f1e3..718c47 age=13h9m5s
INFO [04-29][15:54:19:656] Imported new block receipts   count=698  elapsed=4.464ms number=994566 hash=56dc44..007c93 age=13h9m9s
```
此消息将定期显示，直到状态修复完成(当前测试未出现):
```s
INFO [10-20|20:20:09.510] State heal in progress                   accounts=313,309@17.95MiB slots=363,525@28.77MiB codes=7222@50.73MiB nodes=49,616,912@12.67GiB pending=29805
```
状态修复完成后，节点即同步完毕，可供使用。

向 http 服务器发送一个空的 curl 请求可以快速确认该节点也已启动且没有任何问题。另开一个终端，运行以下命令:
```s
  curl http://localhost:8545
```
如果终端没有报告任何错误消息，则一切正常。Geth 必须正在运行并同步，用户才能与以太坊网络交互。如果运行 Geth 的终端关闭，则必须在新的终端中重新启动 Geth。Geth 可以轻松启动和停止，但必须运行才能与以太坊进行任何交互。要关闭 Geth，只需在 Geth 终端中按下 CTRL+C。要重新启动，请运行之前的命令 `geth --datadir <其他命令>`。

### 步骤4: 获取测试网络以太币

为了进行某些交易，用户必须使用以太币为其账户充值。在以太坊主网上，以太币的获取方式只有三种: 1）作为挖矿/验证的奖励; 2）从其他以太坊用户或合约转账; 3）使用法定货币支付，从交易所接收。在以太坊测试网上，以太币没有现实世界的价值，因此 4）可以通过水龙头(faucets)免费获取。水龙头允许用户请求将测试网以太币转入其账户。

Clef 在步骤 1 中生成的地址可以粘贴到 [Paradigm Multifaucet 水龙头](https://faucet.sepolia.dev)中。水龙头会将 Sepolia ETH（并非真实 ETH）添加到指定地址。在接下来的步骤中，Geth 将用于检查以太币是否已发送到指定地址，并将其中的一部分发送到之前创建的第二个地址。

实际测试时，笔者打不开上面的充入页面。这里找到[另一个页面](https://cloud.google.com/application/web3/faucet/ethereum/sepolia)完成 ETH 充入(注意，需要登录账号之后才能操作)。

将上面的第一个账户地址(0x96Dc2fba6fAaAb9a83FEDEF83E9f0da074330eBe)粘贴到方框中:

![](img/sepolia-faucet-eth-begin.png)

点击`Receive 0.05 Sepolia ETH`按钮，可以看到如下页面，提示我们正在操作:

![](img/sepolia-faucet-eth-ing.png)

稍等一会后，会显示如下页面，提示我们充入成功:

![](img/sepolia-faucet-eth-end.png)

我们可以通过浏览器进入如下[页面](https://sepolia.etherscan.io/)查询这笔充入:

![](img/sepolia-testnet-etherscan-mainpage.png)

同样将上面的账户地址粘贴到搜索栏中，点击搜索，就可以看到这笔充入了:

![](img/sepolia-testnet-etherscan-searchpage.png)

那如何在本地查看合约账户的 ETH 呢，可以参考接下来的步骤5。

### 步骤5: 与 Geth 交互

为了与区块链交互，Geth 提供了 JSON-RPC API。JSON-RPC 是一种通过以 JSON 对象的形式向 Geth 发送指令来执行特定任务的方法。RPC 代表"远程过程调用"，指的是能够从 Geth 管理范围之外的位置发送这些 JSON 编码指令。可以使用 Curl 等工具直接通过 Geth 公开的 http 端口发送这些 JSON 编码指令来与 Geth 交互。然而，这种方式不太友好，而且容易出错，尤其是在处理更复杂的指令时。因此，有一系列基于 JSON-RPC 构建的库，为与 Geth 的交互提供了更友好的用户界面。其中最广泛使用的库是 `Web3.js`。

Geth 提供了一个 JavaScript 控制台，它公开了 Web3.js API。这意味着，当 Geth 在一个终端中运行时，可以在另一个终端中打开 JavaScript 环境，从而允许用户使用 Web3.js 与 Geth 交互。有三种传输协议可用于将 JavaScript 环境连接到 Geth:
- IPC(进程间通信): 提供对所有 API 的无限制访问，但仅当控制台与 Geth 节点在同一主机上运行时才有效。
- HTTP: 默认提供对 eth、web3 和 net 方法命名空间的访问。
- Websocket: 默认提供对 eth、web3 和 net 方法命名空间的访问。

本教程将使用 HTTP 选项。请注意，运行 Geth 和 Clef 的终端都应该处于活动状态。在新的(第三个)终端中，可以运行以下命令来启动控制台并使用公开的 http 端口将其连接到 Geth:
```s
  geth attach http://127.0.0.1:8545
```

此命令会导致终端挂起，因为它正在等待 Clef 的批准。在运行 Clef 的终端中批准请求将导致 Javascript 控制台中显示以下欢迎消息:
```s
Welcome to the Geth JavaScript console!

 modules: eth:1.0 net:1.0 rpc:1.0

To exit, press ctrl-d or type exit
> 
```
控制台现已激活并连接到 Geth。现在可以用来与以太坊(Sepolia)网络进行交互。

#### 列表账户

在本教程中，帐户使用 Clef 进行管理。这意味着请求有关帐户的信息需要在 Clef 中明确批准，而 Clef 应该仍在其自己的终端中运行。在本教程的前面部分，我们使用 Clef 创建了两个帐户。以下命令将显示这两个帐户的地址，以及在此之前或之后可能已添加到密钥库的任何其他帐户的地址。
```js
  eth.accounts;
```
控制台将挂起，因为 Clef 正在等待批准。Clef 终端将显示以下消息:
```s
-------- List Account request--------------
A request has been made to list all accounts. 
You can select which accounts the caller can see
  [x] 0x96Dc2fba6fAaAb9a83FEDEF83E9f0da074330eBe
    URL: keystore:///home/tester/geth-home/keystore/UTC--2025-10-23T06-46-44.948694828Z--96dc2fba6faaab9a83fedef83e9f0da074330ebe
  [x] 0x91Bd437a198BDec2c9FE44E4d8e1903B2ccAd897
    URL: keystore:///home/tester/geth-home/keystore/UTC--2025-10-23T08-19-57.612719530Z--91bd437a198bdec2c9fe44e4d8e1903b2ccad897
-------------------------------------------
Request context:
	NA -> ipc -> NA

Additional HTTP header data, provided by the external caller:
	User-Agent: ""
	Origin: ""
Approve? [y/N]:
```
输入 y 表示从控制台批准请求。在运行 Javascript 控制台的终端中，现在显示帐户地址:
```s
  ["0x96dc2fba6faaab9a83fedef83e9f0da074330ebe", "0x91bd437a198bdec2c9fe44e4d8e1903b2ccad897"]
```

如果 Clef 审批时间过长，此请求也可能会超时——在这种情况下，只需重新提交请求并审批即可。您也可以通过打开新终端并运行 `clef list-accounts --keystore <path-to-keystore>` 直接从 Clef 列出帐户。

#### 检查账户余额

确认先前创建的两个地址确实存在于密钥库中，并且可以通过 JavaScript 控制台访问后，就可以检索它们拥有的以太币数量信息了。Sepolia 水龙头应该已经向提供的地址发送了 0.05 个以太币，这意味着其中一个账户的余额至少为 0.05 个以太币，另一个账户的余额为 0。还有其他水龙头可用，每次请求可以分配更多以太币，也可以多次请求以累积更多以太币。以下命令在控制台中显示账户余额:
```s
  web3.fromWei(eth.getBalance('0x96dc2fba6faaab9a83fedef83e9f0da074330ebe'));
  web3.fromWei(eth.getBalance('0x96Dc2fba6fAaAb9a83FEDEF83E9f0da074330eBe'), 'ether');
  web3.fromWei(eth.getBalance('0x91Bd437a198BDec2c9FE44E4d8e1903B2ccAd897'));
  web3.fromWei(eth.getBalance('0x91Bd437a198BDec2c9FE44E4d8e1903B2ccAd897'), 'ether');
```

上述命令实际上发送了两条指令。最内侧的一条是来自 eth 命名空间的 getBalance 函数。该函数将账户地址作为唯一参数。默认情况下，该函数以 Wei 为单位返回账户余额。1 ETH 对应 1018 Wei。为了以 ETH 为单位显示结果，getBalance 被封装在来自 web3 命名空间的 fromWei 函数中。假设账户余额为 1 ETH，运行此命令应返回以下结果:
```s
  1
```

对另一个（空）帐户重复该命令应该会产生以下结果:
```s
  0
```