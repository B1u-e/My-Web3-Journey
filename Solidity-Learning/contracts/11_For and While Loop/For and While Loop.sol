// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Loop {
    function loop() public {
        // for循环
        for (uint i = 0; i < 10; i++) {
            if (i == 3) {
                // 使用continue跳到下一次迭代
                continue;
            }
            if (i == 5) {
                // 使用break退出循环
                break;
            }
        }

        // 循环结构
        uint j;
        while (j < 10) {
            j++;
        }
    }
}