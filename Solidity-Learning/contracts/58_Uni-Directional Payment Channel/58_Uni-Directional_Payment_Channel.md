# 58.Uni-Directional Payment Channel

Uni-Directional Payment Channel（单向支付通道）是一种基于区块链技术的支付协议，允许两个参与者在不必等待区块链确认的情况下进行多次交易。
该协议允许参与者在通道内进行任意次数的交易，只有最终结算会被写入区块链。
这种支付通道可以提高交易速度和降低交易费用，同时保持区块链的安全性和去中心化特性。

以下是该合同的使用方式：

* Alice部署合同，并用一些ETH进行资金投入。
* Alice通过签署消息（链下）授权支付，并将签名发送给Bob。
* Bob通过向智能合约呈现签名的方式领取付款。
* 如果Bob不领取付款，则合同过期后Alice可以收回她的ETH。
这被称为单向支付通道，因为支付只能从Alice向Bob单向进行。

Uni-Directional Payment Channel例子合约

* 数字签名的验证和交易过期时间的限制、
```solidity
using ECDSA for bytes32;

address payable public sender;
address payable public receiver;

uint private constant DURATION = 7 * 24 * 60 * 60;
uint public expiresAt;
```

* 构造函数将指定接收方地址，并设置通道的过期时间
```solidity
constructor(address payable _receiver) payable {
    require(_receiver != address(0), "receiver = zero address");
    sender = payable(msg.sender);
    receiver = _receiver;
    expiresAt = block.timestamp + DURATION;
}
```

* 将此合约地址和发送的金额作为输入，并返回哈希值
用于返回给定金额的哈希值，以便进行签名和验证
```solidity
function _getHash(uint _amount) private view returns (bytes32) {
    // 注释: 在此合同上签名并附上地址，以防止对其他合同进行重放攻击。
    return keccak256(abi.encodePacked(address(this), _amount));
}

function getHash(uint _amount) external view returns (bytes32) {
    return _getHash(_amount);
}
```

* 将哈希值转换为以太签名哈希值。这是为了防止重入攻击。
```solidity
function _getEthSignedHash(uint _amount) private view returns (bytes32) {
    return _getHash(_amount).toEthSignedMessageHash();
}

function getEthSignedHash(uint _amount) external view returns (bytes32) {
    return _getEthSignedHash(_amount);
}
```

* 验证给定金额的签名是否有效。
并使用 recover() 函数从签名中恢复签名者地址。如果地址与发送方地址匹配，则返回 true。
```solidity
function _verify(uint _amount, bytes memory _sig) private view returns (bool) {
    return _getEthSignedHash(_amount).recover(_sig) == sender;
}

function verify(uint _amount, bytes memory _sig) external view returns (bool) {
    return _verify(_amount, _sig);
}
```

* 关闭通道并将指定金额发送给接收方。
需要接收方提供签名来验证交易，然后将指定金额发送给接收方，并销毁合约。
```solidity
function close(uint _amount, bytes memory _sig) external nonReentrant {
    require(msg.sender == receiver, "!receiver");
    require(_verify(_amount, _sig), "invalid sig");

    (bool sent, ) = receiver.call{value: _amount}("");
    require(sent, "Failed to send Ether");
    selfdestruct(sender);
}
```


* 如果通道过期且发送方没有关闭通道，发送方可以调用此函数来销毁合约并取回所有资金。
```solidity
function cancel() external {
    require(msg.sender == sender, "!sender");
    require(block.timestamp >= expiresAt, "!expired");
    selfdestruct(sender);
}
```