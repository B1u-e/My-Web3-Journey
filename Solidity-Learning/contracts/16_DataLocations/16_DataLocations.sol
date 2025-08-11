// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract DataLocations {
    uint[] public arr;
    mapping(uint => address) map;
    struct MyStruct {
        uint foo;
    }
    mapping(uint => MyStruct) myStructs;

    function f() public {
        // 使用状态变量调用_f函数。
        _f(arr, map, myStructs[1]);

        // 从映射中获取一个结构体
        MyStruct storage myStruct = myStructs[1];
        // 在内存中创建一个结构体。
        MyStruct memory myMemStruct = MyStruct(0);
    }

    function _f(
        uint[] storage _arr,
        mapping(uint => address) storage _map,
        MyStruct storage _myStruct
    ) internal {
        // 使用存储变量执行某些操作。
    }

    // 可以返回内存变量
    function g(uint[] memory _arr) public returns (uint[] memory) {
        // 使用memory数组执行某些操作。
    }

    function h(uint[] calldata _arr) external {
        // 使用calldata数组执行某些操作。
    }
}
