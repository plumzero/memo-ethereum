// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

contract require_assert {

    function deposit(uint256 _amount) public payable {
        // 判断用户输入金额是否与 msg.value 相同
        require(msg.value == _amount, "msg.value must equal equal _amount");
        // 断言 _amount 大于 0，否则扣光 gaslimit
        assert(_amount > 0);
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}