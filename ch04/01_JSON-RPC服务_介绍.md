
主要参考:
- [JSON-RPC Server](https://geth.ethereum.org/docs/interacting-with-geth/rpc)

更新于 2024/07/11。

与 Geth 交互需要向特定的 JSON-RPC API 方法发送请求。Geth 支持所有标准的 [JSON-RPC API](https://github.com/ethereum/execution-apis) 端点。RPC 请求必须发送到节点，并且响应必须使用某种传输协议返回给客户端。本节概述了 Geth 中可用的传输协议，为用户提供在特定场景下选择传输协议所需的信息。

### 介绍

JSON-RPC 支持多种传输方式。Geth 支持通过 HTTP、WebSocket 和 Unix 域套接字进行 JSON-RPC 通信。必须通过命令行标志启用传输方式。

以太坊 JSON-RPC API 使用命名空间(name-space)系统。RPC 方法根据其用途被分为多个类别。所有方法名称均由命名空间、下划线和命名空间内的实际方法名称组成。例如，`eth_call` 方法位于 `eth` 命名空间中。

可以按命名空间启用对 RPC 方法的访问。

### 传输

Geth 中有三种传输协议可用: IPC、HTTP 和 Websockets。

1.HTTP服务

[HTTP](https://developer.mozilla.org/en-US/docs/Web/HTTP) 是一种连接客户端和服务器的单向传输协议。客户端向服务器发送请求，服务器返回响应。HTTP 连接在发送给定请求的响应后关闭。

所有浏览器以及几乎所有编程工具链都支持 HTTP。由于其普及性，它已成为与 Geth 交互最常用的传输方式。要在 Geth 中启动 HTTP 服务器，要添加 `--http` 参数:
```s
  geth --http
```
如果没有提供其他命令，Geth 将使用其默认行为，即接受来自本地环回接口 (127.0.0.1) 的连接。默认监听端口为 8545。可以使用 `--http.addr` 和 `--http.port` 标志自定义 IP 地址和监听端口:
```s
  geth --http --http.port 3334
```

并非所有 JSON-RPC 方法命名空间都默认对 HTTP 请求启用。它们必须在 Geth 启动时显式地添加到白名单中。调用未列入白名单的 RPC 命名空间会返回 RPC 错误，错误代码为 `-32602`。

默认白名单允许访问 `eth`、`net` 和 `web3` 命名空间。要启用对其他 API（例如 `debug`）的访问，必须使用 `--http.api` 标志进行配置。不建议通过 HTTP 启用这些 API，因为访问这些方法会增加攻击面。
```s
  geth --http --http.api eth,net,web3
```

由于任何本地应用程序都可以访问 HTTP 服务器，因此服务器内置了额外的保护措施，以防止从网页滥用 API。要允许从网页访问 API（例如，使用在线 IDE [Remix](https://remix.ethereum.org/)），需要将服务器配置为接受跨域请求。这可以通过使用 `--http.corsdomain` 标志来实现。
```s
  geth --http --http.corsdomain https://remix.ethereum.org
```

`--http.corsdomain` 命令也接受通配符，允许从任何来源访问 RPC:
```s
  --http.corsdomain '*'
```

2.WebSocket服务

WebSocket 是一种双向传输协议。客户端和服务器会维护一个 WebSocket 连接，直到一方显式终止为止。大多数现代浏览器都支持 WebSocket，这意味着它拥有完善的工具支持。

由于 WebSocket 是双向的，服务器可以向客户端推送事件。这使得 WebSocket 成为[事件订阅](https://geth.ethereum.org/docs/interacting-with-geth/rpc/pubsub)场景的理想选择。WebSocket 的另一个优点是，握手过程完成后，单个消息的开销很低，因此非常适合发送大量请求。

Geth 中 WebSocket 端点的配置与 HTTP 传输的配置模式相同。可以使用 `--ws` 标志启用 WebSocket 访问。如果没有提供其他信息，Geth 将使用其默认行为，即在端口 8546 上建立 WebSocket 连接。可以使用 `--ws.addr`、`--ws.port` 和 `--ws.api` 标志自定义 WebSocket 服务器的设置。例如，要使用自定义端口 3334 启动 Geth 并建立用于 RPC 的 WebSocket 连接，并将 eth、net 和 web3 命名空间列入白名单:
```s
  geth --ws --ws.port 3334 --ws.api eth,net,web3
```

跨域请求保护也适用于 WebSocket 服务器。可以使用 `--ws.origins` 标志允许从网页访问该服务器:
```s
  geth --ws --ws.origins http://myapp.example.com
```

与 `--http.corsdomain` 一样，使用通配符 `--ws.origins '*'` 允许从任何来源访问。

> 注意: 默认情况下，启用 HTTP 或 WebSocket 访问（即通过 `--http` 或 `--ws` 标志）时，账户解锁是被禁止的。这是因为攻击者如果能够通过外部暴露的 HTTP/WS 端口访问节点，就可以控制已解锁的账户。虽然可以通过添加 `--allow-insecure-unlock` 标志来强制解锁账户，但这很不安全，除非是完全了解如何安全使用此功能的专家用户，否则不建议这样做。这并非假设的风险: 确实存在一些机器人程序会持续扫描启用 HTTP 的以太坊节点并进行攻击。

3.IPC服务

通常情况下，IPC 可用于节点和控制台位于同一台机器上的本地环境。Geth 会在计算机的本地文件系统（位于 `ipcpath`）中创建一个管道，用于配置节点和控制台之间的连接。同一台机器上的其他进程也可以使用 `geth.ipc` 文件与 Geth 进行交互。

在基于 UNIX 的系统（Linux、OSX）上，IPC 使用 UNIX 域套接字。在 Windows 上，IPC 通过命名管道实现。IPC 服务器默认启用，并可以访问所有 J​​SON-RPC 命名空间。

监听套接字默认位于数据目录中。在 Linux 和 macOS 系统中，geth 套接字的默认位置是:
```s
  ~/.ethereum/geth.ipc
```

在 Windows 系统中，进程间通信 (IPC) 通过命名管道实现。geth 管道的默认位置是:
```s
  \\.\pipe\geth.ipc
```
可以使用 `--ipcpath` 标志自定义套接字的位置。可以使用 `--ipcdisable` 标志禁用进程间通信 (IPC)。

### 选择传输协议

下表总结了每种传输协议的相对优势和劣势，以便用户可以做出明智的决定。

|                | HTTP | WS | IPC |
|:---------------|:-----|:---|:----|
| 支持事件订阅     | N    | Y  | Y   |
| 支持远程连接     | Y    | Y  | N   |
| 单条消息开销     | high | low| low |

一般来说，进程间通信（IPC）安全性最高，因为它仅限于本地机器上的交互，不会暴露给外部流量。它还可以用于订阅事件。HTTP 是一种常用的幂等传输协议，它会在请求之间关闭连接，因此如果请求数量较少，其总体开销可以更低。WebSocket 提供了一个持续开放的通道，可以支持事件订阅和流式传输，并且能够以更小的单条消息开销处理大量请求。

### Engine-API

Engine-API 是一组 RPC 方法，用于实现 Geth 与共识客户端之间的通信。这些方法并非设计为对用户公开，而是由客户端在需要交换信息时自动调用。Engine API 默认启用，用户无需向 Geth 发送任何指令来启用这些方法。

更多信息请参阅[Engine API 规范](https://github.com/ethereum/execution-apis/tree/main/src/engine)。
