// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

contract eventdemo {
    struct User {
        string name;
        uint256 age;
    }

    User public adminUser;

    event setAged(address _owner, uint256 _age);

    constructor() {
        adminUser.name = "plumzero";
        adminUser.age = 40;
    }

    function setAge(uint256 _age) public {
        User storage user = adminUser;
        user.age = _age;

        emit setAged(msg.sender, _age);
    }
}