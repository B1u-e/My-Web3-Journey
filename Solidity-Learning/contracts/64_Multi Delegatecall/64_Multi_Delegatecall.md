# 64.Multi Delegatecall
Multi Delegatecall是一种Solidity中的特殊函数调用方式，它允许在一个合约内调用多个函数，从而可以简化复杂的操作。
Multi Delegatecall的特点是将调用的函数合并在一起，共享合约状态，但是不会改变调用合约的上下文，即不会改变合约地址和合约存储状态。
这种调用方式通常用于合约库的实现，可以将多个函数合并在一起，从而减少调用次数和gas消耗。
但是需要注意的是，Multi Delegatecall需要确保调用的函数在同一合约中，且需要保证函数签名和参数类型一致。

使用delegatecall在单个交易中调用多个函数的示例。


* MultiDelegatecall 是一个用于执行多个 delegatecall 的合约。
它接受一个包含多个字节数组的参数，每个字节数组都是一个要执行的 delegatecall 的数据。合约会依次执行每个 delegatecall，如果其中任何一个失败，整个过程都会回滚并抛出 DelegatecallFailed 错误。
该合约的目的是为了提高执行多个 delegatecall 的效率和安全性。
```solidity
contract MultiDelegatecall {
    error DelegatecallFailed();

    function multiDelegatecall(
        bytes[] memory data
    ) external payable returns (bytes[] memory results) {
        results = new bytes[](data.length);

        for (uint i; i < data.length; i++) {
            (bool ok, bytes memory res) = address(this).delegatecall(data[i]);
            if (!ok) {
                revert DelegatecallFailed();
            }
            results[i] = res;
        }
    }
}
```

* TestMultiDelegatecall 是一个演示合约，其中包含了三个函数：func1、func2 和 mint。
其中，func1 和 func2 是普通的函数，而 mint 是一个可以接受 ETH 的函数。mint 函数存在一个漏洞，即一个用户可以多次调用该函数来铸造代币，这可能导致合约中的代币数量超过预期。
因此，在与多个 delegatecall 结合使用时，该合约存在不安全性。
```solidity
// 为什么要使用多个delegatecall？为什么不使用多个call？
// Alice -> MultiCall --- call ---> Test (msg.sender = MultiCall)
// Alice -> Test --- delegatecall ---> Test (msg.sender = Alice)
contract TestMultiDelegatecall is MultiDelegatecall {

    event Log(address caller, string func, uint i);

    function func1(uint x, uint y) external {
        // msg.sender = alice
        emit Log(msg.sender, "func1", x + y);
    }

    function func2() external returns (uint) {
        // msg.sender = alice
        emit Log(msg.sender, "func2", 2);
        return 111;
    }

    mapping(address => uint) public balanceOf;

    // 当与多个delegatecall结合使用时，代码存在不安全性。
    // 用户可以以msg.value的价格多次铸造。
    function mint() external payable {
        balanceOf[msg.sender] += msg.value;
    }
}
```

* Helper 是一个辅助合约，其中包含三个函数，分别返回 func1、func2 和 mint 函数的数据。
这些数据可以用于调用 MultiDelegatecall 合约的 multiDelegatecall 函数，从而执行多个 delegatecall。
```solidity
contract Helper {
    function getFunc1Data(uint x, uint y) external pure returns (bytes memory) {
        return abi.encodeWithSelector(TestMultiDelegatecall.func1.selector, x, y);
    }

    function getFunc2Data() external pure returns (bytes memory) {
        return abi.encodeWithSelector(TestMultiDelegatecall.func2.selector);
    }

    function getMintData() external pure returns (bytes memory) {
        return abi.encodeWithSelector(TestMultiDelegatecall.mint.selector);
    }
}
```
## remix验证
部署合约MultiDelegatecall和TestMultiDelegatecall，调用func1（）函数，释放事件。
![64-1.png](./img/64-1.png)
