// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Mapping {
    // 将地址映射为无符号整数uint.
    mapping(address => uint) public myMap;

    function get(address _addr) public view returns (uint) {
        // 映射始终返回一个数值。
        // 如果从未设置该数值，则会返回默认数值。
        return myMap[_addr];
    }

    function set(address _addr, uint _i) public {
        // 更新此地址的数值。
        myMap[_addr] = _i;
    }

    function remove(address _addr) public {
        // 将数值重置为默认数值。
        delete myMap[_addr];
    }
}

contract NestedMapping {
    // 嵌套映射（从地址映射到另一个映射）
    mapping(address => mapping(uint => bool)) public nested;

    function get(address _addr1, uint _i) public view returns (bool) {
        // 你可以从嵌套映射中获取值。
        // 即使它没有被初始化。
        return nested[_addr1][_i];
    }

    function set(address _addr1, uint _i, bool _boo) public {
        nested[_addr1][_i] = _boo;
    }

    function remove(address _addr1, uint _i) public {
        delete nested[_addr1][_i];
    }
}
