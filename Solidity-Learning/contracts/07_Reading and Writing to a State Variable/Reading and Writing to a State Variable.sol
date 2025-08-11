// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract SimpleStorage {
    // 存储数字的状态变量
    uint public num;

    // 您需要发送交易才能写入状态变量
    function set(uint _num) public {
        num = _num;
    }

    // 您可以在不发送交易的情况下从状态变量中读取。
    function get() public view returns (uint) {
        return num;
    }
}