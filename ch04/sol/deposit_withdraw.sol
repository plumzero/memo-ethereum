// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

contract ETHWallet {
    // 键表示外部账户地址，值表示该账户地址在合约中的 ETH 数量(单位是 Wei)
    mapping(address => uint256) private balances;
    
    // 定义了两个(日志)事件，分别在 deposit 和 withdraw 时触发(emit)
    event Deposited(address indexed user, uint256 amount);
    event Withdrawn(address indexed user, uint256 amount);
    
    // 定义存入函数
    function deposit() public payable {
        require(msg.value > 0, "Deposit amount must be greater than 0");
        balances[msg.sender] += msg.value;
        emit Deposited(msg.sender, msg.value);
    }

    // 定义取出函数
    function withdraw(uint256 amount) external {
        require(amount > 0, "Withdrawal amount must be greater than 0");
        require(balances[msg.sender] >= amount, "Insufficient balance");
        
        balances[msg.sender] -= amount; // 先更新余额，防止重入攻击
        (bool success, ) = msg.sender.call{value: amount}(""); // 发送 ETH 给用户(调用者)
        require(success, "ETH transfer failed");
        
        emit Withdrawn(msg.sender, amount);
    }
    
    // 查看合约总余额
    function getContractBalance() external view returns (uint256) {
        return address(this).balance;
    }
    
    // 查看用户余额
    function getUserBalance(address user) external view returns (uint256) {
        return balances[user];
    }

    // 纯ETH转账(send、transfer、call时调用) → 正常存款
    // send、transfer 由于固定 gas 费用(2300)，目前已经不推荐使用，因为 EIP-1884 增加了 gas 成本
    // call 可以指定 gas 成本，但需要对结果进行检查，且需要手动防重入
    receive() external payable {
        deposit();
    }
    
    // 调用不存在函数 → 回滚
    fallback() external payable {
        revert("Function does not exist");
    }
}