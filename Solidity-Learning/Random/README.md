# Random 随机数

<style>
    .paragraph {
        text-indent: 40px;
    }
</style>
<p class="paragraph">在区块链中，随机数是非常重要的，因为它们在许多场景下都被广泛使用，例如游戏、投票、抽奖等。但是，由于区块链的去中心化特性，生成随机数变得更加复杂，因为没有单一的可信的中心化机构来生成随机数。因此，人们创造了一些方法来生成链上随机数和链下随机数。</p>

## 链上随机数

### 介绍

<p class="paragraph">
链上随机数是指完全在区块链上生成的随机数，因此不需要任何外部信任，是完全去中心化的。这些随机数通常是通过区块链中的随机数生成器算法来生成的。这些算法使用链上数据和交易作为种子来生成随机数，确保生成的随机数具有不可预测性和不可操纵性。但是，由于算法是公开的，因此一些恶意用户可能会通过观察和分析这些种子数据来推断出生成的随机数。因此，链上随机数仍然存在一些安全风险。
</p>

### 应用

<p class="paragraph">

</p>

```solidity
pragma solidity ^0.8.0;

contract RandomNumberGenerator {
    uint private nonce = 0;
    function generateRandomNumber() public returns (uint) {
        uint randomNumber = uint(keccak256(abi.encodePacked(block.timestamp, msg.sender, nonce))) % 100;
        nonce++;
        return randomNumber;
    }
}

```
<p class="paragraph">
   在这个例子中，我们使用 Solidity 的 keccak256 哈希函数和区块的时间戳、交易发送方和随机 nonce 值来生成随机数。这个随机数可以在 0 到 99 之间取值。这个例子仅仅是一个简单的例子，实际中生成随机数需要更多的考虑安全性和不可预测性的因素。
</p>


## 链下随机数

### 介绍

<p class="paragraph">
链下随机数是指通过链外可信任机构生成的随机数。例如，可以使用现实世界中的事件来生成随机数，例如天气或股票市场数据。这些数据然后可以使用区块链上的智能合约进行验证和使用。由于生成随机数的过程由可信任的机构控制，因此这些随机数通常被认为更安全。
</p>


### 应用
<p class="paragraph">
生成随机数的方法是使用区块链上的 Oraclize 或 Chainlink 等第三方服务。这些服务将从外部数据源中获取随机数据，并将其发送到智能合约中。这种方法将随机性的责任委托给了第三方服务提供商，但是也增加了安全性和不可操纵性。

下面是一个使用 Chainlink VRF（可验证随机函数）合约生成随机数的示例代码
</p>


```solidity
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/VRFConsumerBase.sol";

contract RandomNumberGenerator is VRFConsumerBase {
    bytes32 private keyHash;
    uint private fee;
    uint public randomResult;

    constructor(address vrfCoordinator, address linkToken, bytes32 _keyHash, uint _fee)
    VRFConsumerBase(vrfCoordinator, linkToken)
    {
        keyHash = _keyHash;
        fee = _fee;
    }

    function getRandomNumber() public returns (bytes32 requestId) {
        require(LINK.balanceOf(address(this)) >= fee, "Not enough LINK to pay fee");
        return requestRandomness(keyHash, fee);
    }

    function fulfillRandomness(bytes32 requestId, uint randomness) internal override {
        randomResult = randomness % 100;
    }
}

```
<p class="paragraph">
    在这个例子中，我们使用了 Chainlink VRF 合约来生成随机数。合约的 getRandomNumber() 函数将请求一个随机数，并通过 requestRandomness() 函数将请求发送到 Chainlink 的 VRF 合约。一旦 Chainlink 的 VRF 合约生成随机数，它将调用 fulfillRandomness() 函数，并将随机数作为参数传递给该函数。在这个例子中，我们将生成的随机数限制在 0 到 99 之间。
</p>

## 总结
<p class="paragraph">
    在实际应用中，如何选择使用链上随机数还是链下随机数取决于具体情况。在某些场景下，使用链上随机数是更可靠的，例如需要完全去中心化的场景。在其他情况下，使用链下随机数是更安全的，例如需要高度安全性和真实性的场景。
</p>
