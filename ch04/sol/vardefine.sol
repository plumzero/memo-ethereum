// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract vardefine {
    uint256 public AuthAge;
    bytes32 public AuthHash;
    string public AuthName;
    uint256 AuthSal;

    constructor(uint256 _age, string memory _name, uint256 _sal) {
        AuthAge = _age;
        AuthName = _name;
        AuthSal = _sal;
        
        AuthHash = keccak256(abi.encode(AuthAge, AuthName, AuthSal));
    }
}