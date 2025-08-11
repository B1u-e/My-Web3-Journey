// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/*

Alice创建了一个猜测游戏。
如果您能找到正确的字符串，将其哈希为目标哈希，则可以赢得10个以太。让我们看看这个合同如何容易受到前置交易攻击的影响。
*/

/*
1. Alice使用10个以太部署了FindThisHash。
2. Bob找到了正确的字符串，可以哈希成目标哈希值。（“以太坊”）
3. Bob调用solve（“以太坊”），以15个gwei的燃气价格设置。
4. Eve正在观察交易池，等待答案提交。
5. Eve看到了Bob的答案，并以比Bob更高的燃气价格（100个gwei）调用solve（“以太坊”）。
6. Eve的交易在Bob的交易之前被挖掘。Eve赢得了10个以太的奖励。

发生了什么？

交易需要一些时间才能被挖掘。尚未被挖掘的交易会被放入交易池中。通常，具有更高燃气价格的交易会优先被挖掘。攻击者可以从交易池中获取答案，发送一笔具有更高燃气价格的交易，以便他们的交易将在原始交易之前被包含在一个块中。
*/

contract FindThisHash {
    bytes32 public constant hash =
        0x564ccaf7594d66b1eaaea24fe01f0585bf52ee70852af4eac0cc4b04711cd0e2;

    constructor() payable {}

    function solve(string memory solution) public {
        require(hash == keccak256(abi.encodePacked(solution)), "Incorrect answer");

        (bool sent, ) = msg.sender.call{value: 10 ether}("");
        require(sent, "Failed to send Ether");
    }
}


