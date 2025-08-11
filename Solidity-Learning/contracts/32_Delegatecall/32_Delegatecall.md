# 32.Delegatecall
## delegatecall
delegatecall是类似于call的低级函数。
当合约A执行delegatecall到合约B时，B的代码将在合约A的storage、msg.sender和msg.value下执行。
* delegatecall语法和call类似：
```solidity
目标合约地址.delegatecall(二进制编码);
```

* 其中二进制编码利用结构化编码函数abi.encodeWithSignature获得：
```solidity
abi.encodeWithSignature("函数签名", 逗号分隔的具体参数)
```

* 部署合约B，存储布局必须与合约A相同。
```solidity
contract B {
    uint public num;
    address public sender;
    uint public value;

    function setVars(uint _num) public payable {
        num = _num;
        sender = msg.sender;
        value = msg.value;
    }
}
```

* 部署合约A
```solidity
contract A {
    uint public num;
    address public sender;
    uint public value;

    function setVars(address _contract, uint _num) public payable {
        // A的存储设置已经完成，B没有被修改。
        (bool success, bytes memory data) = _contract.delegatecall(
            abi.encodeWithSignature("setVars(uint256)", _num)
        );
    }
}
```
注意：delegatecall有安全隐患，使用时要保证当前合约和目标合约的状态变量存储结构相同，并且目标合约安全，不然会造成资产损失。


   
## remix验证
1. 部署合约B，调用setVars（）函数，输入数值1，显示为1。
![32-1.png](./img/32-1.png)
2. 部署合约A，调用setVars（）函数，输入合约B的地址和数值2，A显示数值为2，合约B未改变。
![32-2.png](./img/32-2.png)
