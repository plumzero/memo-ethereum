
主要参考:
- [Real-time Events](https://geth.ethereum.org/docs/interacting-with-geth/rpc/pubsub)

更新于 2023/08/16。

Geth v1.4 及更高版本支持使用 JSON-RPC 通知进行发布/订阅。这使得客户端可以等待事件发生，而无需轮询。

其工作原理是订阅特定事件。节点会返回一个订阅 ID。对于每个与订阅匹配的事件，都会发送一条包含相关数据和订阅 ID 的通知。

### 示例

创建订阅:
```json
{ "id": 1, "jsonrpc": "2.0", "method": "eth_subscribe", "params": ["newHeads"] }
```
响应是返回一个订阅ID:
```json
{ "id": 1, "jsonrpc": "2.0", "result": "0xcd0c3e8af590364c09d0fa6a1210faf5" }
```

创建订阅后，我们可以接收与此订阅相关的传入通知:
```json
{ "jsonrpc": "2.0", "method": "eth_subscription", "params": {"subscription": "0xcd0c3e8af590364c09d0fa6a1210faf5", "result": {"difficulty": "0xd9263f42a87", <...>, "uncles": []}} }
{ "jsonrpc": "2.0", "method": "eth_subscription", "params": {"subscription": "0xcd0c3e8af590364c09d0fa6a1210faf5", "result": {"difficulty": "0xd90b1a7ad02", <...>, "uncles": ["0x80aacd1ea4c9da32efd8c2cc9ab38f8f70578fcd46a1a4ed73f82f3e0957f936"]}} }
```

取消订阅:
```json
{
  "id": 1,
  "jsonrpc": "2.0",
  "method": "eth_unsubscribe",
  "params": ["0xcd0c3e8af590364c09d0fa6a1210faf5"]
}
```
响应是:
```json
{ "id": 1, "jsonrpc": "2.0", "result": true }
```

### 注意事项

1.通知仅针对当前事件发送，而非过去事件。对于任何不容错过通知的使用场景，订阅可能并非最佳选择。
2.订阅需要全双工连接。 Geth 提供 WebSocket 和 IPC（默认启用）形式的此类连接。
3.订阅与连接绑定。如果连接关闭，所有通过该连接创建的订阅都将被移除。
4.通知存储在内部缓冲区中，并从该缓冲区发送到客户端。如果客户端无法处理大量通知，且缓冲区中的通知数量达到上限（目前为 1 万条），则连接将被关闭。请注意，订阅某些事件可能会导致大量通知涌入，例如，在节点开始同步时监听所有日志/数据块。

### 创建订阅

订阅是通过常规的 RPC 调用创建的，方法名为 `eth_subscribe`，第一个参数为订阅名称。如果成功，则返回订阅 ID。

参数:
- 订阅名称
- 可选参数

示例:
```json
{ "id": 1, "jsonrpc": "2.0", "method": "eth_subscribe", "params": ["newHeads"] }
{ "id": 1, "jsonrpc": "2.0", "result": "0x9cef478923ff08bf67fde6c64013158d" }
```

### 取消订阅

订阅可以通过常规的 RPC 调用取消，方法名为 `eth_unsubscribe`，第一个参数为订阅 ID。该调用返回一个布尔值，指示订阅是否成功取消。

参数:
- 订阅ID

示例:
```json
{ "id": 1, "jsonrpc": "2.0", "method": "eth_unsubscribe", "params": ["0x9cef478923ff08bf67fde6c64013158d"] }
{ "id": 1, "jsonrpc": "2.0", "result": true }
```

### 支持的订阅

1.newHeads

每次链上添加新区块头时（包括链重组），都会触发通知。用户可以使用布隆过滤器来确定区块中是否包含他们感兴趣的日志。请注意，如果 geth 同时接收到多个区块（例如，在不同步后进行追赶），则只会发出最后一个区块的通知。

如果发生链重组，订阅将发出新链中的最后一个区块头。因此，订阅可能会在同一区块高度发出多个区块头。

示例:
```json
{ "id": 1, "jsonrpc": "2.0", "method": "eth_subscribe", "params": ["newHeads"] }
```

响应:
```json
  { "id": 1, "jsonrpc": "2.0", "result": "0x9ce59a13059e417087c02d3236a0b1cc" }

  {
    "jsonrpc": "2.0",
    "method": "eth_subscription",
    "params": {
      "result": {
        "difficulty": "0x15d9223a23aa",
        "extraData": "0xd983010305844765746887676f312e342e328777696e646f7773",
        "gasLimit": "0x47e7c4",
        "gasUsed": "0x38658",
        "logsBloom": "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
        "miner": "0xf8b483dba2c3b7176a3da549ad41a48bb3121069",
        "nonce": "0x084149998194cc5f",
        "number": "0x1348c9",
        "parentHash": "0x7736fab79e05dc611604d22470dadad26f56fe494421b5b333de816ce1f25701",
        "receiptRoot": "0x2fab35823ad00c7bb388595cb46652fe7886e00660a01e867824d3dceb1c8d36",
        "sha3Uncles": "0x1dcc4de8dec75d7aab85b567b6ccd41ad312451b948a7413f0a142fd40d49347",
        "stateRoot": "0xb3346685172db67de536d8765c43c31009d0eb3bd9c501c9be3229203f15f378",
        "timestamp": "0x56ffeff8",
        "transactionsRoot": "0x0167ffa60e3ebc0b080cdb95f7c0087dd6c0e61413140e39d94d3468d7c9689f"
      },
      "subscription": "0x9ce59a13059e417087c02d3236a0b1cc"
    }
  }
```

2.logs

返回包含在新导入区块中且符合给定筛选条件的日志。

如果发生链重组，则之前发送的、位于旧链上的日志将被重新发送，并将 `removed` 属性设置为 true。最终位于新链上的交易的日志将被发出。因此，一个订阅可能会多次发出同一交易的日志。

参数:
- `Object` 对象，包含以下可选字段:
  - address，可以是单个地址或地址数组。仅返回由这些地址创建的日志（可选）
  - topics，仅返回与指定主题匹配的日志（可选）

示例:
```json
{
  "id": 1,
  "jsonrpc": "2.0",
  "method": "eth_subscribe",
  "params": [
    "logs",
    {
      "address": "0x8320fe7702b96808f7bbc0d4a888ed1468216cfd",
      "topics": ["0xd78a0cb8bb633d06981248b816e7bd33c2a35a6089241d099fa519e361cab902"]
    }
  ]
}
```

响应:
```json
{ "id": 2, "jsonrpc": "2.0", "result": "0x4a8a4c0517381924f9838102c5a4dcb7" }

{
  "jsonrpc": "2.0",
  "method": "eth_subscription",
  "params": {
    "subscription": "0x4a8a4c0517381924f9838102c5a4dcb7",
    "result": {
      "address": "0x8320fe7702b96808f7bbc0d4a888ed1468216cfd",
      "blockHash": "0x61cdb2a09ab99abf791d474f20c2ea89bf8de2923a2d42bb49944c8c993cbf04",
      "blockNumber": "0x29e87",
      "data": "0x00000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000003",
      "logIndex": "0x0",
      "topics": ["0xd78a0cb8bb633d06981248b816e7bd33c2a35a6089241d099fa519e361cab902"],
      "transactionHash": "0xe044554a0a55067caafd07f8020ab9f2af60bdfe337e395ecd84b4877a3d1ab4",
      "transactionIndex": "0x0"
    }
  }
}
```

3.newPendingTransactions

返回所有已添加到待处理状态(pending state)且使用节点中可用密钥签名的交易的哈希值。

如果之前属于规范链(canonical chain)的交易在重组后不再属于新的规范链，则会再次发出该哈希值。

参数: 无

示例:
```json
{ "id": 1, "jsonrpc": "2.0", "method": "eth_subscribe", "params": ["newPendingTransactions"] }
```

响应:
```json
{ "id": 1, "jsonrpc": "2.0", "result": "0xc3b33aa549fb9a60e95d21862596617c" }

{
  "jsonrpc":"2.0",
  "method":"eth_subscription",
  "params":{
    "subscription":"0xc3b33aa549fb9a60e95d21862596617c",
    "result":"0xd6fdc5cc41a9959e922f30cb772a9aef46f4daea279307bc5f7024edc4ccd7fa"
  }
}
```

3.syncing

指示节点何时开始或停止同步。结果可以是布尔值，表示同步已开始（true）或已结束（false），也可以是包含各种进度指示器的对象。

参数: 无

示例:
```json
{ "id": 1, "jsonrpc": "2.0", "method": "eth_subscribe", "params": ["syncing"] }
```

响应:
```json
{ "id": 1, "jsonrpc": "2.0", "result": "0xe2ffeb2703bcf602d42922385829ce96" }

{
  "subscription": "0xe2ffeb2703bcf602d42922385829ce96",
  "result": {
    "syncing": true,
    "status": {
      "startingBlock": 674427,
      "currentBlock": 67400,
      "highestBlock": 674432,
      "pulledStates": 0,
      "knownStates": 0
    }
  }
}
```