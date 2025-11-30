// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

contract calldemo {
    uint256 count;

    constructor() {
        count = 2026;
    }

    function setCount(uint256 _count) external {
        count = _count;
    }

    function getCount() public view returns(uint256) {
        return count;
    }
}