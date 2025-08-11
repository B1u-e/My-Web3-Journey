# 83.Discrete Staking Rewards
类似于质押奖励合约。不同之处在于奖励金额可能在每一秒钟发生变化。

## 离散型质押奖励
合约包含以下变量：
* stakingToken：用于质押的代币合约地址。
* rewardToken：用于奖励的代币合约地址。
* balanceOf：记录每个地址的质押代币余额。
* totalSupply：记录总的质押代币供应量。
* rewardIndex：记录当前奖励指数。
* rewardIndexOf：记录每个地址的最近奖励指数。
* earned：记录每个地址已经获得的奖励代币数量。


接受质押代币和奖励代币的合约地址。
```solidity
constructor(address _stakingToken, address _rewardToken) {
    stakingToken = IERC20(_stakingToken);
    rewardToken = IERC20(_rewardToken);
}
```
更新奖励指数，需要将奖励代币转入合约地址。
```solidity
function updateRewardIndex(uint reward) external {
    rewardToken.transferFrom(msg.sender, address(this), reward);
    rewardIndex += (reward * MULTIPLIER) / totalSupply;
}
```
计算指定地址应该获得的奖励代币数量。
```solidity

function _calculateRewards(address account) private view returns (uint) {
    uint shares = balanceOf[account];
    return (shares * (rewardIndex - rewardIndexOf[account])) / MULTIPLIER;
}
```
查询指定地址已经获得的奖励代币数量。
```solidity
function calculateRewardsEarned(address account) external view returns (uint) {
    return earned[account] + _calculateRewards(account);
}
```
更新指定地址的奖励数量和最近奖励指数。
```solidity
function _updateRewards(address account) private {
    earned[account] += _calculateRewards(account);
    rewardIndexOf[account] = rewardIndex;
}
```
质押代币，需要将质押代币转入合约地址。
```solidity
function stake(uint amount) external {
    _updateRewards(msg.sender);

    balanceOf[msg.sender] += amount;
    totalSupply += amount;

    stakingToken.transferFrom(msg.sender, address(this), amount);
}
```
解除质押，需要将质押代币转回用户地址。
```solidity
function unstake(uint amount) external {
    _updateRewards(msg.sender);

    balanceOf[msg.sender] -= amount;
    totalSupply -= amount;

    stakingToken.transfer(msg.sender, amount);
}
```
领取已经获得的奖励代币，将奖励代币转到用户地址。
```solidity
function claim() external returns (uint) {
    _updateRewards(msg.sender);

    uint reward = earned[msg.sender];
    if (reward > 0) {
        earned[msg.sender] = 0;
        rewardToken.transfer(msg.sender, reward);
    }

    return reward;
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

    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
}
```