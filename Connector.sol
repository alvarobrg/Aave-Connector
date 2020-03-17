pragma solidity ^0.5.7;

interface AaveInterface {
     function deposit(address _reserve, uint256 _amount, uint16 _referralCode) external;
     
     function borrow(address _reserve, uint256 _amount, uint256 _interestRateMode, uint16 _referralCode) external;

     function repay(address _reserve, uint256 _amount, address payable _onBehalfOf) external;

}

interface IERC20 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

contract Helper {
    function getLendingPool() public pure returns (address lendingpool) {
        lendingpool = 0x9E5C7835E4b13368fd628196C4f1c6cEc89673Fa;
    }
    
    function getDAI() public pure returns (address dai) {
        dai = 0x4F96Fe3b7A6Cf9725f59d353F723c1bDb64CA6Aa;
    }
}

contract AaveConnector is Helper {
 function deposit(address _reserve, uint256 _amount, uint16 _referralCode) public {
     AaveInterface(getLendingPool()).deposit(_reserve, _amount, _referralCode);
 }
 
 function borrow(address _reserve, uint256 _amount, uint256 _interestRateMode, uint16 _referralCode) public {
     AaveInterface(getLendingPool()).borrow(_reserve, _amount, _interestRateMode, _referralCode);
 }
 
 function repay(address _reserve, uint256 _amount, address payable _onBehalfOf, uint256 _maxamount) public {
     IERC20(getDAI()).approve(getDAI(), _maxamount);
     AaveInterface(getLendingPool()).repay(_reserve, _amount, _onBehalfOf);
 }

}
