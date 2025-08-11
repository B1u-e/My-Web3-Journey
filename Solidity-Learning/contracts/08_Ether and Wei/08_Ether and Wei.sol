// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract EtherUnits {
    uint public oneWei = 1 wei;
    // 1 wei等于1
    bool public isOneWei = 1 wei == 1;

    uint public oneEther = 1 ether;
    // 1 ether等于10的18次方wei
    bool public isOneEther = 1 ether == 1e18;
}
