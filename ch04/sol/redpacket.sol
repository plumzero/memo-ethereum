// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

contract redpacket {
    address public admin;
    uint256 public number; // 红包数量

    constructor(uint256 _number) payable {
        admin = msg.sender;
        number = _number;
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    // 抢红包
    function stakeMoney() public payable returns (bool) {
        require(number > 0);
        require(getBalance() > 0);
        number--;
        // 取 0~100 以内的随机值
        uint256 random = uint256(keccak256(abi.encode(block.timestamp, msg.sender, "admin"))) % 100;
        uint256 balance = getBalance();
        uint256 amount = balance * random / 100;
        // 发送给抢红包的人，也就是调用者
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "stakeMoney failed");
    
        return true;
    }

    // 清空资产
    function clear() public {
        require(msg.sender == admin);
        // 转移所有 ETH
        uint256 amount = getBalance();
        (bool success,) = payable(admin).call{value: amount}("");
        require(success, "clear failed");
        // 重置关键状态，防止误用
        admin = address(0);
        number = 0;
    }
}