# 85.Constant Sum AMM
常量和自动市场制造商 X + Y = K

令牌一对一交易。

* 合约中两种 ERC20 代币的地址，初始化时必须传入。
```solidity
IERC20 public immutable token0;
IERC20 public immutable token1;
```

* 合约中两种代币的储备量。
```solidity
uint public reserve0;
uint public reserve1;
```

* 合约中代币的总供应量。
```solidity
uint public totalSupply;
```

* 记录每个地址持有的代币数量。
```solidity
mapping(address => uint) public balanceOf;

constructor(address _token0, address _token1) {
    // 注意：此合约假定 token0 和 token1，具有相同的小数位数
    token0 = IERC20(_token0);
    token1 = IERC20(_token1);
}
```

* 内部函数，用于增加/减少地址持有的代币数量。
```solidity
function _mint(address _to, uint _amount) private {
    balanceOf[_to] += _amount;
    totalSupply += _amount;
}
function _burn(address _from, uint _amount) private {
    balanceOf[_from] -= _amount;
    totalSupply -= _amount;
}
```

* 内部函数，用于更新储备量。
```solidity
function _update(uint _res0, uint _res1) private {
    reserve0 = _res0;
    reserve1 = _res1;
}
```

* 外部函数，用于在两种代币之间进行交换。用户需要传入要交换的 ERC20 代币地址和数量，合约会根据当前的储备量计算出交换的数量，并将交换的代币发送给用户。
```solidity
function swap(address _tokenIn, uint _amountIn) external returns (uint amountOut) {
    require(
        _tokenIn == address(token0) || _tokenIn == address(token1),
        "invalid token"
    );

    bool isToken0 = _tokenIn == address(token0);

    (IERC20 tokenIn, IERC20 tokenOut, uint resIn, uint resOut) = isToken0
        ? (token0, token1, reserve0, reserve1)
        : (token1, token0, reserve1, reserve0);

    tokenIn.transferFrom(msg.sender, address(this), _amountIn);
    uint amountIn = tokenIn.balanceOf(address(this)) - resIn;

    // 0.3% 费用
    amountOut = (amountIn * 997) / 1000;

    (uint res0, uint res1) = isToken0
        ? (resIn + amountIn, resOut - amountOut)
        : (resOut - amountOut, resIn + amountIn);

    _update(res0, res1);
    tokenOut.transfer(msg.sender, amountOut);
}
```

* 外部函数，用于向合约中添加流动性。用户需要传入两种 ERC20 代币的数量，合约会根据当前的储备量计算出用户所添加的流动性份额，并将份额发送给用户。同时，合约会将用户添加的代币储备量加入到总的储备量中。
```solidity
function addLiquidity(uint _amount0, uint _amount1) external returns (uint shares) {
    token0.transferFrom(msg.sender, address(this), _amount0);
    token1.transferFrom(msg.sender, address(this), _amount1);

    uint bal0 = token0.balanceOf(address(this));
    uint bal1 = token1.balanceOf(address(this));

    uint d0 = bal0 - reserve0;
    uint d1 = bal1 - reserve1;

    /*
    a = amount in
    L = total liquidity
    s = shares to mint
    T = total supply

    s should be proportional to increase from L to L + a
    (L + a) / L = (T + s) / T

    s = a * T / L
    */
    if (totalSupply > 0) {
        shares = ((d0 + d1) * totalSupply) / (reserve0 + reserve1);
    } else {
        shares = d0 + d1;
    }

    require(shares > 0, "shares = 0");
    _mint(msg.sender, shares);

    _update(bal0, bal1);
}
```
* 外部函数，用于从合约中移除流动性。用户需要传入要移除的流动性份额，合约会根据当前的储备量计算出用户可以获得的两种代币数量，并将数量发送给用户。同时，合约会将用户移除的代币储备量从总的储备量中减去，并销毁用户的流动性份额。
```solidity
function removeLiquidity(uint _shares) external returns (uint d0, uint d1) {
    /*
    a = amount out
    L = total liquidity
    s = shares
    T = total supply

    a / L = s / T

    a = L * s / T
      = (reserve0 + reserve1) * s / T
    */
    d0 = (reserve0 * _shares) / totalSupply;
    d1 = (reserve1 * _shares) / totalSupply;

    _burn(msg.sender, _shares);
    _update(reserve0 - d0, reserve1 - d1);

    if (d0 > 0) {
        token0.transfer(msg.sender, d0);
    }
    if (d1 > 0) {
        token1.transfer(msg.sender, d1);
    }
}


interface IERC20 {
    function totalSupply() external view returns (uint);

    function balanceOf(address account) external view returns (uint);

    function transfer(address recipient, uint amount) external returns (bool);

    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint amount) external returns (bool);

    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint amount);
    event Approval(address indexed owner, address indexed spender, uint amount);
}
```