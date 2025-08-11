// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Immutable {
    // 将编码规范转换为大写的常量变量
    address public immutable MY_ADDRESS;
    uint public immutable MY_UINT;

    constructor(uint _myUint) {
        MY_ADDRESS = msg.sender;
        MY_UINT = _myUint;
    }
}
