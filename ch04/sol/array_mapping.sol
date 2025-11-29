// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

contract array_demo {
    // 定义 address 与姓名的 mapping
    mapping(address => string) public addr_names;
    
    constructor() {
        addr_names[msg.sender] = "yekai";
    }
    
    // 设置地址对应的姓名
    function setNames(string calldata _name) public {
        addr_names[msg.sender] = _name;
    }
}