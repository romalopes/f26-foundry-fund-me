// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";
import {PriceConverter} from "../src/PriceConverter.sol";

contract FundMeTest is Test {
    FundMe public fundMe;

    function setUp() public {
        fundMe = new FundMe();
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
        assertEq(fundMe.getOwner(), address(this));
    }

    function testPriceFeedVersionIsAccurate() public view {
        console.log("testPriceFeedVersionIsAccurate");
        uint256 version = PriceConverter.getVersion();
        assertEq(version, 4);
    }

    function testPriceFeedDecimalsAreAccurate() public view {
        uint8 decimals = PriceConverter.getDecimals();
        assertEq(decimals, 8);
    }

    function testPriceFeedPriceIsAccurate() public view {
        uint256 price = PriceConverter.getPrice();
        assert(price > 198760000000000000000 && price < 3000000000000000000000);
    }
}
