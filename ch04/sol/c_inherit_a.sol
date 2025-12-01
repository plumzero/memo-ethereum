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

contract C is A {
    function cTestFunc() public {}
}