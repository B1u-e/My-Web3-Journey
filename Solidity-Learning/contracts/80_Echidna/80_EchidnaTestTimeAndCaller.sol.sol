// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/*
echidna-test TestEchidna.sol --contract TestCounter
*/
contract Counter {
    uint public count;

    function inc() external {
        count += 1;
    }

    function dec() external {
        count -= 1;
    }
}

contract TestCounter is Counter {
    function echidna_test_true() public view returns (bool) {
        return true;
    }

    function echidna_test_false() public view returns (bool) {
        return false;
    }

    function echidna_test_count() public view returns (bool) {
        // 在这里我们正在测试Counter.count应该始终<= 5。
        // 测试将失败。Echidna足够聪明，可以调用Counter.inc()超过5次。
        return count <= 5;
    }
}

/*
echidna-test TestEchidna.sol --contract TestAssert --check-asserts
*/
contract TestAssert {
    // 0.8版本中未检测到断言。
    // 切换到0.7版本以测试断言。
    function test_assert(uint _i) external {
        assert(_i < 10);
    }

    // 更复杂的例子
    function abs(uint x, uint y) private pure returns (uint) {
        if (x >= y) {
            return x - y;
        }
        return y - x;
    }

    function test_abs(uint x, uint y) external {
        uint z = abs(x, y);
        if (x >= y) {
            assert(z <= x);
        } else {
            assert(z <= y);
        }
    }
}


