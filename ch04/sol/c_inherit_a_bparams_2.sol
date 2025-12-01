// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

contract A {
    uint256 count;
    
    function setCount(uint256 _count) external {
        count = _count;
    }

    function getCount() external view returns(uint256) {
        return count;
    }
}

contract B {
    address admin;
    uint256 totalAmount;
    
    constructor(address _addr, uint256 _amount) {
        admin = _addr;
        totalAmount = _amount;
    }
}

contract C is A, B(msg.sender, 1000) {
    function cTestFunc() public {}
}