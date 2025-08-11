// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Gas {
    uint public i = 0;

    // 使用完所有gas会使交易失败.
    // 状态更改被撤消.
    // 消耗的gas不会退回.
    function forever() public {
        // 这里是个while循环，直到所有gas消耗完并导致交易失败
        while (true) {
            i += 1;
        }
    }
}