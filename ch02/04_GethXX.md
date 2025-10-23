
在安装好 Geth 后，需要知道如何启动它。不过在这之前，需要了解以下几个概念。
- 1.主网: 以太坊真实节点运行的网络，节点遍布全球，此网络中使用的"ether"是真实的虚拟数字货币ETH，具有实际价值，因此成本较高。
- 2.测试网: 测试网的节点数量相较于主网较少，主要是为以太坊开发者提供一个测试的平台环境，此网络上的"ether"通常可以通过完成任务或申请获得，没有实际货币价值，但可用于测试交易和智能合约。
- 3.私网: 私网是由开发者自行组建的网络，不与主网及测试网连通，独立存在，主要用于个人测试和开发。

需要明确的是，无论是主网、测试网还是私网，都可以使用 Geth 来启动。当 Geth 直接运行时，默认连接的就是以太坊主网，接下来说明如何启动 Geth 私有网络。

### 编写初始化文件

将如下内容保存为 genesis.json 文件。
```json
{
  "config": {
    "chainId": 1008,
    "homesteadBlock": 0,
    "eip150Block": 0,
    "eip155Block": 0,
    "eip158Block": 0,
    "byzantiumBlock": 0,
    "constantinopleBlock": 0,
    "petersburgBlock": 0,
    "ethash": {}
  },
  "difficulty": "1",
  "gasLimit": "8000000",
  "alloc": {
    "7df9a875a174b3bc565e6424a0050ebc1b2d1d82": { "balance": "300000" },
    "f41c74c9ae680c1aa78f42e5647a62f353b7bdde": { "balance": "400000" }
  }
}
```

genesis.json 通常会被称为创世块文件，其中的几个关键信息含义如下:
- chainId: 不同链的唯一标识。
- ethash: 以太坊的工作量证明共识算法。
- difficulty: 挖矿难度。
- gasLimit: 一个区块所能容纳 Gas 的上限。

### 利用创世块文件初始化

指定一个数据目录，执行如下命令:
```s
  geth init --datadir ./data genesis.json
```
当看到类似下面的结果代表初始化成功:
```s
INFO [10-12|17:01:09.892] Maximum peer count                       ETH=50 LES=0 total=50
INFO [10-12|17:01:09.893] Smartcard socket not found, disabling    err="stat /run/pcscd/pcscd.comm: no such file or directory"
INFO [10-12|17:01:09.894] Set global gas cap                       cap=50,000,000
INFO [10-12|17:01:09.895] Allocated cache and file handles         database=/home/tester/github/memo-solidity/ch01/data/geth/chaindata cache=16.00MiB handles=16
INFO [10-12|17:01:09.912] Writing custom genesis block
INFO [10-12|17:01:09.913] Persisted trie from memory database      nodes=3 size=397.00B time="92.881µs" gcnodes=0 gcsize=0.00B gctime=0s livenodes=1 livesize=0.00B
INFO [10-12|17:01:09.915] Successfully wrote genesis state         database=chaindata hash=c3638c..f97051
INFO [10-12|17:01:09.915] Allocated cache and file handles         database=/home/tester/github/memo-solidity/ch01/data/geth/lightchaindata cache=16.00MiB handles=16
INFO [10-12|17:01:09.934] Writing custom genesis block
INFO [10-12|17:01:09.935] Persisted trie from memory database      nodes=3 size=397.00B time="455.853µs" gcnodes=0 gcsize=0.00B gctime=0s livenodes=1 livesize=0.00B
INFO [10-12|17:01:09.938] Successfully wrote genesis state         database=lightchaindata hash=c3638c..f97051
```

此时在 data 目录下，会有一些文件生成，文件组织结构如下:
```s
data
├── geth
│   ├── chaindata
│   │   ├── 000006.log
│   │   ├── ancient
│   │   │   └── chain
│   │   │       ├── bodies.0000.cdat
│   │   │       ├── bodies.cidx
│   │   │       ├── bodies.meta
│   │   │       ├── diffs.0000.rdat
│   │   │       ├── diffs.meta
│   │   │       ├── diffs.ridx
│   │   │       ├── FLOCK
│   │   │       ├── hashes.0000.rdat
│   │   │       ├── hashes.meta
│   │   │       ├── hashes.ridx
│   │   │       ├── headers.0000.cdat
│   │   │       ├── headers.cidx
│   │   │       ├── headers.meta
│   │   │       ├── receipts.0000.cdat
│   │   │       ├── receipts.cidx
│   │   │       └── receipts.meta
│   │   ├── CURRENT
│   │   ├── CURRENT.bak
│   │   ├── LOCK
│   │   ├── LOG
│   │   ├── MANIFEST-000007
│   │   └── OPTIONS-000007
│   ├── lightchaindata
│   │   ├── 000003.log
│   │   ├── ancient
│   │   │   └── chain
│   │   │       ├── bodies.0000.cdat
│   │   │       ├── bodies.cidx
│   │   │       ├── bodies.meta
│   │   │       ├── diffs.0000.rdat
│   │   │       ├── diffs.meta
│   │   │       ├── diffs.ridx
│   │   │       ├── FLOCK
│   │   │       ├── hashes.0000.rdat
│   │   │       ├── hashes.meta
│   │   │       ├── hashes.ridx
│   │   │       ├── headers.0000.cdat
│   │   │       ├── headers.cidx
│   │   │       ├── headers.meta
│   │   │       ├── receipts.0000.cdat
│   │   │       ├── receipts.cidx
│   │   │       └── receipts.meta
│   │   ├── CURRENT
│   │   ├── CURRENT.bak
│   │   ├── LOCK
│   │   ├── LOG
│   │   ├── MANIFEST-000004
│   │   └── OPTIONS-000003
│   ├── LOCK
│   └── nodekey
└── keystore
    └── UTC--2025-10-12T08-48-34.381625397Z--1aaf81aa01eb53e876cf201e5e270a7849111882
```

### 创建新账户

```s
  geth account new --datadir data
```
创建时需要输入口令，并再次确认口令，口令千万不要忘记。

我这里的执行信息如下:
```s
INFO [10-12|17:02:49.729] Maximum peer count                       ETH=50 LES=0 total=50
INFO [10-12|17:02:49.729] Smartcard socket not found, disabling    err="stat /run/pcscd/pcscd.comm: no such file or directory"
Your new account is locked with a password. Please give a password. Do not forget this password.
Password:
Repeat password:

Your new key was generated

Public address of the key:   0x88BA58c58797CBC25a06776CE234c852aaD995Da
Path of the secret key file: data/keystore/UTC--2025-10-12T09-02-55.749089415Z--88ba58c58797cbc25a06776ce234c852aad995da

- You can share your public address with anyone. Others need it to interact with you.
- You must NEVER share the secret key with anyone! The key controls access to your funds!
- You must BACKUP your key file! Without the key, it's impossible to access account funds!
- You must REMEMBER your password! Without the password, it's impossible to decrypt the key!
```

### 启动网络

```s
  geth --datadir ./data --networkid 1008 --http --http.addr 0.0.0.0 --http.vhosts "*" --http.api "db,net,eth,web3,personal" --http.corsdomain "*" --mine --miner.threads 1 --allow-insecure-unlock console 2> 1.log
```
相关参数的含义如下:
- datadir: 指定之前初始化的数据目录文件。
- networkid: 区分不同的网络。
- http: 开启远程调用服务，这对应用开发非常重要。
- http.addr: 远程服务的地址。
- http.api: 远程服务提供的远程调用函数集。
- http.corsdomain: 指定可以接收请示来源的域名列表(浏览器访问时，必须开启)。
- allow-insecure-unlock: 允许在 Geth 命令窗口解锁账户。
- mine: 开启挖矿。
- mine.threads: 设置挖矿的线程数量。
- console: 进入管理台。
- 2> 1.log: 在 Unix 系统下，将 Geth 产生的日志输出都重定向到 1.log 中，以免屏幕刷日志影响操作。

启动后，将看到类似下面的结果。至此，Geth 私有网络已经启动成功。
```s
Welcome to the Geth JavaScript console!

instance: Geth/v1.10.15-stable-8be800ff/linux-amd64/go1.17.5
coinbase: 0x1aaf81aa01eb53e876cf201e5e270a7849111882
at block: 0 (Thu Jan 01 1970 08:00:00 GMT+0800 (CST))
 datadir: /home/liber/github/memo-solidity/ch01/data
 modules: admin:1.0 debug:1.0 eth:1.0 ethash:1.0 miner:1.0 net:1.0 personal:1.0 rpc:1.0 txpool:1.0 web3:1.0

To exit, press ctrl-d or type exit
>
```