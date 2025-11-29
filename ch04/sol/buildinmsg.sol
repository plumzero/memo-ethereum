// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

contract buildinmsg {
    address public sender;
    uint256 public value;
    bytes public data;
    uint256 public gas;
    bytes4 public sig;

    constructor() payable {
        sender = msg.sender;
        value = msg.value;
        data = msg.data;
        gas = gasleft(); // 剩余gas (不是msg的属性，但相关)
        sig = msg.sig;
    }
}