// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

contract depositeth {
    address public admin;

    constructor() {
        admin = msg.sender;
    }

    function deposit() public payable {
        // nothing to do
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}