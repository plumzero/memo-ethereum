// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

contract mapping_demo {
    // 定义 address 与姓名的 mapping
    mapping(address => string) public addr_names;
    
    constructor() {
        addr_names[msg.sender] = "plumzero";
    }
    
    // 设置地址对应的姓名
    function setNames(string calldata _name) public {
        addr_names[msg.sender] = _name;
    }

    // 使用 delete 关键字并提供键就可以删除映射中的数据
    function delName() public {
        delete addr_names[msg.sender];
    }
}