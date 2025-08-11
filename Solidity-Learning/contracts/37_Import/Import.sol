// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// 从当前目录导入Foo.sol
import "./Foo.sol";

// 从“文件名”导入{symbol1 as alias, symbol2}
import {Unauthorized, add as func, Point} from "./Foo.sol";

contract Import {
    // 初始化Foo.sol
    Foo public foo = new Foo();

    // 通过获取其名称来测试Foo.sol。
    function getFooName() public view returns (string memory) {
        return foo.name();
    }
}
//您还可以通过简单地复制URL来从GitHub导入
// https://github.com/owner/repo/blob/branch/path/to/Contract.sol
import "https://github.com/owner/repo/blob/branch/path/to/Contract.sol";

// Example import ECDSA.sol from openzeppelin-contract repo, release-v4.5 branch
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v4.5/contracts/utils/cryptography/ECDSA.sol
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v4.5/contracts/utils/cryptography/ECDSA.sol";
