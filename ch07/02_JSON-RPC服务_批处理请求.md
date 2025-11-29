
主要参考:
- [Batch requests](https://geth.ethereum.org/docs/interacting-with-geth/rpc/batch)

更新于 2023/03/08。

JSON-RPC [规范](https://www.jsonrpc.org/specification#batch)概述了客户端如何通过将请求对象填充到数组中来同时发送多个请求。Geth 的 API 实现了此功能，可用于减少网络延迟。批量处理尤其在获取大量相对独立的数据对象时，能够显著提升速度。

以下是使用 JS 获取代码块列表的示例:
```js
import fetch from 'node-fetch';

async function main() {
  const endpoint = 'http://127.0.0.1:8545';
  const from = parseInt(process.argv[2]);
  const to = parseInt(process.argv[3]);

  const reqs = [];
  for (let i = from; i < to; i++) {
    reqs.push({
      method: 'eth_getBlockByNumber',
      params: [`0x${i.toString(16)}`, false],
      id: i - from,
      jsonrpc: '2.0'
    });
  }

  const res = await fetch(endpoint, {
    method: 'POST',
    body: JSON.stringify(reqs),
    headers: { 'Content-Type': 'application/json' }
  });
  const data = await res.json();
}

main()
  .then()
  .catch(err => console.log(err));
```

在这种情况下，请求之间没有依赖关系。通常，需要从一个请求中获取的数据才能发出第二个请求。例如，假设我们需要获取一系列区块的所有交易收据。JSON-RPC API 提供了 `eth_getTransactionReceipt` 函数，该函数接收一个交易哈希并返回相应的收据对象，但它没有提供获取整个区块收据对象的方法。我们需要获取区块中的交易列表，然后对每个交易调用 `eth_getTransactionReceipt` 函数。

我们可以将其拆分为两个批量请求:
- 首先，下载所需范围内所有区块的交易哈希列表
- 然后，下载所有交易哈希对应的收据对象列表

对于依赖多个 JSON-RPC 端点的用例，批处理方法很容易变得复杂。在这种情况下，Geth 提供了更合适的 [GraphQL API](https://geth.ethereum.org/docs/interacting-with-geth/rpc/graphql)。
