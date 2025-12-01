// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

contract revert_demo {
    uint256 public count = 1000;

    function setCount(uint256 _c) public {
        count = _c;
        if (count < 2000) {
            revert();
        }
    }
}