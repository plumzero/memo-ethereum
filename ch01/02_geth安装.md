
Geth 是使用 Go 语言编写的以太坊客户端工具，利用 Geth 可以快速搭建以太坊私有网络或连接到以太坊公有网络。Geth 安装包可以使用如下网址进行下载: https://geth.ethereum.org/downloads 。

这里以 1.10.15 版本为例，分别对在 Windows 和 Linux 下的安装进行简单说明。

### Windows

进入 Windows 对应的下载页面后，选择指定版本进行下载。下载后的文件名称是 geth-windows-amd64-1.10.15-8be800ff.exe，双击安装。

安装完成后，打开 cmd 端，执行`geth -h`测试 Geth 运行。如果窗口能够看到帮助信息，则成功。

### Linux

进入 Linux 对应的下载页面后，选择指定版本进行下载。下载后的压缩包名称是 geth-linux-amd64-1.10.15-8be800ff.tar.gz。

在 Linux 上将文件解压到 ~/geth-home 目录下。解压后的文件组织形式如下:
```s
geth-home
└── geth-linux-amd64-1.10.15-8be800ff
    ├── COPYING
    └── geth
```

执行如下命令配置环境:
```s
  echo "export PATH=$HOME/geth-home/geth-linux-amd64-1.10.15-8be800ff:$PATH" >> ~/.bashrc
  source ~/.bashrc
```

执行`geth -h`确认是否有帮助信息。
