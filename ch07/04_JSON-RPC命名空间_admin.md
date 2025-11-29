
主要参考:
- [admin Namespace](https://geth.ethereum.org/docs/interacting-with-geth/rpc/ns-admin)

更新于 2024/08/02。

`admin` API 提供了对几个非标准 RPC 方法的访问，从而可以对 Geth 实例进行细粒度的控制，包括但不限于网络对等体和 RPC 端点管理。

### admin_addPeer

`addPeer` 管理方法请求将一个新的远程节点添加到已跟踪的静态节点列表中。该节点将尝试始终保持与这些节点的连接，并在远程连接断开时偶尔重新连接。

该方法接受一个参数，即用于开始跟踪的远程对等节点的 [enode](https://ethereum.org/developers/docs/networking-layer/network-addresses/#enode) URL，并返回一个 BOOL 值，指示该对等节点是否已被接受跟踪或是否发生了某些错误。

| 客户端 | 方法调用 |
|:------|:--------|
| Go    | admin.AddPeer(url string) (bool, error) |
|Console| admin.addPeer(url) |
| RPC   | {"method": "admin_addPeer", "params": [url]} |

示例:
```js
> admin.addPeer("enode://a979fb575495b8d6db44f750317d0f4622bf4c2aa3365d6af7c284339968eef29b69ad0dce72a4d8db5ebb4968de0e3bec910127f134779fbcb0cb6d3331163c@52.16.188.185:30303")
true
```

### admin_addTrustedPeer

将指定的节点添加到预留的可信列表中，即使槽位已满，该节点也能始终保持连接。此操作返回一个布尔值，指示对等节点是否已成功添加到列表中。

| 客户端 | 方法调用 |
|:------|:--------|
| Go    | admin.addTrustedPeer(url) |
|Console| {"method": "admin_addTrustedPeer", "params": [url]} |

### admin_datadir

可以查询 `datadir` 管理属性以获取正在运行的 Geth 节点当前用于存储其所有数据库的绝对路径。

| 客户端 | 方法调用 |
|:------|:--------|
| Go    | admin.Datadir() (string, error) |
|Console| admin.datadir |
| RPC   | {"method": "admin_datadir"} |

示例:
```js
> admin.datadir
"/home/john/.ethereum"
```

### admin_exportChain

将当前区块链导出到本地文件。它可以选择性地接受起始区块号和结束区块号，在这种情况下，它只会导出指定范围的区块。它返回一个布尔值，指示操作是否成功。

| 客户端 | 方法调用 |
|:------|:--------|
|Console| admin.exportChain(file, first, last) |
| RPC   | {"method": "admin_exportChain", "params": [string, uint64, uint64]} |

### admin_importChain

从本地文件导入导出的数据块列表。导入过程包括处理数据块并将其插入规范链。此操作需要指定该范围父数据块的状态。它返回一个布尔值，指示操作是否成功。

| 客户端 | 方法调用 |
|:------|:--------|
|Console| admin.importChain(file) |
| RPC   | {"method": "admin_importChain", "params": [string]} |

### admin_nodeInfo

可以通过查询 `nodeInfo` 管理属性来获取有关正在运行的 Geth 节点在网络粒度上的所有已知信息。这些信息包括节点本身作为 [ÐΞVp2p](https://github.com/ethereum/devp2p/blob/master/caps/eth.md) P2P 覆盖协议参与者的一般信息，以及每个正在运行的应用程序协议（例如 `eth`、`les`、`shh`、`bzz`）添加的专用信息。

| 客户端 | 方法调用 |
|:------|:--------|
| Go    | admin.NodeInfo() (*p2p.NodeInfo, error) |
|Console| admin.nodeInfo |
| RPC   | {"method": "admin_nodeInfo"} |

示例:
```js
> admin.nodeInfo
{
  enode: "enode://3d876252880e32116fdb52ea56a78ee2b9789e55b4413de910db69702ce93a7ff9a0b7c647a010a5e1e079c0aca146331083009644e12dc03510b9de9f50b9ef@156.146.56.131:30303?discport=39261",
  enr: "enr:-K64QL0-CI9BofDkirpulbV1OOOgqf5HLRMHr9iaziZInqI9HmeGOGZv2hs6J7olLu32LUMeYHTCjNBu3De_zlkI1fSGAY_h5ivyg2V0aMrJhPxk7ASDEYwwgmlkgnY0gmlwhJySOIOJc2VjcDI1NmsxoQM9h2JSiA4yEW_bUupWp47iuXieVbRBPekQ22lwLOk6f4RzbmFwwIN0Y3CCdl-DdWRwgpldhHVkcDaCdl8",
  id: "b7b61ea54ad081258a13a6d82920ce6719301f4670c458f64f0035e3463ec2df",
  ip: "156.146.56.131",
  listenAddr: "[::]:30303",
  name: "Geth/v1.14.4-unstable-51327686/linux-arm64/go1.22.3",
  ports: {
    discovery: 39261,
    listener: 30303
  },
  protocols: {
    eth: {
      config: {
        arrowGlacierBlock: 13773000,
        berlinBlock: 12244000,
        byzantiumBlock: 4370000,
        cancunTime: 1710338135,
        chainId: 1,
        constantinopleBlock: 7280000,
        daoForkBlock: 1920000,
        daoForkSupport: true,
        eip150Block: 2463000,
        eip155Block: 2675000,
        eip158Block: 2675000,
        ethash: {},
        grayGlacierBlock: 15050000,
        homesteadBlock: 1150000,
        istanbulBlock: 9069000,
        londonBlock: 12965000,
        muirGlacierBlock: 9200000,
        petersburgBlock: 7280000,
        shanghaiTime: 1681338455,
        terminalTotalDifficulty: 5.875e+22,
        terminalTotalDifficultyPassed: true
      },
      difficulty: 17179869184,
      genesis: "0xd4e56740f876aef8c010b86a40d5f56745a118d0906a34e69aec8c0db1cb8fa3",
      head: "0xd4e56740f876aef8c010b86a40d5f56745a118d0906a34e69aec8c0db1cb8fa3",
      network: 1
    },
    snap: {}
  }
}
```

### admin_peerEvents

PeerEvents 创建一个 [RPC 订阅](https://geth.ethereum.org/docs/interacting-with-geth/rpc/pubsub)，用于接收来自节点 P2P 服务器的对等事件。服务器发出的事件类型如下:
- `add`: 当添加对等节点时发出
- `drop`: 当删除对等节点时发出
- `msgsend`:当成功向对等节点发送消息时发出
- `msgrecv`: 当从对等节点接收到消息时发出

### admin_peers

可以查询对等节点 peers 的管理属性，以获取有关已连接远程节点在网络粒度上的所有已知信息。这些信息包括作为 [ÐΞVp2p](https://github.com/ethereum/devp2p/blob/master/caps/eth.md) P2P 覆盖协议参与者的节点自身的一般信息，以及每个正在运行的应用程序协议（例如 `eth`、`les`、`shh`、`bzz`）添加的专用信息。

| 客户端 | 方法调用 |
|:------|:--------|
| Go    | admin.Peers() ([]*p2p.PeerInfo, error) |
|Console| admin.peers | 
| RPC   | {"method": "admin_peers"} |

示例:
```js
> admin.peers
[{
    caps: ["eth/68", "snap/1"],
    enode: "enode://4aeb4ab6c14b23e2c4cfdce879c04b0748a20d8e9b59e25ded2a08143e265c6c25936e74cbc8e641e3312ca288673d91f2f93f8e277de3cfa444ecdaaf982052@157.90.35.166:30303",
    id: "6b36f791352f15eb3ec4f67787074ab8ad9d487e37c4401d383f0561a0a20507",
    name: "Geth/v1.13.14-stable-2bd6bd01/linux-amd64/go1.21.7",
    network: {
      inbound: false,
      localAddress: "172.17.0.2:33666",
      remoteAddress: "157.90.35.166:30303",
      static: false,
      trusted: false
    },
    protocols: {
      eth: {
        version: 68
      },
      snap: {
        version: 1
      }
    }
}, /* ... */ {
    caps: ["eth/66", "eth/67", "eth/68", "snap/1"],
    enode: "enode://404786d90feafd54abcbcb7a7c791b6197304e58f7f582715312372af7297f194baf4abb6ce1cc5c55050e8111194d500590d0e08fcd75ce575f8fdd2e090af0@34.241.148.206:30303",
    id: "8a2a75da0f099ee3d1dcfad4a4825c81b5ab1cb3c18207e7626abae87ce589b1",
    name: "Geth/v1.11.6-stable-ea9e62ca/linux-amd64/go1.20.3",
    network: {
      inbound: false,
      localAddress: "172.17.0.2:59938",
      remoteAddress: "34.241.148.206:30303",
      static: false,
      trusted: false
    },
    protocols: {
      eth: {
        version: 68
      },
      snap: {
        version: 1
      }
    }
}]
```

### admin_removePeer

如果连接存在，则断开与远程节点的连接。它返回一个布尔值，指示验证是否成功。请注意，true 并不一定意味着曾经存在连接，但连接已被断开。

| 客户端 | 方法调用 |
|:------|:--------|
|Console| admin.removePeer(url) |
|  RPC	| {"method": "admin_removePeer", "params": [string]} |

### admin_removeTrustedPeer

从受信任对等节点集中移除远程节点，但不会自动断开其连接。此操作会返回一个布尔值，指示验证是否成功。

| 客户端 | 方法调用 |
|:------|:--------|
|Console| admin.removeTrustedPeer(url) |
| RPC	| {"method": "admin_removeTrustedPeer", "params": [string]} |

### admin_startHTTP

`startHTTP` 管理方法会启动一个基于 HTTP 的 JSON-RPC API Web 服务器来处理客户端请求。所有参数均为可选:
- `host`: 用于打开监听套接字的网络接口（默认为"localhost"）
- `port`: 用于打开监听套接字的网络端口（默认为 8545）
- `cors`: 要使用的[跨域资源共享](https://en.wikipedia.org/wiki/Cross-origin_resource_sharing)标头（默认为空）
- `apis`: 要通过此接口提供的 API 模块（默认为"eth,net,web3"）

该方法返回一个布尔标志，指示 HTTP RPC 监听器是否已打开。请注意，任何时候只允许一个 HTTP 端点处于活动状态。

| 客户端 | 方法调用 |
|:------|:--------|
| Go	| admin.StartHTTP(host *string, port *rpc.HexNumber, cors *string, apis *string) (bool, error) |
|Console| admin.startHTTP(host, port, cors, apis) |
| RPC	| {"method": "admin_startHTTP", "params": [host, port, cors, apis]} |

示例:
```js
> admin.startHTTP("127.0.0.1", 8545)
true
```

### admin_startWS

`startWS` 管理方法会启动一个基于 WebSocket 的 [JSON RPC](https://www.jsonrpc.org/specification) API Web 服务器来处理客户端请求。所有参数均为可选:
- `host`: 用于打开监听套接字的网络接口（默认为"localhost"）
- `port`: 用于打开监听套接字的网络端口（默认为 8546）
- `cors`: 要使用的[跨域资源共享](https://en.wikipedia.org/wiki/Cross-origin_resource_sharing)标头（默认为空）
- `apis`: 要通过此接口提供的 API 模块（默认为"eth,net,web3"）

该方法返回一个布尔标志，指示 WebSocket RPC 监听器是否已打开。请注意，任何时候只允许一个 WebSocket 端点处于活动状态。

| 客户端 | 方法调用 |
|:------|:--------|
| Go	| admin.StartWS(host *string, port *rpc.HexNumber, cors *string, apis *string) (bool, error) |
|Console| admin.startWS(host, port, cors, apis) |
| RPC	| {"method": "admin_startWS", "params": [host, port, cors, apis]} |

```js
> admin.startWS("127.0.0.1", 8546)
true
```

### admin_stopHTTP

`stopHTTP` 管理方法用于关闭当前打开的 HTTP RPC 端点。由于节点只能运行一个 HTTP 端点，因此该方法不接受任何参数，而是返回一个布尔值，指示端点是否已关闭。

| 客户端 | 方法调用 |
|:------|:--------|
| Go	| admin.StopHTTP() (bool, error) |
|Console| admin.stopHTTP() |
| RPC	| {"method": "admin_stopHTTP"} |

示例:
```js
> admin.stopHTTP()
true
```

### admin_stopWS

`stopWS` 管理方法会关闭当前打开的 WebSocket RPC 端点。由于节点只能运行一个 WebSocket 端点，因此该方法不接受任何参数，而是返回一个布尔值，指示端点是否已关闭。

| 客户端 | 方法调用 |
|:------|:--------|
| Go	| admin.StopWS() (bool, error) |
|Console| admin.stopWS() |
|RPC	| {"method": "admin_stopWS"} |

示例:
```js
> admin.stopWS()
true
```
