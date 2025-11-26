
Quick Dab 是一个可以自动为智能合约创建前端 UI 的工具。

以下面的智能合约为例进行说明。
```js
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyContract {
    // 状态变量：存储一个无符号整数
    uint256 public data;

    // 外部函数：更新 data 的值
    function updateData(uint256 _newData) external {
        data = _newData;
    }
}
```

首先要将合约部署到主网或测试网，因为 Quick Dab 需要公共网络。这里选择 Ephemery。