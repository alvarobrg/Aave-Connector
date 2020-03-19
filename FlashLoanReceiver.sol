pragma solidity ^0.5.7;

import "./FlashLoanReceiverBase .sol";

contract FlashLoanReceiver is FlashLoanReceiverBase {

    using SafeMath for uint256;
    
    constructor(ILendingPoolAddressesProvider _provider)
    FlashLoanReceiverBase(_provider)
    public {}
    
    function executeOperation(
        address _reserve,
        uint256 _amount,
        uint256 _fee,
        bytes calldata _params) external {

        //check the contract has the specified balance
        require(_amount <= getBalanceInternal(address(this), _reserve), 
            "Invalid balance for the contract");

        /**

        CUSTOM ACTION TO PERFORM WITH THE BORROWED LIQUIDITY

        */

        transferFundsBackToPoolInternal(_reserve, _amount.add(_fee));
    }
}
