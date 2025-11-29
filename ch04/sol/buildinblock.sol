// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

contract localobj {
    uint256 public number;
    address public coinbase;
    uint256 public gaslimit;
    uint256 public chainid;
    uint256 public basefee;
    bytes32 public hash;
    bytes32 public prevhash;

    constructor() {
        number = block.number;
        coinbase = block.coinbase;
        gaslimit = block.gaslimit;
        chainid = block.chainid;
        basefee = block.basefee;
        hash = blockhash(number);
        prevhash = blockhash(number - 1);
    }
}