// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v5.5.0/contracts/utils/math/Math.sol";

contract safecalc {
    using Math for uint256;
    uint256 public amount = 100;

    constructor() {
        bool success;
        (success, amount) = amount.tryAdd(10);
        require(success, "tryAdd failed");
    }
}