// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Payment {
    mapping(address => uint) public balances;
    address[] public users;

    function addBalance() public payable {
        require(msg.value > 0, "You need to send some Ether");
        if (balances[msg.sender] == 0) {
            users.push(msg.sender);
        }
        balances[msg.sender] += msg.value;
    }

    function getBalance(address user) public view returns (uint) {
        return balances[user];
    }

    function withdraw(uint amount) public {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }

    function transfer(address to, uint amount) public {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        if (balances[to] == 0) {
            users.push(to);
        }
        balances[msg.sender] -= amount;
        balances[to] += amount;
    }

    function getTotalBalance() public view returns (uint) {
        uint totalBalance = 0;
        for (uint i = 0; i < users.length; i++) {
            totalBalance += balances[users[i]];
        }
        return totalBalance;
    }
}
