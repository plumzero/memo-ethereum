
主要参考:
- [debug Namespace](https://geth.ethereum.org/docs/interacting-with-geth/rpc/ns-debug)

更新于 2024/09/29。

`debug` API 允许您访问几个非标准的 RPC 方法，这些方法允许您在运行时检查、调试和设置某些调试标志。

### debug_accountRange

枚举给定区块内所有支持分页的账户。每页返回 `maxResults` 个结果，每个结果的键值都位于 `start` 键（哈希地址）之后。

如果 `incompletes` 为 false，则跳过键值原像（即`address`）在数据库中不存在的账户。注意: geth 默认情况下不存储原像。

| 客户端 | 方法调用 |
|:------|:--------|
|Console| debug.accountRange(blockNrOrHash, start, maxResults, nocode, nostorage, incompletes) |
| RPC	| {"method": "debug_accountRange", "params": [blockNrOrHash, start, maxResults, nocode, nostorage, incompletes]} |

### debug_backtraceAt

设置日志回溯位置。当设置了回溯位置并且在该位置发出日志消息时，执行该日志语句的 `goroutine` 的堆栈信息将被打印到 stderr。

文件位置以`<filename>:<line>`的形式指定。

| 客户端 | 方法调用 |
|:------|:--------|
|Console| debug.backtraceAt(string) |
| RPC	| {"method": "debug_backtraceAt", "params": [string]} |

示例:
```s
  > debug.backtraceAt("server.go:443")
```

### debug_blockProfile

启用指定持续时间的块分析，并将分析数据写入磁盘。为了获得最精确的信息，它使用分析速率 1。如果需要不同的速率，请使用 `debug_writeBlockProfile` 手动设置速率并写入分析数据。