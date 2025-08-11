// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Event {
    // 事件声明
    // 最多可以有3个参数被索引。
    // 索引的参数可以帮助你通过索引参数过滤日志
    event Log(address indexed sender, string message);
    event AnotherLog();

    function test() public {
        emit Log(msg.sender, "Hello World!");
        emit Log(msg.sender, "Hello EVM!");
        emit AnotherLog();
    }
}