// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// 创建合约X
contract X {
    string public name;

    constructor(string memory _name) {
        name = _name;
    }
}

// 创建合约Y
contract Y {
    string public text;

    constructor(string memory _text) {
        text = _text;
    }
}

// 有两种方法可以使用参数初始化父合约。
// 在继承列表中传递参数。
contract B is X("Input to X"), Y("Input to Y") {

}

contract C is X, Y {
    // 在构造函数中传递参数，类似于函数修饰器。
    constructor(string memory _name, string memory _text) X(_name) Y(_text) {}
}

// 父类构造函数始终按照继承顺序调用，不受子合约构造函数中列出的父合约顺序的影响。
// 构造函数被调用的顺序：
// 1. X
// 2. Y
// 3. D
contract D is X, Y {
    constructor() X("X was called") Y("Y was called") {}
}

// 构造函数被调用的顺序：
// 1. X
// 2. Y
// 3. E
contract E is X, Y {
    constructor() Y("Y was called") X("X was called") {}
}
