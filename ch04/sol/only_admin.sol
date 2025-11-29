// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

contract only_admin {
    address public admin;   // 合约管理员
    uint256 public amount;

    constructor() {
        admin = msg.sender;
        amount = 0;
    }

    modifier onlyadmin() {
        require(admin == msg.sender, "only admin can do this");
        _;
    }

    function setCount(uint256 _amount) public onlyadmin {
        amount = _amount;
    }
}