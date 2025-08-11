# 16.Datalocations
## 变量被声明为storage、memory或calldata，以明确指定数据的位置。
1.storage - 变量是状态变量（存储在区块链上）。
2.memory - 变量在内存中存在，仅在函数被调用时存在，不上链。
3.calldata - 特殊的数据位置，包含函数参数。和memory类似，存储在内存中，不上链。与memory的不同点在于calldata变量不能修改（immutable），一般用于函数的参数。
* 数组、映射、结构体
```solidity
uint[] public arr;
mapping(uint => address) map;
struct MyStruct {
    uint foo;
}
mapping(uint => MyStruct) myStructs;
```

* 公共函数f(),使用状态变量调用内部函数_f，并演示了如何从映射中获取结构体并在内存中创建结构体
```solidity
function f() public {
    // 使用状态变量调用_f函数。
    _f(arr, map, myStructs[1]);

    // 从映射中获取一个结构体
    MyStruct storage myStruct = myStructs[1];
    // 在内存中创建一个结构体。
    MyStruct memory myMemStruct = MyStruct(0);
}
```

* 使用存储变量执行某些操作
```solidity
function _f(
    uint[] storage _arr,
    mapping(uint => address) storage _map,
    MyStruct storage _myStruct
) internal {}
```

你可以返回内存变量
* 使用memory数组执行某些操作。
```solidity
function g(uint[] memory _arr) public returns (uint[] memory) {}
```

* 使用calldata数组执行某些操作。
```solidity
function h(uint[] calldata _arr) external {}
```

