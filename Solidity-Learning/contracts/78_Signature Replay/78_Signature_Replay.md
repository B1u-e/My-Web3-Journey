# 78.Signature Replay
在区块链中，数字签名可以用于识别数据签名者和验证数据完整性。发送交易时，用户使用私钥签名交易，使得其他人可以验证交易是由相应账户发出的。智能合约也能利用 ECDSA 算法验证用户将在链下创建的签名，然后执行铸造或转账等逻辑。
离线签名消息并拥有一个需要该签名才能执行函数的合约是一种有用的技术。
例如，这种技术可用于：
* 减少链上交易数量
* 无需gas的交易，称为meta transaction
## 漏洞
Signature Replay攻击是一种智能合约安全漏洞，攻击者利用同一私钥签名多个交易，从而重放已经签名的交易来欺骗网络。
这种攻击通常发生在分叉的区块链中，攻击者将交易发送到一个分叉的链上，然后将这些交易重放到主链上，从而获得双倍花费的效果。
相同的签名可以多次用于执行函数。如果签名者的意图只是批准一次交易，这可能会造成损害。
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v4.5/contracts/utils/cryptography/ECDSA.sol";

contract MultiSigWallet {
    using ECDSA for bytes32;

    address[2] public owners;

    constructor(address[2] memory _owners) payable {
        owners = _owners;
    }
    
    //存入以太到合约地址
    function deposit() external payable {}
    
    //从合约地址向指定地址发送以太
    function transfer(address _to, uint _amount, bytes[2] memory _sigs) external {
        bytes32 txHash = getTxHash(_to, _amount);
        require(_checkSigs(_sigs, txHash), "invalid sig");

        (bool sent, ) = _to.call{value: _amount}("");
        require(sent, "Failed to send Ether");
    }
    
    //获取交易哈希，用于生成签名和验证交易。
    function getTxHash(address _to, uint _amount) public view returns (bytes32) {
        return keccak256(abi.encodePacked(_to, _amount));
    }
    
    //验证签名是否合法。
    function _checkSigs(
        bytes[2] memory _sigs,
        bytes32 _txHash
    ) private view returns (bool) {
        bytes32 ethSignedHash = _txHash.toEthSignedMessageHash();

        for (uint i = 0; i < _sigs.length; i++) {
            address signer = ethSignedHash.recover(_sigs[i]);
            bool valid = signer == owners[i];

            if (!valid) {
                return false;
            }
        }

        return true;
    }
}
```

## 预防性技术
为了防止签名重放攻击，开发人员应该遵循以下建议：
* 使用不同的密钥对不同的合同进行签名。
* 在每个合同中使用唯一的nonce值，以确保每个签名只能在特定的合同中使用一次。
* 在验证签名时，确保签名的消息哈希与合同中的哈希匹配。
* 可以考虑使用off-chain签名方案，将签名数据存储在链外，并在执行合同操作时进行验证。
总之，签名重放攻击是一个常见的以太坊安全问题，开发人员应该采取适当的措施来防止这种攻击。
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v4.5/contracts/utils/cryptography/ECDSA.sol";

contract MultiSigWallet {
    using ECDSA for bytes32;

    address[2] public owners;
    mapping(bytes32 => bool) public executed;

    constructor(address[2] memory _owners) payable {
        owners = _owners;
    }

    function deposit() external payable {}

    function transfer(
        address _to,
        uint _amount,
        uint _nonce,
        bytes[2] memory _sigs
    ) external {
        bytes32 txHash = getTxHash(_to, _amount, _nonce);
        require(!executed[txHash], "tx executed");
        require(_checkSigs(_sigs, txHash), "invalid sig");

        executed[txHash] = true;

        (bool sent, ) = _to.call{value: _amount}("");
        require(sent, "Failed to send Ether");
    }

    function getTxHash(
        address _to,
        uint _amount,
        uint _nonce
    ) public view returns (bytes32) {
        return keccak256(abi.encodePacked(address(this), _to, _amount, _nonce));
    }

    function _checkSigs(
        bytes[2] memory _sigs,
        bytes32 _txHash
    ) private view returns (bool) {
        bytes32 ethSignedHash = _txHash.toEthSignedMessageHash();

        for (uint i = 0; i < _sigs.length; i++) {
            address signer = ethSignedHash.recover(_sigs[i]);
            bool valid = signer == owners[i];

            if (!valid) {
                return false;
            }
        }

        return true;
    }
}

/*
// owners
0xe19aea93F6C1dBef6A3776848bE099A7c3253ac8
0xfa854FE5339843b3e9Bfd8554B38BD042A42e340

// to
0xe10422cc61030C8B3dBCD36c7e7e8EC3B527E0Ac
// amount
100
// nonce
0
// tx hash
0x12a095462ebfca27dc4d99feef885bfe58344fb6bb42c3c52a7c0d6836d11448

// signatures
0x120f8ed8f2fa55498f2ef0a22f26e39b9b51ed29cc93fe0ef3ed1756f58fad0c6eb5a1d6f3671f8d5163639fdc40bb8720de6d8f2523077ad6d1138a60923b801c
0xa240a487de1eb5bb971e920cb0677a47ddc6421e38f7b048f8aa88266b2c884a10455a52dc76a203a1a9a953418469f9eec2c59e87201bbc8db0e4d9796935cb1b
*/
```