// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

contract pass_demo {
    struct User {
        string name;
        uint256 age;
    }

    User public adminUser;

    constructor() {
        adminUser.name = "xiaoming";
        adminUser.age = 20;
    }

    function setAgeByVal(uint256 _age) public {
        // 值传递，user 是 adminUser 的一个拷贝，adminUser 的 age 不会被修改
        User memory user = adminUser;
        user.age = _age;
    }

    function setAgeByRef(uint256 _age) public {
        // 值传递，user 是 adminUser 的引用(实际上 user 就是 adminUser)，adminUser 的 age 会被修改
        User storage user = adminUser;
        user.age = _age;
    }
}