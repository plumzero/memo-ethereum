// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

contract bet {
    address public owner;
    bool isFinished; // 游戏结束标志

    struct Player {
        address addr;
        uint amount;
    }

    Player[] inBig; // 押大的人
    Player[] inSmall; // 押小的人

    uint totalBig;
    uint totalSmall;
    uint latesttime;

    constructor() {
        owner = msg.sender;
        totalBig = 0;
        totalSmall = 0;
        isFinished = false;
        latesttime = block.timestamp;
    }

    function stake(bool flag) public payable returns (bool) {
        require(msg.value > 0, "msg.value must greater than 0");

        Player memory p = Player(msg.sender, msg.value);
        if (flag) {
            inBig.push(p);
            totalBig += p.amount;
        } else {
            inSmall.push(p);
            totalSmall += p.amount;
        }

        return true;
    }

    function open() public payable returns(bool) {
        require(block.timestamp > latesttime + 20, "open must after 20s"); // 开奖时间必须在合约创建 20s 后
        require(!isFinished, "open must not finished");
        // 求一个 18 以内的随机值，0~8开小，9~17开大
        uint point = uint(keccak256(abi.encode(msg.sender, block.timestamp, block.number))) % 18;
        uint i = 0;
        Player memory p;
        if (point >= 9) {
            // 开大: 退还下大的人本金+奖金
            for (i = 0; i < inBig.length; i++) {
                p = inBig[i];
                (bool success, ) = p.addr.call{value: p.amount + totalSmall * p.amount / totalBig}("");
                require(success, "call failed");
            }
        } else {
            // 开小: 退还下小的人本金+奖金
            for (i = 0; i < inSmall.length; i++) {
                p = inSmall[i];
                (bool success, ) = p.addr.call{value: p.amount + totalBig * p.amount / totalSmall}("");
                require(success, "call failed");
            }
        }

        isFinished = true;

        return true;
    }
}