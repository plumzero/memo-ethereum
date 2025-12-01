// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

contract auction {
    address payable public seller; // 委托人
    address public auctioneer; // 拍卖师
    address payable public buyer; // 记录最高出价者地址，也是最终的买受人
    uint public auctionAmount; // 当前最高金额
    uint auctionEndTime; // 拍卖结束时间点
    bool isFinished; // 拍卖结束标志

    constructor(address payable _seller, uint _duration) {
        seller = _seller;
        auctioneer = msg.sender;
        auctionEndTime = _duration + block.timestamp;
        isFinished = false;
    }

    modifier onlyauctioneer() {
        require(auctioneer == msg.sender, "only admin can do this");
        _;
    }

    // 竞拍
    function bid() public payable {
        require(!isFinished);
        require(block.timestamp < auctionEndTime);
        require(msg.value > auctionAmount);
        if (auctionAmount > 0 && msg.sender != buyer) {
            (bool success, ) = buyer.call{value: auctionAmount}("");
            require(success, "call failed");
        }
        // 更新买家
        buyer = payable(msg.sender);
        auctionAmount = msg.value;
    }

    // 结束竞拍
    function auctionEnd() public payable onlyauctioneer {
        require(block.timestamp >= auctionEndTime);
        require(!isFinished);
        
        isFinished = true;

        (bool success, ) = seller.call{value: auctionAmount}("");
        require(success, "call failed");
    }
}