// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Counter {
    uint public count;

    // 获取当前计数的函数
    function get() public view returns (uint) {
        return count;
    }

    // 计数增加1的函数
    function inc() public {
        count += 1;
    }

    // 计数减少1的函数
    function dec() public {
        // 如果计数为0，这个函数将会失败。
        count -= 1;
    }
}