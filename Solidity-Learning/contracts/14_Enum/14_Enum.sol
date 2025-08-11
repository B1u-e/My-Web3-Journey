// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Enum {
    // 枚举表示运输状态。
    enum Status {
        Pending,
        Shipped,
        Accepted,
        Rejected,
        Canceled
    }

    // 默认数值是列出的第一个元素。
    // 在这种情况下，“Pending”的定义是“待处理的”。
    Status public status;

    // 返回值为无符号整数uint
    // 待处理 - 0
    // 已发货 - 1
    // 已接受 - 2
    // 已拒绝 - 3
    // 已取消 - 4
    function get() public view returns (Status) {
        return status;
    }

    // 通过将uint传入输入来更新状态
    function set(Status _status) public {
        status = _status;
    }

    // 你可以通过以下方式更新到特定的枚举
    function cancel() public {
        status = Status.Canceled;
    }

    // 删除会将枚举重置为其第一个值，即0。
    function reset() public {
        delete status;
    }
}
