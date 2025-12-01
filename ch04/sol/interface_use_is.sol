// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

interface IUser {
    function addUser(string memory _name, uint8 _age) external;
    function getUser(string memory _name) external view returns(string memory, uint8);
}

contract User is IUser {
    function addUser(string memory _name, uint8 _age) external override {}
    function getUser(string memory _name) external override view returns(string memory, uint8) {}
}