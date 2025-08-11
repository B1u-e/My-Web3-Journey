// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Fallback {
    event Log(string func, uint gas);

    // 回退函数必须声明为external函数。
    fallback() external payable {
        // 发送/转移（将2300个gas转发到此回退函数）
        // call (转发所有gas)
        emit Log("fallback", gasleft());
    }

    // Receive是fallback的一种变体，当msg.data为0时触发。
    receive() external payable {
        emit Log("receive", gasleft());
    }

    // 辅助函数用于检查此合约的余额
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}

contract SendToFallback {
    function transferToFallback(address payable _to) public payable {
        _to.transfer(msg.value);
    }

    function callFallback(address payable _to) public payable {
        (bool sent, ) = _to.call{value: msg.value}("");
        require(sent, "Failed to send Ether");
    }
}
