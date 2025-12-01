// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

interface IUser {
    function addUser(string memory _name, uint8 _age) external;
    function getUser(string memory _name) external view returns (string memory, uint8);
}

contract idcalc {
    function getInterfaceId() public pure returns (bytes4, bytes4) {
        bytes4 interfaceId = IUser.addUser.selector ^ IUser.getUser.selector;
        return (interfaceId, type(IUser).interfaceId);
    }
}