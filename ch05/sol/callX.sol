// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

contract A {
    string name;
    uint256 count;

    function setName(string memory _name, uint256 _count) public returns (bool) {
        name = _name;
        count = _count;
        if (count <= 2000) return false;
        return true;
    }

    function getName() public view returns (string memory) {
        return name;
    }
}

contract callX {
    
    function setName(address _addr, string memory _name, uint256 _count) public {
        (bool success, ) = _addr.call(abi.encodeWithSignature("setName(string,uint256)", _name, _count));
        require(success, "call setName failed");
    }

    function getName(address _addr) public returns (string memory) {
        (bool success, bytes memory name) = _addr.call(abi.encodeWithSignature("getName()"));
        require(success, "call getName failed");
        return abi.decode(name, (string));
    }
}