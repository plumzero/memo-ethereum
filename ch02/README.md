
geth 和 clef 等命令安装完成后，依次执行如下命令按顺序快速启动测试环境。

终端一:
```s
  clef --keystore ~/geth-home/keystore --configdir ~/.clef --chainid 11155111
```

终端二:
```s
  geth --sepolia --datadir geth-home --authrpc.addr localhost --authrpc.port 8551 --authrpc.vhosts localhost --authrpc.jwtsecret geth-home/jwtsecret --http --http.api eth,net --signer=.clef/clef.ipc --http
```

终端三(可以进行单步命令查询或者启动一个 Geth 交互端，这里以第二种为例):
```s
  geth attach http://127.0.0.1:8545
```

