# 8.Ether 和 Wei
交易是使用ether来支付。
与1美元等于100美分类似，1个ether等于10的18次方wei。
该网址可以用来转换以太单位：
[Ethereum Converter](https://link.zhihu.com/?target=https%3A//converter.murkin.me/)
* 1 wei等于1
```solidity
uint public oneWei = 1 wei;
bool public isOneWei = 1 wei == 1;
```
* 1 ether等于10的18次方wei
```solidity
uint public oneEther = 1 ether;
bool public isOneEther = 1 ether == 1e18;
```