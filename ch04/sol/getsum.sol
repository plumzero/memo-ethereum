// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

contract getsum {
    function getSum(uint256 num) public pure returns (uint256) {
        uint256 sum = 0;

        for (uint256 i = 1; i <= num; i++) {
            sum += i;
        }
        return sum;
    }
}