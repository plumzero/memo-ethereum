// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

interface IERC165 {
    function supportsInterface(bytes4 interfaceID) external view returns(bool);
}

contract ERC165 is IERC165 {
    mapping(bytes4 => bool) supportedInterfaces; // 对外不可见

    constructor() {
        supportedInterfaces[IERC165.supportsInterface.selector] = true;
    }

    function debug() external pure returns(bytes4) {
        return IERC165.supportsInterface.selector;
    }

    function supportsInterface(bytes4 interfaceID) override external view returns(bool) {
        return supportedInterfaces[interfaceID];
    }
}