// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

struct Bank {
    string name;
    uint256 amount;
}

contract data_demo {
    Bank bank;
    
    constructor(string memory _name, uint256 _amount) {
        bank.name = _name;
        bank.amount = _amount;
    }

    function getBank() public view returns (Bank memory) {
        return bank;
    }
}

contract call_demo {
    data_demo data; // 引用前一个合约的数据

    // 构造时，指定前一个合约的地址
    constructor(address addr) {
        data = data_demo(addr);
    }

    // 合约可以对 data_demo 的地址进行更新
    function upgrade(address _addrV2) public {
        data = data_demo(_addrV2);
    }

    // 调用 data_demo 的 getBank 方法
    function getData() public view returns (Bank memory) {
        return data.getBank();
    }
}