// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

contract buildintx {
    address public origin;
    uint256 public gasprice;

    constructor() {
        origin = tx.origin;
        gasprice = tx.gasprice;
    }
}