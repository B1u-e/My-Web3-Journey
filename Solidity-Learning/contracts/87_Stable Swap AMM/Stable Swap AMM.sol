// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

/*
不变量 - 交易价格和流动性量由以下方程确定

An^n sum(x_i) + D = ADn^n + D^(n + 1) / (n^n prod(x_i))

主题
0. 牛顿法 x_(n + 1) = x_n - f(x_n) / f'(x_n)
1. 不变量
2. 交换
   - 计算 Y
   - 计算 D
3. 获取虚拟价格
4. 添加流动性
   - 不平衡费用
5. 移除流动性
6. 移除一个代币的流动性
   - 计算撤回一个代币
   - getYD
TODO: test?
*/

library Math {
    function abs(uint x, uint y) internal pure returns (uint) {
        return x >= y ? x - y : y - x;
    }
}

contract StableSwap {
    // 令牌数量
    uint private constant N = 3;
    // 放大系数乘以N的N-1次方
    // 较高的值使曲线更平缓
    // 较低的值使曲线更类似于恒定产品AMM
    uint private constant A = 1000 * (N ** (N - 1));
    // 0.03%
    uint private constant SWAP_FEE = 300;
    // 流动性费用来自两个限制条件
    // 1. 对于导致平衡池的添加/移除流动性，费用为0
    // 2. 在平衡池中交换就像从平衡池中添加然后移除流动性
    //    添加流动性费用+移除流动性费用=交换费用
    uint private constant LIQUIDITY_FEE = (SWAP_FEE * N) / (4 * (N - 1));
    uint private constant FEE_DENOMINATOR = 1e6;

    address[N] public tokens;
    // 将每个代币标准化为18个小数位
    // 例如-DAI（18个小数位），USDC（6个小数位），USDT（6个小数位
    uint[N] private multipliers = [1, 1e12, 1e12];
    uint[N] public balances;

    // 1份= 1e18，18个小数位
    uint private constant DECIMALS = 18;
    uint public totalSupply;
    mapping(address => uint) public balanceOf;

    function _mint(address _to, uint _amount) private {
        balanceOf[_to] += _amount;
        totalSupply += _amount;
    }

    function _burn(address _from, uint _amount) private {
        balanceOf[_from] -= _amount;
        totalSupply -= _amount;
    }

    // 返回精度调整后的余额，调整为18个小数位
    function _xp() private view returns (uint[N] memory xp) {
        for (uint i; i < N; ++i) {
            xp[i] = balances[i] * multipliers[i];
        }
    }

    /**
     * @notice 计算 D，一个完全平衡的池中余额的总和
     * 如果 x_0、x_1、...、x_(n-1) 的余额，则 sum(x_i) = D
     * @param xp 经过精度调整的余额
     * @return D
     */
    function _getD(uint[N] memory xp) private pure returns (uint) {
        /*
        使用牛顿法计算D
        -----------------------------
        f(D) = ADn^n + D^(n + 1) / (n^n prod(x_i)) - An^n sum(x_i) - D 
        f'(D) = An^n + (n + 1) D^n / (n^n prod(x_i)) - 1

                     (as + np)D_n
        D_(n+1) = -----------------------
                  (a - 1)D_n + (n + 1)p

        a = An^n
        s = sum(x_i)
        p = (D_n)^(n + 1) / (n^n prod(x_i))
        */
        uint a = A * N; // An^n

        uint s; // x_0 + x_1 + ... + x_(n-1)
        for (uint i; i < N; ++i) {
            s += xp[i];
        }

        // 牛顿迭代法
        // 初始猜测，d <= s
        uint d = s;
        uint d_prev;
        for (uint i; i < 255; ++i) {
            // p = D^(n + 1) / (n^n * x_0 * ... * x_(n-1))
            uint p = d;
            for (uint j; j < N; ++j) {
                p = (p * d) / (N * xp[j]);
            }
            d_prev = d;
            d = ((a * s + N * p) * d) / ((a - 1) * d + (N + 1) * p);

            if (Math.abs(d, d_prev) <= 1) {
                return d;
            }
        }
        revert("D didn't converge");
    }

    /**
     * @notice 计算给定 token i 的新余额后，token j 的新余额
     * @param i token i 的索引
     * @param j token j 的索引
     * @param x token i 的新余额
     * @param xp 当前精度调整后的余额
     */
    function _getY(
        uint i,
        uint j,
        uint x,
        uint[N] memory xp
    ) private pure returns (uint) {
        /*
        牛顿迭代法计算y
        -----------------------------
        y = x_j

        f(y) = y^2 + y(b - D) - c

                    y_n^2 + c
        y_(n+1) = --------------
                   2y_n + b - D

        其中
        s = sum(x_k), k != j
        p = prod(x_k), k != j
        b = s + D / (An^n)
        c = D^(n + 1) / (n^n * p * An^n)
        */
        uint a = A * N;
        uint d = _getD(xp);
        uint s;
        uint c = d;

        uint _x;
        for (uint k; k < N; ++k) {
            if (k == i) {
                _x = x;
            } else if (k == j) {
                continue;
            } else {
                _x = xp[k];
            }

            s += _x;
            c = (c * d) / (N * _x);
        }
        c = (c * d) / (N * a);
        uint b = s + d / a;

        // 牛顿法
        uint y_prev;
        // 初始猜测, y <= d
        uint y = d;
        for (uint _i; _i < 255; ++_i) {
            y_prev = y;
            y = (y * y + c) / (2 * y + b - d);
            if (Math.abs(y, y_prev) <= 1) {
                return y;
            }
        }
        revert("y didn't converge");
    }

    /**
     * @notice 计算给定精度调整后的余额xp和流动性d后，代币i的新余额
     * @dev 计算y的方程式与_getY相同
     * @param i 要计算新余额的代币索引
     * @param xp 精度调整后的余额
     * @param d 流动性d
     * @return 代币i的新余额
     */
    function _getYD(uint i, uint[N] memory xp, uint d) private pure returns (uint) {
        uint a = A * N;
        uint s;
        uint c = d;

        uint _x;
        for (uint k; k < N; ++k) {
            if (k != i) {
                _x = xp[k];
            } else {
                continue;
            }

            s += _x;
            c = (c * d) / (N * _x);
        }
        c = (c * d) / (N * a);
        uint b = s + d / a;

        // 牛顿法
        uint y_prev;
        // 初始猜测, y <= d
        uint y = d;
        for (uint _i; _i < 255; ++_i) {
            y_prev = y;
            y = (y * y + c) / (2 * y + b - d);
            if (Math.abs(y, y_prev) <= 1) {
                return y;
            }
        }
        revert("y didn't converge");
    }

    // 估计一股的价值
    // 一个股份值多少代币？
    function getVirtualPrice() external view returns (uint) {
        uint d = _getD(_xp());
        uint _totalSupply = totalSupply;
        if (_totalSupply > 0) {
            return (d * 10 ** DECIMALS) / _totalSupply;
        }
        return 0;
    }

    /**
     * @notice 交换 i 索引的代币的 dx 数量，以换取 j 索引的代币
     * @param i 代币索引
     * @param j 代币索引
     * @param dx 输入代币数量
     * @param minDy 最小输出代币数量
     */
    function swap(uint i, uint j, uint dx, uint minDy) external returns (uint dy) {
        require(i != j, "i = j");

        IERC20(tokens[i]).transferFrom(msg.sender, address(this), dx);

        // 计算 dy
        uint[N] memory xp = _xp();
        uint x = xp[i] + dx * multipliers[i];

        uint y0 = xp[j];
        uint y1 = _getY(i, j, x, xp);
        // y0必须大于等于y1，因为x已经增加了
        // -1是为了向下取整
        dy = (y0 - y1 - 1) / multipliers[j];

        // 从dy中减去费用
        uint fee = (dy * SWAP_FEE) / FEE_DENOMINATOR;
        dy -= fee;
        require(dy >= minDy, "dy < min");

        balances[i] += dx;
        balances[j] -= dy;

        IERC20(tokens[j]).transfer(msg.sender, dy);
    }

    function addLiquidity(
        uint[N] calldata amounts,
        uint minShares
    ) external returns (uint shares) {
        // 计算当前流动性d0
        uint _totalSupply = totalSupply;
        uint d0;
        uint[N] memory old_xs = _xp();
        if (_totalSupply > 0) {
            d0 = _getD(old_xs);
        }

        // 将代币转移入
        uint[N] memory new_xs;
        for (uint i; i < N; ++i) {
            uint amount = amounts[i];
            if (amount > 0) {
                IERC20(tokens[i]).transferFrom(msg.sender, address(this), amount);
                new_xs[i] = old_xs[i] + amount * multipliers[i];
            } else {
                new_xs[i] = old_xs[i];
            }
        }

        // 计算新的流动性d1
        uint d1 = _getD(new_xs);
        require(d1 > d0, "liquidity didn't increase");

        // 重新计算D，考虑到失衡费用。
        uint d2;
        if (_totalSupply > 0) {
            for (uint i; i < N; ++i) {
                // TODO: why old_xs[i] * d1 / d0? why not d1 / N?
                uint idealBalance = (old_xs[i] * d1) / d0;
                uint diff = Math.abs(new_xs[i], idealBalance);
                new_xs[i] -= (LIQUIDITY_FEE * diff) / FEE_DENOMINATOR;
            }

            d2 = _getD(new_xs);
        } else {
            d2 = d1;
        }

        // 更新余额
        for (uint i; i < N; ++i) {
            balances[i] += amounts[i];
        }

        // 股份发行量 = （d2 - d0）/ d0 * 总供应量
        // d1 >= d2 >= d0
        if (_totalSupply > 0) {
            shares = ((d2 - d0) * _totalSupply) / d0;
        } else {
            shares = d2;
        }
        require(shares >= minShares, "shares < min");
        _mint(msg.sender, shares);
    }

    function removeLiquidity(
        uint shares,
        uint[N] calldata minAmountsOut
    ) external returns (uint[N] memory amountsOut) {
        uint _totalSupply = totalSupply;

        for (uint i; i < N; ++i) {
            uint amountOut = (balances[i] * shares) / _totalSupply;
            require(amountOut >= minAmountsOut[i], "out < min");

            balances[i] -= amountOut;
            amountsOut[i] = amountOut;

            IERC20(tokens[i]).transfer(msg.sender, amountOut);
        }

        _burn(msg.sender, shares);
    }

    /**
     * @notice 计算赎回股份所获得的代币i的数量
     * @param shares 要赎回的股份
     * @param i 要提取的代币的索引
     * @return dy 要获得的代币i的数量
     *          fee 提取的费用。费用已包含在dy中
     */
    function _calcWithdrawOneToken(
        uint shares,
        uint i
    ) private view returns (uint dy, uint fee) {
        uint _totalSupply = totalSupply;
        uint[N] memory xp = _xp();

        // 计算d0和d1
        uint d0 = _getD(xp);
        uint d1 = d0 - (d0 * shares) / _totalSupply;

        // 如果D = d1，计算y的减少量
        uint y0 = _getYD(i, xp, d1);
        // d1 <= d0 so y must be <= xp[i]
        uint dy0 = (xp[i] - y0) / multipliers[i];

        // d1小于等于d0，因此y必须小于等于xp [i]。
        uint dx;
        for (uint j; j < N; ++j) {
            if (j == i) {
                dx = (xp[j] * d1) / d0 - y0;
            } else {
                // d1 / d0 <= 1
                dx = xp[j] - (xp[j] * d1) / d0;
            }
            xp[j] -= (LIQUIDITY_FEE * dx) / FEE_DENOMINATOR;
        }

        // 重新计算包括不平衡费用的xp的y值。
        uint y1 = _getYD(i, xp, d1);
        // -1 向下取整
        dy = (xp[i] - y1 - 1) / multipliers[i];
        fee = dy0 - dy;
    }

    function calcWithdrawOneToken(
        uint shares,
        uint i
    ) external view returns (uint dy, uint fee) {
        return _calcWithdrawOneToken(shares, i);
    }

    /**
     * @notice 从代币i中提取流动性
     * @param shares 要销毁的份额
     * @param i 要提取的代币
     * @param minAmountOut 必须提取的最小代币i数量 
     */
    function removeLiquidityOneToken(
        uint shares,
        uint i,
        uint minAmountOut
    ) external returns (uint amountOut) {
        (amountOut, ) = _calcWithdrawOneToken(shares, i);
        require(amountOut >= minAmountOut, "out < min");

        balances[i] -= amountOut;
        _burn(msg.sender, shares);

        IERC20(tokens[i]).transfer(msg.sender, amountOut);
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