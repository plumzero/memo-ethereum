// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

contract array_demo {
    // 字符串类型定长数组
    string[5] internal names;
    // 数值类型动态数组
    uint256[] internal ages;

    constructor() {
        names[0] = "plumzero";
        ages.push(10);
    }

    function getLength() public view returns(uint256, uint256) {
        return (names.length, ages.length);
    }
}