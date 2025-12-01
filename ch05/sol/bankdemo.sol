// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

contract bank_demo {
    string public bankName;
    uint256 totalAmount;
    address public admin;
    mapping(address => uint256) balances;
    
    constructor(string memory _name) {
        bankName = _name;
        admin = msg.sender;
    }

    function getBalance() public view returns (uint256, uint256) {
        return (address(this).balance, totalAmount);
    }

    function balanceOf(address _who) public view returns(uint256) {
        return balances[_who];
    }

    // 存款
    function deposit(uint256 _amount) public payable {
        require(_amount > 0, "amount must > 0");
        require(msg.value == _amount, "msg.value must equal to amount");
        
        balances[msg.sender] += _amount;
        totalAmount += _amount;
        require(address(this).balance == totalAmount, "bank's balance must ok");
    }

    // 取款
    function withdraw(uint256 _amount) public payable {
        require(_amount > 0, "amount must > 0");
        require(balances[msg.sender] >= _amount, "user's balance not enough");

        balances[msg.sender] -= _amount;
        (bool success, ) = msg.sender.call{value: _amount}("");
        require(success, "call failed");
        totalAmount -= _amount;
        require(address(this).balance == totalAmount, "bank's balance must ok");
    }

    // 转账
    function transfer(address _to, uint256 _amount) public {
        require(_amount > 0, "amount must > 0");
        require(address(0) != _to, "to address must valid");
        require(balances[msg.sender] >= _amount, "user's balance not enough");

        balances[msg.sender] -= _amount;
        balances[_to] += _amount;
        require(address(this).balance == totalAmount, "bank's balance must ok");
    }
}