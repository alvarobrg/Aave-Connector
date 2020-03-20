pragma solidity ^0.5.7;

import "./FlashLoanReceiverBase .sol";


interface UniswapPool {
    // Address of ERC20 token sold on this exchange
    function tokenAddress() external view returns (address token);
    // Address of Uniswap Factory
    function factoryAddress() external view returns (address factory);
    // Provide Liquidity
    function addLiquidity(uint256 minLiquidity, uint256 maxTokens, uint256 deadline) external payable returns (uint256);
    
    function ethToTokenSwapInput(uint256 min_tokens, uint256 deadline) external payable returns (uint256  tokens_bought);
    
    function tokenToEthSwapInput(uint256 tokens_sold, uint256 min_eth, uint256 deadline) external returns (uint256  eth_bought);
  
    function tokenToTokenSwapInput(uint256 tokens_sold, uint256 min_tokens_bought, uint256 min_eth_bought, uint256 deadline, address token_addr) external returns (uint256  tokens_bought);

    // ERC20 comaptibility for liquidity tokens
    function totalSupply() external view returns (uint);
}

contract Helper {
    function getExchange() public pure returns (address exchange) {
        exchange = 0xc4F86802c76DF98079F45A60Ba906bDf86Ad90C1;
    }
}

contract FlashLoanReceiver is FlashLoanReceiverBase, Helper {

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
        //approving unuswap
        IERC20(_reserve).approve(getExchange(), _amount);
        uint256 eth = UniswapPool(getExchange()).tokenToEthSwapInput(_amount, 0, block.timestamp + 300);
        
        uint256 tokens = UniswapPool(getExchange()).ethToTokenSwapInput.value(eth)(_amount, block.timestamp + 300);
        transferFundsBackToPoolInternal(_reserve, _amount.add(_fee));
    }
}
