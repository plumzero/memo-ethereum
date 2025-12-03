// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

// 资产合约
contract Asset {
    address public issuer;
    string public symbol;
    mapping(address => uint256) public balanceOf;
    // 资产转移时触发
    event Sent(address from, address to, uint256 amount);

    constructor(string memory _sym, address _issuer) {
        issuer = _issuer;
        symbol = _sym;
    }

    // 发行资产
    function issue(address _receiver, uint256 _amount) public {
        require(msg.sender == issuer, "only issuer can do");
        balanceOf[_receiver] += _amount;
        emit Sent(address(0), _receiver, _amount);
    }
}

contract Factory {
    mapping(string => address) assets;

    // 创建资产
    function newAsset(string memory _sym, string memory _version) public {
        require(assets[_version] == address(0), "version already exists");
        Asset asset = new Asset(_sym, msg.sender);
        assets[_version] = address(asset);
    }

    // 通过版本获得各个资产合约的地址
    function getAsset(string memory _version) public view returns (address) {
        return assets[_version];
    }
}