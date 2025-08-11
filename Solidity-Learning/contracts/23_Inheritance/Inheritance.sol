// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/* 继承关系图
    A
   / \
  B   C
 / \ /
F  D,E

*/

contract A {
    function foo() public pure virtual returns (string memory) {
        return "A";
    }
}

// 合约通过使用关键字 'is' 继承其他合约
contract B is A {
    // 覆盖 A.foo()
    function foo() public pure virtual override returns (string memory) {
        return "B";
    }
}

contract C is A {
    // 覆盖 A.foo()
    function foo() public pure virtual override returns (string memory) {
        return "C";
    }
}

// 合约可以从多个父合约继承。
// 当调用在不同合约中多次定义的函数时，
// 父契约将从右向左搜索，并以深度优先的方式进行搜索。
contract D is B, C {
    // D.foo() 返回 "C"
    // 因为 C 是带有函数 foo() 的最右侧的父合约
    function foo() public pure override(B, C) returns (string memory) {
        return super.foo();
    }
}

contract E is C, B {
    // E.foo() 返回 "B"
    // 因为 B 是带有函数 foo() 的最右侧的父合约
    function foo() public pure override(C, B) returns (string memory) {
        return super.foo();
    }
}

// 继承必须按照从“most base-like” 的到 “most derived”的顺序进行排序。
// 交换 A 和 B 的顺序将会导致编译错误。
contract F is A, B {
    function foo() public pure override(A, B) returns (string memory) {
        return super.foo();
    }
}

