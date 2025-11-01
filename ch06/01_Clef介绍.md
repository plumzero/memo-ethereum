
主要参考:
- [Introduction to Clef](https://geth.ethereum.org/docs/tools/clef/introduction)

更新于 2022/12/20。

其他参考:
- [goerli testnet](https://goerli.net/)

### 什么是 Clef

Clef 是一款在安全的本地环境中签署交易和数据的工具。它旨在成为 Geth 内置账户管理的更具组合性和安全性的替代品。Clef 将密钥管理与 Geth 本身分离，这意味着它可以作为独立的密钥管理和签名应用程序使用，也可以集成到 Geth 中。与 Geth 的账户管理器相比，这提供了一个更灵活的模块化工具。Clef 可以在通过远程和/或不受信任的节点访问以太坊的情况下安全地使用，因为签名是在本地进行的，可以手动进行，也可以使用自定义规则集自动进行。Clef 与节点本身的分离使其能够作为守护进程运行在与客户端软件相同的机器上，也可以运行在像[USB Armory](https://inversepath.com/usbarmory)这样的安全 U 盘上，甚至可以运行在类似[QubesOS](https://www.qubes-os.org/)的独立虚拟机上。

### 安装和打开 Clef

使用者可以下载 Clef 使用，也可以编译 Clef 使用。编译的方式如下。

将[Geth github 仓库](https://github.com/ethereum/go-ethereum)克隆到本地后，切换到相应的版本，顶层目录的 cmd/clef 就是当前的工具集目录。

Clef 与 Geth 捆绑在一起，可以与 Geth 和其他捆绑工具一起构建:
```s
  make all
```
上面的命令会在 go-ethereum/build/bin 文件夹中创建一个 clef 可执行文件，如果需要，可以将其移动到另一个目录并运行。该二进制文件是独立的，不需要任何其他文件。

我们可以将 clef 命令拷贝到 geth 命令同一目录下使用。

然而，Clef 并不依赖于 Geth，可以使用以下方式自行构建:
```s
  make clef
```

构建完成后，必须初始化 Clef。这包括存储一些数据，其中一些数据是敏感的(例如密码、账户数据、签名规则等)。初始化 Clef 会获取这些数据，并使用用户定义的密码对其进行加密。
```s
  clef init
```
交互输出如下:
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
> ok

The master seed of clef will be locked with a password.
Please specify a password. Do not forget this password!
Password: 
Repeat password: 

A master seed has been generated into /home/tester/.clef/masterseed.json

This is required to be able to store credentials, such as:
* Passwords for keystores (used by rule engine)
* Storage for JavaScript auto-signing rules
* Hash of JavaScript rule-file

You should treat 'masterseed.json' with utmost secrecy and make a backup of it!
* The password is necessary but not enough, you need to back up the master seed too!
* The master seed does not contain your accounts, those need to be backed up separately!
```

### 安全模型

Clef 的主要优势之一是它与客户端软件分离，这意味着用户和 dApp 可以在安全的本地环境中使用它来签名数据和交易，并将签名后的数据包发送到任意以太坊入口点，例如，可能包含不受信任的远程节点。或者，Clef 也可以简单地用作独立的、可组合的签名器，作为去中心化应用程序的后端组件。这需要一个安全的架构，将加密操作与用户交互和内外部通信分离。

Clef 的安全模型如下:
- 一个独立的二进制文件控制所有加密操作，包括密钥库文件的加密、解密和存储，以及数据和交易的签名。
- 一个定义明确、特意精简的"外部"API 用于与 Clef 二进制文件进行通信 - Clef 将此外部流量视为不可信的。这意味着 Clef 不接受任何凭证，也不承认通过此通道接收的请求的权限。Clef 监听 http.addr:http.port 或 ipcpath（与 Geth 相同），并期望消息使用 JSON-RPC 2.0 标准进行格式化。某些外部 API 调用需要用户交互（手动批准/拒绝），如果未收到用户交互，响应可能会无限期延迟。
- Clef 使用 stin/stout 与调用二进制文件的进程通信。调用二进制文件的进程通常是基于控制台的原生用户界面 (UI)，但也有一个 API 可以与外部 UI 通信。此功能必须在启动时使用 `--stdio-ui` 启用。此通道被视为受信任通道，用于在用户和 Clef 之间传递批准和密码。
- Clef 不存储密钥，用户负责安全地存储和备份密钥文件。如果用户明确向 Clef 提供账户密码以启用自动账户解锁功能，Clef 会将账户密码存储在其加密保管库中。

外部 API 不会直接处理任何敏感数据，但可以用来请求 Clef 对某些数据或交易进行签名。内部 API 控制签名并触发手动批准（自动批准符合已证明规则集的操作）和密码请求。

使用 Clef 和以太坊节点（如 Geth）进行基本交易签名操作的一般流程如下:

![](img/clef_sign_flow.png)

在上图所示的示例中，Geth 将使用 `--signer <addr>:<port>` 启动，并将请求转发到 eth.sendTransaction。沿箭头方向排列的单色字体文本显示了各个组件之间传递的对象。

大多数用户使用 Clef 的方式是通过 UI 手动批准交易，如上图所示，但也可以配置 Clef 来签署交易，而无需始终提示用户。这需要定义交易签署的精确条件。这些条件称为规则，它们是一些小的 JavaScript 代码片段，用户可以通过将代码片段的哈希值注入 Clef 的安全白名单来验证这些条件。然后，Clef 使用规则文件启动，以便自动签署满足白名单规则文件中条件的请求。[规则页面](https://geth.ethereum.org/docs/tools/clef/rules)详细介绍了这一点。

### 基本使用

Clef 可以通过命令行使用 clef 命令启动。启动 Clef 时，终端中会显示以下欢迎消息:
```s
$ clef 

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

需要账户访问或签名的请求现在需要在此终端中明确同意。诸如通过本地 Geth 节点附加的 JavaScript 控制台或 RPC 发送交易之类的活动现在将无限期挂起，等待此终端的批准。

更详细的 Clef 教程可在[教程页面](https://geth.ethereum.org/docs/tools/clef/tutorial)上找到。

### 命令行选项

Clef 可以通过在启动时向 clef 提供标志和命令来配置。可以通过`clef -h`获得完整的命令行选项提示。

命令行常用选项包括 `--keystore` 和 `--chainid`，用于配置现有密钥库的路径和要连接的网络。这两个选项的默认值分别为 `$HOME/.ethereum/keystore` 和 `1`（对应以太坊主网）。以下代码片段启动 Clef，提供现有密钥库的自定义路径并连接到 Goerli 测试网:
```s
  clef --keystore /my/keystore --chainid 5
```

### 总结

Clef 是一款外部密钥管理和签名工具，与 Geth 捆绑一起，既可以作为 Geth 的后端账户管理器和签名器使用，也可以作为完全独立的应用程序使用。Clef 具有模块化和可组合性，可以作为去中心化应用程序的组件使用，也可以在不可信环境中用于数据和交易签名。Clef 的目标是最终取代 Geth 的内置账户管理工具。