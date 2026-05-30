// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";
import {DeployFundMe} from "../script/DeployFundMe.s.sol";
import {PriceConverter} from "../src/PriceConverter.sol";
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMeTest is Test {
    // Functions Order:
    //// constructor
    //// receive
    //// fallback
    //// external
    //// public
    //// internal
    //// private
    //// view / pure
    FundMe public fundMe;
    DeployFundMe public deployFundMe;
    AggregatorV3Interface private s_priceFeed;
    uint256 constant SEND_VALUE = 0.1 ether;
    uint256 constant STARTING_BALANCE = 10 ether;
    address alice = makeAddr("alice");

    function setUp() public {
        deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
        vm.deal(alice, STARTING_BALANCE);
        // fundMe = new FundMe();
    }

    // function test_Fund() public {
    // uint256 amount = 1 ether;
    // fundMe.fund{value: amount}();
    // assertEq(fundMe.addressToAmountFunded(address(this)), amount);
    // }

    function testMinimumDollarIsFive() public view {
        console.log(fundMe.MINIMUM_USD());
        console.log("TEST TEST");
        assertEq(fundMe.MINIMUM_USD(), 5e18);
    }

    function testDemo() public pure {
        console.log("TEST TEST 2 22");
    }

    function testOwnerIsMsgSender() public view {
        console.log("testOwnerIsMsgSender");
        console.log(msg.sender);
        console.log(address(this));
        // assertEq(fundMe.getOwner(), address(this));
        assertEq(fundMe.getOwner(), msg.sender);
    }

    function testPriceFeedVersionIsAccurate() public view {
        console.log("testPriceFeedVersionIsAccurate");
        uint256 version = fundMe.getVersion();
        assertEq(version, 4);
    }

    function testPriceFeedDecimalsAreAccurate() public view {
        uint8 decimals = fundMe.getDecimals();
        assertEq(decimals, 8);
    }

    function testPriceFeedPriceIsAccurate() public view {
        uint256 price = fundMe.getPrice();
        console.log("Price: ", price);
        assert(price > 198760000000000000000 && price < 3000000000000000000000);
    }

    function testFundFailsWithoutEnoughETH() public {
        // vm.expectRevert(); // Fund reverts without enough ETH
        vm.expectRevert(bytes("didn't send enough eht"));
        fundMe.fund();
    }

    function testFundUpdatesFundDataStructure() public {
        // vm.prank(alice); // alice is msg.sender for the next call
        vm.startPrank(alice);
        fundMe.fund{value: SEND_VALUE}();
        uint256 amountFunded = fundMe.getAddressToAmountFunded(alice);
        vm.stopPrank();
        assertEq(amountFunded, SEND_VALUE);
    }
}
