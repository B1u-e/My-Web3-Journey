// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Variables {
    // 状态变量存储在区块链上.
    string public text = "Hello";
    uint public num = 123;

    function doSomething() public {
        // 局部变量不会保存到区块链上。
        uint i = 456;

        // 这里是一些全局变量。
        uint timestamp = block.timestamp; // 当前区块时间戳
        address sender = msg.sender; // 来电者的地址
    }
}
