
参考文档:
- [web3.py](http://github.com/ethereum/web3.py)

以太坊为 Python 提供的 SDK 版本被称为 Web3.py。它是基于以太坊的 JavaScript 版本的SDK(Web3.js)产生的。

可以使用 pip 方式进行安装:
```s
  pip install web3 -i https://mirrors.aliyun.com/pypi/simple/
```

ABI 提供了应用程序的的接口供外部调用，不像 Java 或 Go 文件，Python 代码无须编译，拿到 ABI 信息后可以直接内嵌在代码中调用。

### 测试方法

如果采用本地 Geth 节点+Ephemery网络方式测试，涉及到 Lighthouse 可能需要翻墙同步数据。

为了简单，这里采用直连 Ephemery 网络某个超级节点的方式，该节点为`https://otter.bordel.wtf/erigon`。

测试者可以通过如下方式测试节点连通性:
```py
tester$ python3
Python 3.8.10 (default, Mar 18 2025, 20:04:55) 
[GCC 9.4.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> from web3 import Web3
>>> w3 = Web3(Web3.HTTPProvider('https://otter.bordel.wtf/erigon'))
>>> w3.is_connected()
```
当看到返回 True 时，就代表连接成功了。

如果使用本地 Geth 节点测试，可以将测试点改为`http://127.0.0.1:8545`。

### 调用合约

仍然以这样一份[合约文件](sol/calldemo.sol)进行测试，编译后拿到它的[ABI信息](abi/calldemo.abi)保存。

Remix 环境切换到 Ephemery 测试网，将上面的合约部署后，拿到合约地址。这里是"0x11Ab452827E6D2E691c61c87c02773901eEE2D75"。

Remix 环境切换到本地 Geth 节点(参考Go调用内容，选择同样的账户进行测试)进行接下来的测试。

这是具体的[测试文件](py/calldemo.py)。
