//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;
/// @title Staking
//all the imports for upgradeable contract
import "@openzeppelin/contracts-upgradeable/token/ERC20/IERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract Staking is Initializable, OwnableUpgradeable, UUPSUpgradeable {

/// @dev using libraries for the different data types
    using SafeMath for uint256;
    using EnumerableSet for EnumerableSet.AddressSet;
    /// @dev defining the end of the staking period
    uint public stakingPeriod;

    /// @dev Total amount of tokens in stkaing contract
    uint public totalStakedInPool;

    /// @dev defining the total staked in the staking pool
    EnumerableSet.AddressSet private userList;

    /// @dev defining upgradeable Perks Contract
    IERC20Upgradeable public perkToken;

    /// @dev defining upgradeable MyToken contract
    IERC20Upgradeable public myToken;

    /// @dev defining the chainlink aggregator
    AggregatorV3Interface public chainlinkAggregatorAddress;
    
    /**
        @dev amountStaked: total amount staked by user
        @dev stakingDuration: earliest unix timestamp of user's stake
        @dev bonusTokens: total reward token's earned by user 
        @dev bonusUnstake: earliest unix timestamp of user's reward withdrawl
    */
    struct UserInfo {
        uint amountStaked;
        uint stakingDuration;
        uint bonusTokens;
        uint bonusUnstake;
    }
    /// @dev accesing the userinfo struct
    mapping(address => UserInfo) public userInfo;


    /**
    /// @dev initialising the contract and it's function
    /// @param perkCont: Perk Contract address
    /// @param myTokenCont: MY Token Contract Address
    /// @param _chainlinkAggregatorAddress: chainlink aggregator address
    /// @param _stakingPeriod: timestamp of staking duration
    */ 
    function initialize (
        IERC20Upgradeable perkCont,
        IERC20Upgradeable myTokenCont,
        AggregatorV3Interface _chainlinkAggregatorAddress,
        uint _stakingPeriod
    ) external initializer {
        perkToken = perkCont;
        myToken = myTokenCont;
        chainlinkAggregatorAddress = _chainlinkAggregatorAddress;
        stakingPeriod = _stakingPeriod;
        __Ownable_init();
        __UUPSUpgradeable_init();
    }

/// @notice To authorize the owner to upgrade the contract 
    function _authorizeUpgrade(address newImplementation) internal override onlyOwner {}

   /// @notice depositing myTokens in the pool.
   /// @param _amount: the amount which have to be staked.
    function depositInPool (uint _amount) external {
        UserInfo storage user = userInfo[msg.sender];
        require(_amount > 0, "depositStableCoin:: amount should be greater than zero");

        user.stakingDuration = block.timestamp;

        IERC20Upgradeable(myToken).transferFrom(msg.sender, address(this), _amount);

        updateUser();
        
        user.amountStaked = user.amountStaked.add(_amount);

        totalStakedInPool = totalStakedInPool.add(_amount);

        if(!userList.contains(msg.sender)) {
            userList.add(msg.sender);
        }
    }

   /// @notice unstaking the myToken along with rewards
   /// @param _amount: amount to withdraw from the pool
    function unstake(uint _amount) external {
        UserInfo storage user = userInfo[msg.sender];
        require(_amount <= user.amountStaked, "unstake:: can not withdraw more than your staked amount");

        updateUser();

        IERC20Upgradeable(myToken).transfer(msg.sender, _amount);

        user.amountStaked = user.amountStaked.sub(_amount);

        totalStakedInPool = totalStakedInPool.sub(_amount);

        if(userList.contains(msg.sender)) {
            userList.remove(msg.sender);
        }
    }

    /// @notice withdraw reward tokens earned and for updating user profile
    function claimMyToken() external {
        updateUser();
    }

    /**
     @notice fetch total rewards earned by user and address of whom you want to check rewards for.
     @param _userAddress: user's address to check balance.
     @return uint: pending rewards for @param
    */
    function remainingRewardAmount(address _userAddress) external view returns(uint) {
        uint pendingAmount = remainingReward(_userAddress);
        return pendingAmount; 
    }

    /**
        @notice update user information and transfer pending reward tokens (msg.sender)
        @dev internal function
        @dev smartcontract must have enough reward token balance
    */
    function updateUser() internal {
        UserInfo storage user = userInfo[msg.sender];
        uint pendingReward = remainingReward(msg.sender);
        if (pendingReward > 0) {
            IERC20Upgradeable(perkToken).transfer(msg.sender, pendingReward);
            user.bonusTokens = user.bonusTokens.add(pendingReward);
        }
        user.bonusUnstake = block.timestamp;
    }
     /**
        @notice fetch current price of PerkToken/USD and convert mytokens into usd price
        @dev internal function
        @return uint: current USD equivalent price of MyToken coin
    */
    function ConvertIntoCurrency() internal view returns(int) {
        (, int currentUSDPrice, , ,) = chainlinkAggregatorAddress.latestRoundData();
        return currentUSDPrice;
    }
     /**
        @notice get pending rewards generated by user and to know the pending amount
        @dev internal function
        @param _userAddress: user's address of whom you want to check rewards for
    */
    function remainingReward(address _userAddress) internal view returns(uint) {
        UserInfo storage user = userInfo[msg.sender];
        if(!userList.contains(_userAddress)) {
            return 0;
        }

        if(user.amountStaked == 0) {
            return 0;
        }

        uint stakedTimeDifference = block.timestamp.sub(userInfo[msg.sender].bonusUnstake);
        uint stakedAmountByUser = user.amountStaked;
        uint stakedAmountInUSD = stakedAmountByUser.mul(uint256(ConvertIntoCurrency())).div(1e8);

        uint _rewardRate;
        //calculating the reward ratio as per the APR and amount invested and the time of investment
       if(block.timestamp <= user.stakingDuration.add(30 minutes)) {
            _rewardRate = 200;
        }
        else if(block.timestamp > user.stakingDuration.add(30 minutes) && block.timestamp <= user.stakingDuration.add(180 minutes)) {
            _rewardRate = 500;
        }
        else {
            _rewardRate =1000;
        }

        if(stakedAmountInUSD >= 100) {
            _rewardRate = _rewardRate.add(500);
        }        
        else if(stakedAmountInUSD >= 500) {
            _rewardRate = _rewardRate.add(1000);
        }
        else if(stakedAmountInUSD >= 1000) {
            _rewardRate = _rewardRate.add(1500);
        }

        uint totalPendingReward = stakedAmountByUser.mul(_rewardRate).mul(stakedTimeDifference).div(stakingPeriod).div(1e4);
        return totalPendingReward;
    }


}
