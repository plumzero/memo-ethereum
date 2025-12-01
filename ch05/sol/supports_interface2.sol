// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

interface IERC165 {
    function supportsInterface(bytes4 interfaceID) external view returns(bool);
}

interface Simpson {
    function is2D() external returns(bool);
    function skinColor() external returns(string memory);
}

contract ERC165 is IERC165 {
    mapping(bytes4 => bool) supportedInterfaces; // 对外不可见

    constructor() {
        supportedInterfaces[IERC165.supportsInterface.selector] = true;
    }

    function supportsInterface(bytes4 interfaceID) override external view virtual returns(bool) {
        return supportedInterfaces[interfaceID];
    }
}

contract Lisa is ERC165, Simpson {

    constructor() {
        supportedInterfaces[Simpson.is2D.selector ^ Simpson.skinColor.selector] = true;
    }

    function supportsInterface(bytes4 interfaceID) override external view returns(bool) {
        return supportedInterfaces[interfaceID];
    }

    function debug() external pure returns(bytes4) {
        return Simpson.is2D.selector ^ Simpson.skinColor.selector;
    }

    function is2D() override external returns(bool) {}
    function skinColor() override external returns(string memory) {}
}