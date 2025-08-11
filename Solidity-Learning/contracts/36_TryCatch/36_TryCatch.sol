// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// 用于try/catch示例的external合约
contract Foo {
    address public owner;

    constructor(address _owner) {
        require(_owner != address(0), "invalid address");
        assert(_owner != 0x0000000000000000000000000000000000000001);
        owner = _owner;
    }

    function myFunc(uint x) public pure returns (string memory) {
        require(x != 0, "require failed");
        return "my func was called";
    }
}

contract Bar {
    event Log(string message);
    event LogBytes(bytes data);

    Foo public foo;

    constructor() {
        // 这个Foo合约用作尝试捕获external call的示例。
        foo = new Foo(msg.sender);
    }

    // 使用external call的 try/catch 示例。
    // tryCatchExternalCall(0) => Log("external call failed")
    // tryCatchExternalCall(1) => Log("my func was called")
    function tryCatchExternalCall(uint _i) public {
        try foo.myFunc(_i) returns (string memory result) {
            emit Log(result);
        } catch {
            emit Log("external call failed");
        }
    }

    // 尝试/捕获与合约创建的示例
    // tryCatchNewContract(0x0000000000000000000000000000000000000000) => Log("invalid address")
    // tryCatchNewContract(0x0000000000000000000000000000000000000001) => LogBytes("")
    // tryCatchNewContract(0x0000000000000000000000000000000000000002) => Log("Foo created")
    function tryCatchNewContract(address _owner) public {
        try new Foo(_owner) returns (Foo foo) {
            // 你可以在这里使用变量foo。
            emit Log("Foo created");
        } catch Error(string memory reason) {
            // 捕捉失败的 revert() 和 require()
            emit Log(reason);
        } catch (bytes memory reason) {
            // 捕捉失败的assert()
            emit LogBytes(reason);
        }
    }
}
