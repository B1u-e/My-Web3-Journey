# WETH
ETH本身不符合ERC20标准，但可以使用智能合约进行封装，成为符合ERC20同质化代币标准的WETH，可以通过1:1兑换ETH来脱去封装。WETH的开发旨在提高区块链之间的互操作性。除了普通的ERC20功能，WETH还具备存款和取款功能：通过封装，用户可以将ETH存入WETH合约中并获得等量的WETH，而通过解封，用户可以销毁WETH并获得等量的ETH。

WETH符合ERC20标准，它比普通的ERC20多了两个功能：
1. 存款：包装，用户将ETH存入WETH合约，并获得等量的WETH。 
2. 取款：拆包装，用户销毁WETH，并获得等量的ETH




```solidity
     event  Deposit(address indexed dst, uint wad);

     event  Withdrawal(address indexed src, uint wad);


 function deposit() public payable {
        _mint(msg.sender, msg.value);
        emit Deposit(msg.sender, msg.value);
    }

    // 提款函数，用户销毁WETH，取回等量的ETH
function withdraw(uint amount) public {
        require(balanceOf(msg.sender) >= amount);
        _burn(msg.sender, amount);
        payable(msg.sender).transfer(amount);
        emit Withdrawal(msg.sender, amount);
  }

```