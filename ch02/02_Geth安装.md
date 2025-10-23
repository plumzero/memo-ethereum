
主要参考:
- [Installing Geth](https://geth.ethereum.org/docs/getting-started/installing-geth)

首先确保[硬件](硬件要求.md)要支持，之后才能下载和安装 Geth。确认熟悉[安全要求](安全.md)并设置防火墙。

Geth 安装包可以在[这里](https://geth.ethereum.org/downloads)进行下载。

稳定版本和开发版本以独立软件包的形式提供。这些软件包适用于以下用户: a) 希望安装特定版本的 Geth(例如，用于可复现的环境; b) 希望在没有互联网连接的机器上安装(例如，隔离的计算机);或 c) 希望避免自动更新，而更喜欢手动安装软件。

以下独立软件包可用:
- Linux 上的 32 位、64 位、ARMv5、ARMv6、ARMv7 和 ARM64 压缩包 (.tar.gz)
- macOS 上的 64 位压缩包 (.tar.gz)
- Windows 上的 32 位和 64 位压缩包 (.zip) 和安装程序 (.exe)

有些压缩包仅包含 Geth，而其他压缩包则包含 Geth 和各种开发者工具（clef、devp2p、abigen、bootnode、evm 和 rlpdump）。有关这些可执行文件的更多信息，请参阅 README 文件。

这里选择 1.16.5 的稳定版本，分别对在 Windows 和 Linux 下的安装进行简单说明。

### Windows

安装 Geth 最简单的方法是从下载页面下载预编译的二进制文件。该页面提供了一个安装程序以及一个包含 Geth 源代码的 zip 文件。安装向导会为用户提供安装 Geth 或 Geth 及其开发者工具的选项。安装程序会自动将 geth 添加到系统 PATH 环境变量中。该 zip 文件包含可从命令提示符运行的 .exe 命令文件。完整的命令行选项列表可在此处查看，或在终端中运行 geth --help 查看。

您可以通过停止节点，然后按照上述说明下载并安装最新版本来更新现有的 Geth 安装。当节点重新启动时，Geth 将自动使用先前版本的所有数据，并同步节点离线期间丢失的区块。

进入 Windows 对应的下载页面后，选择指定版本进行下载。下载后的文件名称是 geth-windows-amd64-1.16.5-737ffd1b.exe，双击安装。

安装完成后，打开 cmd 端，执行`geth -h`测试 Geth 运行。如果窗口能够看到帮助信息，则成功。

### Linux

进入 Linux 对应的下载页面后，选择指定版本进行下载。下载后的压缩包名称是 geth-linux-amd64-1.16.5-737ffd1b.tar.gz。

在 Linux 上将文件解压到 ~/geth-home 目录下。解压后的文件组织形式如下:
```s
geth-home
└── geth-linux-amd64-1.16.5-737ffd1b
    ├── COPYING
    └── geth
```

将下面的命令添加到`~/.bashrc`配置中，执行`source ~/.bashrc`使指令生效。
```s
  export PATH=$HOME/geth-home/geth-linux-amd64-1.16.5-737ffd1b:$PATH
```
执行`geth -h`确认是否有帮助信息。

### 源码编译

确认安装了 go 环境，笔者安装的 go 版本为 `1.25.3`。

克隆[go-ethereum仓库](https://github.com/ethereum/go-ethereum)，切换到指定版本，执行编译:
```s
  git clone https://github.com/ethereum/go-ethereum
  cd go-ethereum
  git checkout v1.16.5
  make geth
```

这些命令会在 go-ethereum/build/bin 文件夹中创建一个 geth 可执行文件，如果需要，可以将其移动到另一个目录并运行。该二进制文件是独立的，不需要任何其他文件。

此外，Geth 提供的所有开发者工具(clef、devp2p、abigen、bootnode、evm 和 rlpdump)都可以通过运行`make all`进行编译。更多关于这些工具的信息，请点击[这里](https://github.com/ethereum/go-ethereum#executables)。
