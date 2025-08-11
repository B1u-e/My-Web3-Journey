// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Primitives {
    bool public boo = true;

    /*
    uint代表无符号整数，即非负整数，有不同的大小可用：
        uint8   的范围是 0 to 2 ** 8 - 1
        uint16  的范围是 0 to 2 ** 16 - 1
        ...
        uint256 的范围是 0 to 2 ** 256 - 1
    */
    uint8 public u8 = 1;
    uint public u256 = 456;
    uint public u = 123; // uint是uint256的别名

    /*
    int类型允许负数。
    与uint一样，从int8到int256有不同的范围可用。
    
    int256 的范围从 -2 ** 255 to 2 ** 255 - 1
    int128 的范围从 -2 ** 127 to 2 ** 127 - 1
    */
    int8 public i8 = -1;
    int public i256 = 456;
    int public i = -123; // int is same as int256

    // int的最小值和最大值
    int public minInt = type(int).min;
    int public maxInt = type(int).max;

    address public addr = 0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c;

    /*
    在Solidity中，数据类型byte表示一系列字节。
    Solidity有两种类型的字节类型：

     - 固定大小的字节数组
     - 动态大小的字节数组。
     
     在Solidity中，术语bytes表示一个动态字节数组。
     它是byte[]的简写。
    */
    bytes1 a = 0xb5; //  [10110101]
    bytes1 b = 0x56; //  [01010110]

    // 用enum将uint 0， 1， 2表示为Buy, Hold, Sell
    enum ActionSet { Buy, Hold, Sell }
    // 创建enum变量 action
    ActionSet action = ActionSet.Buy;

    // 默认值
    // 未分配的变量有一个默认值
    bool public defaultBoo; // false
    uint public defaultUint; // 0
    int public defaultInt; // 0
    address public defaultAddr; // 0x0000000000000000000000000000000000000000
}