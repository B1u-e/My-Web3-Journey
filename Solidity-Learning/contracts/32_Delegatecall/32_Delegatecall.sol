// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// 注释: 请先部署这个合约。
contract B {
    // 注释: 存储布局必须与合约A相同。
    uint public num;
    address public sender;
    uint public value;

    function setVars(uint _num) public payable {
        num = _num;
        sender = msg.sender;
        value = msg.value;
    }
}

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
