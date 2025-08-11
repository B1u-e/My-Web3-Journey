// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/*
轮盘是一种游戏，您可以在特定时间提交交易以赢取合同中的所有以太。
玩家需要发送10 Ether，如果block.timestamp％15 == 0，则赢了。
*/

/*
1. 使用10 Ether部署轮盘
2. Eve运行一个强大的矿工，可以操纵块时间戳。
3. Eve将block.timestamp设置为未来的一个可以被15整除的数字，并找到目标块哈希。
4. Eve的块成功包含在链中，Eve赢得了轮盘游戏。
*/

contract Roulette {
    uint public pastBlockTime;

    constructor() payable {}

    function spin() external payable {
        require(msg.value == 10 ether); // must send 10 ether to play
        require(block.timestamp != pastBlockTime); // only 1 transaction per block

        pastBlockTime = block.timestamp;

        if (block.timestamp % 15 == 0) {
            (bool sent, ) = msg.sender.call{value: address(this).balance}("");
            require(sent, "Failed to send Ether");
        }
    }
}
