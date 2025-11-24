
主要参考:
- [Download Era](https://geth.ethereum.org/docs/fundamentals/downloadera)
- [Slot和Epoch](Slot和Epoch.md)

Era 下载用于检索 Geth 节点中已过期或已修剪的历史区块主体和收据数据。Era 文件允许操作员高效地重建历史记录，而无需完全同步。启用历史记录过期功能的 Geth 节点可以修剪历史区块主体和收据，从而显著降低存储需求。然而，在某些情况下，操作员可能希望选择性地恢复部分历史记录，以用于研究、调试或合规性目的。Era 文件提供了一种高效的方法，可以直接从可信服务器检索历史数据，而无需重新同步整个链。`geth download-era` 命令可以实现有针对性地检索这些数据。

### 要求

下载 Era 文件之前，请确保有足够的磁盘空间来存储下载的文件。您可以在节点运行时下载 Era 文件。

Era 文件按区块(block)或纪元(epoch)范围进行索引。下载时:
- Geth 会向 era 服务器查询与请求范围对应的文件。
- 下载的文件会根据已知校验和(checksum)自动进行验证。
- 验证后的文件将被放入 ancient 存储目录，以供 Geth 使用。

### 下载 Era 命令

```s
  geth download-era --server <url> [--block <range> | --epoch <range> | --all] --datadir <path>
```

| 选项 | 描述 |
|:----|:----|
| --server |（必需）era 服务器的 URL |
| --block | 需要下载的区块号或范围（例如: 100000-200000） |
| --epoch | 需要下载的 epoch 号或范围（例如: 100-200） |
| --all |下载所有可用的 era 文件 |
| --datadir | 存储 era 文件的 Geth datadir |

范围格式说明:
- 单值: 500 → 仅下载 500 个区块或纪元
- 范围: 100-200 → 下载范围从 100 到 200（含）

服务器可在以下链接找到: [以太坊历史端点](https://eth-clients.github.io/history-endpoints/)。此链接包含提供 era 文件的客户端的最新更新列表。目前，geth 仅支持符合 Era1 规范的 era 文件，因此请确保下载符合规范的 era 文件。

### 示例

下载 epoch 100-300:
```s
  geth download-era --server https://mainnet.era1.nimbus.team --epoch 100-300 --datadir /mnt/geth-data
```

下载所有:
```s
  geth download-era --server https://mainnet.era1.nimbus.team --all --datadir /mnt/geth-data
```