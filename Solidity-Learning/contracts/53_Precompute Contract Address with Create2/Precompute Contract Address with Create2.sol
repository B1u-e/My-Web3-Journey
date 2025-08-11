// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Factory {
    // 返回新部署合约的地址
    function deploy(
        address _owner,
        uint _foo,
        bytes32 _salt
    ) public payable returns (address) {
        // 这个语法是一个新的方式来调用create2而不需要使用汇编，你只需要传递salt
        // https://docs.soliditylang.org/en/latest/control-structures.html#salted-contract-creations-create2
        return address(new TestContract{salt: _salt}(_owner, _foo));
    }
}

// 使用汇编的旧方法
contract FactoryAssembly {
    event Deployed(address addr, uint salt);

    // 1. 获取要部署的合约的字节码
    // 注意：_owner和_foo是TestContract构造函数的参数TestContract's constructor
    function getBytecode(address _owner, uint _foo) public pure returns (bytes memory) {
        bytes memory bytecode = type(TestContract).creationCode;

        return abi.encodePacked(bytecode, abi.encode(_owner, _foo));
    }

    // 2. 计算要部署的合约的地址
    // 注意：_salt是用于创建地址的随机数
    function getAddress(
        bytes memory bytecode,
        uint _salt
    ) public view returns (address) {
        bytes32 hash = keccak256(
            abi.encodePacked(bytes1(0xff), address(this), _salt, keccak256(bytecode))
        );

        // 注意：将哈希的最后20个字节转换为地址
        return address(uint160(uint(hash)));
    }

    // 3. 部署合约
    // 注意：
    // 检查Deployed事件日志，其中包含已部署TestContract的地址。
     // 日志中的地址应等于上面计算出的地址。
    function deploy(bytes memory bytecode, uint _salt) public payable {
        address addr;

        /*
        注意：如何调用create2

        create2(v, p, n, s)
        使用内存p到p + n中的代码创建新合约
        并发送v wei
        并返回新地址
        其中新地址=keccak256(0xff + address(this) + s + keccak256(mem[p…(p+n)))的前20个字节
              s = 前端256位值
        */
        assembly {
            addr := create2(
                callvalue(), // wei sent with current call
                // Actual code starts after skipping the first 32 bytes
                add(bytecode, 0x20),
                mload(bytecode), // Load the size of code contained in the first 32 bytes
                _salt // Salt from function arguments
            )

            if iszero(extcodesize(addr)) {
                revert(0, 0)
            }
        }

        emit Deployed(addr, _salt);
    }
}

contract TestContract {
    address public owner;
    uint public foo;

    constructor(address _owner, uint _foo) payable {
        owner = _owner;
        foo = _foo;
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}