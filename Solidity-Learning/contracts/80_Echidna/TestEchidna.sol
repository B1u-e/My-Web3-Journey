// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

/*
docker run -it --rm -v $PWD:/code trailofbits/eth-security-toolbox
echidna-test EchidnaTestTimeAndCaller.sol --contract EchidnaTestTimeAndCaller
*/
contract EchidnaTestTimeAndCaller {
    bool private pass = true;
    uint private createdAt = block.timestamp;

    /*
    test will fail if Echidna can call setFail()
    test will pass otherwise
    */
    function echidna_test_pass() public view returns (bool) {
        return pass;
    }

    function setFail() external {
        /*
        如果延迟小于最大块延迟，Echidna可以调用此函数。
        否则，Echidna将无法调用此函数。
        最大块延迟可以通过在配置文件中指定来扩展。
        */
        uint delay = 7 days;
        require(block.timestamp >= createdAt + delay);
        pass = false;
    }

    // 默认发件人
    // 更改地址以查看测试失败
    address[3] private senders = [
        address(0x10000),
        address(0x20000),
        address(0x00a329C0648769a73afAC7F9381e08fb43DBEA70)
    ];

    address private sender = msg.sender;

    // 将 _sender 作为输入并要求 msg.sender == _sender，
    // 以查看 _sender 的计数示例。
    function setSender(address _sender) external {
        require(_sender == msg.sender);
        sender = msg.sender;
    }

    // 检查默认发件人。发件人应该是三个默认帐户之一。
    function echidna_test_sender() public view returns (bool) {
        for (uint i; i < 3; i++) {
            if (sender == senders[i]) {
                return true;
            }
        }
        return false;
    }
}