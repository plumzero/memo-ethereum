// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

struct StorageInfo {
    address owner;
    address addr;   // 合约地址
    uint16 version; // 合约版本
}

contract register {
    mapping(string => StorageInfo) public storageInfos;

    function newStorage(string memory _name, address _addr, uint16 _version) public {
        StorageInfo memory info = storageInfos[_name];
        require(info.version < _version, "version must ok");
        if (info.owner != address(0)) { // 若存在，更新
            info.version = _version;
            info.addr = _addr;
        } else { // 若不存在，添加
            info.owner = msg.sender;
            info.addr = _addr;
            info.version = _version;
        }
        storageInfos[_name] = info;
    }
}