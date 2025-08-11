// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Array {
    // 初始化数组的几种方式
    uint[] public arr;
    uint[] public arr2 = [1, 2, 3];
    // 固定长度的数组，所有元素都初始化为0
    uint[10] public myFixedSizeArr;

    function get(uint i) public view returns (uint) {
        return arr[i];
    }

    // Solidity 可以返回整个数组.
    //但是对于长度可能无限增长的数组，应该避免使用该函数。
    function getArr() public view returns (uint[] memory) {
        return arr;
    }

    function push(uint i) public {
        // 向数组添加元素,这将增加数组的长度1。
        arr.push(i);
    }

    function pop() public {
        // 删除数组中的最后一个元素,这将使数组长度减少1
        arr.pop();
    }

    function getLength() public view returns (uint) {
        return arr.length;
    }

    function remove(uint index) public {
        // 删除操作不会改变数组的长度。
        //它将索引处的值重置为其默认值，在这种情况下为0。
        delete arr[index];
    }

    function examples() external {
        // 在内存中创建数组，只能创建固定大小的数组
        uint[] memory a = new uint[](5);
    }
}