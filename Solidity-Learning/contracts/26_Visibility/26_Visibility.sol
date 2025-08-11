// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Base {
    // 私有函数只能在此合约内被调用。
    // 继承此合约的合约不能调用此函数。
    function privateFunc() private pure returns (string memory) {
        return "private function called";
    }

    function testPrivateFunc() public pure returns (string memory) {
        return privateFunc();
    }

    // internal函数可以被调用：
    // 在该合约内部
    // 在继承该合约的合约内部
    function internalFunc() internal pure returns (string memory) {
        return "internal function called";
    }

    function testInternalFunc() public pure virtual returns (string memory) {
        return internalFunc();
    }

    // public函数可以被调用：
    // 在本合约内部
    // 在继承本合约的合约内部
    // 被其他合约和账户调用。
    function publicFunc() public pure returns (string memory) {
        return "public function called";
    }

    // external函数只能被其他合约和账户调用。
    function externalFunc() external pure returns (string memory) {
        return "external function called";
    }

    // 这个函数无法编译，因为我们试图在这里调用一个external函数。
    // function testExternalFunc() public pure returns (string memory) {
    //     return externalFunc();
    // }

    // 状态变量
    string private privateVar = "my private variable";
    string internal internalVar = "my internal variable";
    string public publicVar = "my public variable";
    // 状态变量不能是external变量，因此这段代码无法编译。
    // 字符串类型的external变量 externalVar = "my external variable";
}

contract Child is Base {
    // 继承的合约无法访问private函数和状态变量。
    // function testPrivateFunc() public pure returns (string memory) {
    //     return privateFunc();
    // }

    // internal函数调用可以在子合约中被调用。
    function testInternalFunc() public pure override returns (string memory) {
        return internalFunc();
    }
}
