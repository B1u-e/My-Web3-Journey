# 62.Crowd Fund
众筹ERC20代币

1. 用户创建一个众筹活动。
2. 用户可以承诺，将其代币转移到众筹活动。
3. 众筹活动结束后，如果筹集的总金额超过众筹目标，活动创建者可以申领资金。
4. 否则，如果众筹活动未达到目标，用户可以撤回他们的承诺。

## Crowd Fund合约例子
* IERC20 接口
ERC20代币的标准接口，定义了代币的转账和转账授权功能。
```solidity
interface IERC20 {
    function transfer(address, uint) external returns (bool);

    function transferFrom(address, address, uint) external returns (bool);
}
```

### CrowdFund主合约，包含了众筹相关的所有函数和数据结构
实现了IERC20定义的所有功能，包含4个事件声明、3个状态变量和7个函数。实现都比较简单，每个函数的功能见代码注释：
```solidity
contract CrowdFund {
    //表示众筹项目被创建并启动
    event Launch(
        uint id,
        address indexed creator,
        uint goal,
        uint32 startAt,
        uint32 endAt
    );
    //表示众筹项目被取消
    event Cancel(uint id);
    //表示用户向某个众筹项目中贡献了一定的金额
    event Pledge(uint indexed id, address indexed caller, uint amount);
    //表示用户取消了对某个众筹项目的贡献。
    event Unpledge(uint indexed id, address indexed caller, uint amount);
    //表示众筹项目的创建者请求取回所有筹集的资金。
    event Claim(uint id);
    //表示众筹项目的贡献者请求退回他们的贡献资金。
    event Refund(uint id, address indexed caller, uint amount);

    struct Campaign {
        // 活动的创建者
        address creator;
        // 筹集代币的数量
        uint goal;
        // 承诺的总金额
        uint pledged;
        // 活动开始时间戳
        uint32 startAt;
        // 活动结束时间戳
        uint32 endAt;
        // 如果目标已经达成并且创建者已经领取了代币，则为True。
        bool claimed;
    }    

    IERC20 public immutable token;
    // 创建的活动总数。
    // 它也用于为新的活动生成ID。
    uint public count;
    // 将id映射到活动
    mapping(uint => Campaign) public campaigns;
    // 从活动ID => 支持者 => 支持金额的映射
    mapping(uint => mapping(address => uint)) public pledgedAmount;
    
    //初始化了一个代币接口的实例，并将其保存在不可变的变量token中。
    constructor(address _token) {
        token = IERC20(_token);
    }
    
    //：创建一个新的众筹活动，指定筹集代币的数量、活动开始和结束的时间戳，并将其保存在campaigns映射中
    function launch(uint _goal, uint32 _startAt, uint32 _endAt) external {
        require(_startAt >= block.timestamp, "start at < now");
        require(_endAt >= _startAt, "end at < start at");
        require(_endAt <= block.timestamp + 90 days, "end at > max duration");

        count += 1;
        campaigns[count] = Campaign({
            creator: msg.sender,
            goal: _goal,
            pledged: 0,
            startAt: _startAt,
            endAt: _endAt,
            claimed: false
        });

        emit Launch(count, msg.sender, _goal, _startAt, _endAt);
    }
    
    //取消一个众筹活动，只有创建者可以调用此函数。如果活动已经开始，则无法取消。
    function cancel(uint _id) external {
        Campaign memory campaign = campaigns[_id];
        require(campaign.creator == msg.sender, "not creator");
        require(block.timestamp < campaign.startAt, "started");

        delete campaigns[_id];
        emit Cancel(_id);
    }
    
    //承诺一定数量的代币支持众筹活动。只有在活动开始和结束时间之间才能承诺。
    function pledge(uint _id, uint _amount) external {
        Campaign storage campaign = campaigns[_id];
        require(block.timestamp >= campaign.startAt, "not started");
        require(block.timestamp <= campaign.endAt, "ended");

        campaign.pledged += _amount;
        pledgedAmount[_id][msg.sender] += _amount;
        token.transferFrom(msg.sender, address(this), _amount);

        emit Pledge(_id, msg.sender, _amount);
    }
    //取消对众筹活动的承诺。只有在活动结束之前才能取消承诺。
    function unpledge(uint _id, uint _amount) external {
        Campaign storage campaign = campaigns[_id];
        require(block.timestamp <= campaign.endAt, "ended");

        campaign.pledged -= _amount;
        pledgedAmount[_id][msg.sender] -= _amount;
        token.transfer(msg.sender, _amount);

        emit Unpledge(_id, msg.sender, _amount);
    }
    
    //领取众筹活动中承诺的代币。只有活动的创建者可以调用此函数。只有在活动结束之后，承诺的代币数量达到了目标数量，并且尚未领取代币时，才能领取代币。
    function claim(uint _id) external {
        Campaign storage campaign = campaigns[_id];
        require(campaign.creator == msg.sender, "not creator");
        require(block.timestamp > campaign.endAt, "not ended");
        require(campaign.pledged >= campaign.goal, "pledged < goal");
        require(!campaign.claimed, "claimed");

        campaign.claimed = true;
        token.transfer(campaign.creator, campaign.pledged);

        emit Claim(_id);
    }

    //退款。只有在活动结束之后，承诺的代币数量没有达到目标数量时才能退款。
    function refund(uint _id) external {
        Campaign memory campaign = campaigns[_id];
        require(block.timestamp > campaign.endAt, "not ended");
        require(campaign.pledged < campaign.goal, "pledged >= goal");

        uint bal = pledgedAmount[_id][msg.sender];
        pledgedAmount[_id][msg.sender] = 0;
        token.transfer(msg.sender, bal);

        emit Refund(_id, msg.sender, bal);
    }
}
```