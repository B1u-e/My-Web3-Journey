# 透明代理

##  选择器冲突
函数选择器（selector）是函数签名的哈希的前4个字节, int(address account)的选择器为bytes4(keccak256("mint(address)"))

范围很小，因此两个不同的函数可能会有相同的选择器

EVM无法通过函数选择器分辨用户调用哪个函数，因此该合约无法通过编译

## 透明代理
限制管理员的权限，不让他调用任何逻辑合约的函数， 可以调用代理合约的可升级函数
原因： 因为“函数选择器冲突”，在调用逻辑合约的函数时，误调用代理合约的可升级函数

其它用户不能调用可升级函数，但是可以调用逻辑合约的函数


## 缺点
每次调用都会检查是否是管理员， 消耗gas

## 案例
```solidity
    // SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

// 选择器冲突的例子
// 去掉注释后，合约不会通过编译，因为两个函数有着相同的选择器
contract Foo {
    bytes4 public selector1 = bytes4(keccak256("burn(uint256)"));
    bytes4 public selector2 = bytes4(keccak256("collate_propagate_storage(bytes16)"));
    // function burn(uint256) external {}
    // function collate_propagate_storage(bytes16) external {}
}


// 透明可升级合约的教学代码，不要用于生产。
contract TransparentProxy {
    address implementation; // logic合约地址
    address admin; // 管理员
    string public words; // 字符串，可以通过逻辑合约的函数改变

    // 构造函数，初始化admin和逻辑合约地址
    constructor(address _implementation){
        admin = msg.sender;
        implementation = _implementation;
    }

    // fallback函数，将调用委托给逻辑合约
    // 不能被admin调用，避免选择器冲突引发意外
    fallback() external payable {
        require(msg.sender != admin);
        (bool success, bytes memory data) = implementation.delegatecall(msg.data);
    }

    // 升级函数，改变逻辑合约地址，只能由admin调用
    function upgrade(address newImplementation) external {
        if (msg.sender != admin) revert();
        implementation = newImplementation;
    }
}

// 旧逻辑合约
contract Logic1 {
    // 状态变量和proxy合约一致，防止插槽冲突
    address public implementation; 
    address public admin; 
    string public words; // 字符串，可以通过逻辑合约的函数改变

    // 改变proxy中状态变量，选择器： 0xc2985578
    function foo() public{
        words = "old";
    }
}

// 新逻辑合约
contract Logic2 {
    // 状态变量和proxy合约一致，防止插槽冲突
    address public implementation; 
    address public admin; 
    string public words; // 字符串，可以通过逻辑合约的函数改变

    // 改变proxy中状态变量，选择器：0xc2985578
    function foo() public{
        words = "new";
    }
}

```
