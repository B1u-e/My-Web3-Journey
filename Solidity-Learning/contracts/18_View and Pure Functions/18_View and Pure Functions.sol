// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract ViewAndPure {
    uint public x = 1;

    // 承诺不修改状态。
    function addToX(uint y) public view returns (uint) {
        return x + y;
    }

    // 承诺不修改或读取状态。
    function add(uint i, uint j) public pure returns (uint) {
        return i + j;
    }
}
