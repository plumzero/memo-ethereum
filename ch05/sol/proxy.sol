// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

// 存储结构合约
abstract contract storageStructure {
    address internal implementation; // 逻辑合约地址
    mapping(address => uint256) public points;
    uint256 public totalPlayers;
    address internal owner;
}

contract implementationV1 is storageStructure {
    modifier onlyowner() {
        require(msg.sender == owner, "only owner can do");
        _;
    }

    function addPlayer(address player, uint256 point) public onlyowner virtual {
        require(points[player] == 0, "player already exists");
        points[player] = point;
    }

    function setPlayer(address player, uint256 point) public onlyowner {
        require(points[player] != 0, "player must already exists");
        points[player] = point;
    }
}

contract implementationV2 is implementationV1 {
    function addPlayer(address player, uint256 point) override public onlyowner {
        require(points[player] == 0, "player already exists");
        points[player] = point;
        totalPlayers++;
    }
}

contract proxy is storageStructure {
    constructor() {
        owner = msg.sender;
    }

    function setImpl(address impl) public {
        implementation = impl;
    }

    fallback() external {
        require(implementation != address(0), "implementation must already exists");
        (bool success, ) = implementation.delegatecall(msg.data);
        require(success, "delegatecall failed");
    }
}