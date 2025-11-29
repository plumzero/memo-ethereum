// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

contract buildinaddress {
    uint256 public balance;
    bytes public code;
    uint256 public codeLength;
    uint256 public account_balance;

    constructor() {
        balance = address(this).balance;
        code = address(this).code;
        codeLength = address(this).code.length;
        account_balance = msg.sender.balance;
    }
}