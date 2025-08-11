// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract ArrayReplaceFromEnd {
    uint[] public arr;

    // 删除一个元素会在数组中创建一个间隙.
    // 保持数组紧凑的一个技巧是将最后一个元素移动到要删除的位置.
    function remove(uint index) public {
        // 将最后一个元素移动到要删除的位置。
        arr[index] = arr[arr.length - 1];
        // 移除最后一个元素
        arr.pop();
    }

    function test() public {
        arr = [1, 2, 3, 4];

        remove(1);
        // [1, 4, 3]
        assert(arr.length == 3);
        assert(arr[0] == 1);
        assert(arr[1] == 4);
        assert(arr[2] == 3);

        remove(2);
        // [1, 4]
        assert(arr.length == 2);
        assert(arr[0] == 1);
        assert(arr[1] == 4);
    }
}