// SPDX-License-Identifier: AGPL-3.0 
pragma solidity ^0.8.13;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

enum OrderType { SELL, BUY }

contract CowswapMarketOrder {
    using SafeERC20 for IERC20;

    event OrderSubmitted(address user, address fromToken, address toToken, uint256 orderAmount, OrderType orderType);

    mapping(address => uint128) public nonces;
    mapping(bytes32 => bool) public approvedOrders;

    function submitMarketSell(
        address _sellToken, 
        address _buyToken,
        uint256 _sellAmount
    ) external {
        _submitOrder(msg.sender, _sellToken, _buyToken, _sellAmount, OrderType.SELL);
    }

    function submitMarketBuy(
        address _sellToken,
        address _buyToken,
        uint256 _buyAmount
    ) external {
        _submitOrder(msg.sender, _sellToken, _buyToken, _buyAmount, OrderType.BUY);
    }

    function _submitOrder(
        address _user,
        address _fromToken,
        address _toToken,
        uint256 _orderAmount,
        OrderType _orderType
    ) internal {
        approvedOrders[keccak256(abi.encode(_user, _fromToken, _toToken, _orderAmount, _orderType))] = true;

        emit OrderSubmitted(_user, _fromToken, _toToken, _orderAmount, _orderType);
    }
}
