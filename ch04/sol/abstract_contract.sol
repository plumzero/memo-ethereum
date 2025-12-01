// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

abstract contract B {
    address admin;
    uint256 totalAmount;
    
    constructor(address _addr, uint256 _amount) {
        admin = _addr;
        totalAmount = _amount;
    }
}

contract C is B(msg.sender, 1000) {
    function cTestFunc() public {}
}