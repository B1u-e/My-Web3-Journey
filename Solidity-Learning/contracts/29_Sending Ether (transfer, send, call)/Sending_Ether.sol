// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract ReceiveEther {
    /*
    哪个函数被调用，fallback()还是receive()？

           发送以太

               |
         msg.data 是否为空？
              / \
            yes  no
            /     \
receive()是否存在？  fallback()
         /   \
        yes   no
        /      \
    receive()   fallback()
    */

    // 接收以太的函数。msg.data必须为空
    receive() external payable {}

    // 当msg.data不为空时调用这个回退函数
    fallback() external payable {}

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}

contract SendEther {
    function sendViaTransfer(address payable _to) public payable {
        // 这个函数不再推荐用于发送以太。
        _to.transfer(msg.value);
    }

    function sendViaSend(address payable _to) public payable {
        // 发送返回一个布尔值，表示成功或失败。
        // 这个函数不推荐用于发送以太。
        bool sent = _to.send(msg.value);
        require(sent, "Failed to send Ether");
    }

    function sendViaCall(address payable _to) public payable {
        // 调用返回一个布尔值，表示成功或失败。
        // 这是目前推荐使用的方法。
        (bool sent, bytes memory data) = _to.call{value: msg.value}("");
        require(sent, "Failed to send Ether");
    }
}