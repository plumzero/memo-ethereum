// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

contract A {
    string name;
    uint256 count;

    function setName(string memory _name, uint256 _count) public returns (bool) {
        name = _name;
        count = _count;
        if (count <= 2000) return false;
        return true;
    }

    function getName() public view returns (string memory) {
        return name;
    }
}

contract callA {
    // 调用 A 合约的 setName
    function setName(address _addr, string memory _name, uint256 _count) public {
        // A(_addr) 相当于得到了 A 合约对象
        A(_addr).setName(_name, _count);
    }

    function getName(address _addr) public view returns (string memory) {
        return A(_addr).getName();
    }
}