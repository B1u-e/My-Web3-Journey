// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Payable {
    // Payable地址可以接收ETH。
    address payable public owner;

    // Payable构造函数可以接收ETH。
    constructor() payable {
        owner = payable(msg.sender);
    }

    // 将ETH存入此合约的函数。
    // 调用此函数并附带一些ETH。
    // 此合约的余额将自动更新。
    function deposit() public payable {}

    // 调用此函数并附带一些ETH.
    // 该函数将会抛出一个错误，因为该函数不支持payable。
    function notPayable() public {}

    // 从合约中提取所有ETH的函数。
    function withdraw() public {
        // 获取存储在此合约中的ETH数量。
        uint amount = address(this).balance;

        // 将所有ETH发送至所有者。
        // O所有者可以收到ETH，因为所有者的地址是payable的。
        (bool success, ) = owner.call{value: amount}("");
        require(success, "Failed to send Ether");
    }

    // 将ETH从该合约转移到输入地址的函数
    function transfer(address payable _to, uint _amount) public {
        // 请注意，“to”被声明为payable的。
        (bool success, ) = _to.call{value: _amount}("");
        require(success, "Failed to send Ether");
    }
}
