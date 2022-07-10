// SPDX-License-Identifier: AGPL-3.0 
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {CowswapMarketOrder, OrderType} from "../src/CowswapMarketOrder.sol";

contract CowswapMarketOrderTest is Test {
    CowswapMarketOrder cmo;

    address public user = address(1);
    address fromToken = 0x6810e776880C02933D47DB1b9fc05908e5386b96; // GNO
    address toToken = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48; // USDC

    function setUp() public {
        cmo = new CowswapMarketOrder();
        deal(fromToken, user, 100e18);
    }

    function testSubmitSell() public {
        vm.prank(user);
        cmo.submitMarketSell(fromToken, toToken, 50e18);

        assertTrue(cmo.approvedOrders(keccak256(abi.encode(user, fromToken, toToken, 50e18, OrderType.SELL))));
    }
}
