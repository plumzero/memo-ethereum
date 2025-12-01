// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

import "./libstring.sol";

contract library_test_demo {
    using libstring for string;

    function isMyEqual(string memory a, string memory b) public pure returns(bool) {
        return a.isEqual(b); // 第一种方式
    }

    function testStrcat(string memory a, string memory b) public pure returns(string memory) {
        return libstring.strcat(a, b); // 第二种方式
    }
}