// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

interface IA {
    function setName(string memory _name) external;
    function getName() external view returns (string memory);
}

contract A is IA {
    string name;

    function setName(string memory _name) override external  {
        name = _name;
    }

    function getName() override external view returns (string memory) {
        return name;
    }
}

contract upgrade {
    IA a;

    constructor(address addr) {
        a = IA(addr);
    }

    function update(address addr) public {
        a = IA(addr);
    }

    function setName(string memory _name) public {
        a.setName(_name);
    }

    function getName() public view returns (string memory) {
        return a.getName();
    }
}