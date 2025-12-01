// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

interface IUser {
    function addUser(string memory _name, uint8 _age) external;
    function getUser(string memory _name) external view returns (string memory, uint8);
}

contract test_IUser {
    function addUser(string memory _name, uint8 _age) external {}
    function getFuncSig() public pure returns(bytes4, bytes4) {
        bytes4 addUserSig = bytes4(keccak256("addUser(string,uint8)"));
        return (addUserSig, IUser.addUser.selector);
    }
}