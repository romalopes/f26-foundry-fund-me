// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";
import {PriceConverter} from "../../src/PriceConverter.sol";
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
    uint256 internal constant GAS_PRICE = 1;
    address alice = makeAddr("alice");

    function setUp() public {
        deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
        vm.deal(alice, STARTING_BALANCE);
        // fundMe = new FundMe();
        console.log("FundMe deployed to: ", address(fundMe));
        console.log("Test contract address: ", address(this));
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
        fundMe.fund(); // sending 0 eth
    }

    function testFundUpdatesFundDataStructure() public {
        // vm.prank(alice); // alice is msg.sender for the next call
        vm.startPrank(alice);
        fundMe.fund{value: SEND_VALUE}();
        uint256 amountFunded = fundMe.getAddressToAmountFunded(alice);
        vm.stopPrank();
        assertEq(amountFunded, SEND_VALUE);
    }

    function testOnlyOwnerNotOwnerCanWithdraw() public {
        vm.expectRevert();
        fundMe.withdraw();
    }

    modifier funded() {
        vm.prank(alice);
        fundMe.fund{value: SEND_VALUE}();

        assert(address(fundMe).balance > 0);

        _;
    }

    function testOnlyOwnerRevertCanWithdraw() public {
        vm.prank(alice);

        vm.expectRevert();

        fundMe.withdraw();
    }

    function testOnlyOwnerCanWithdraw() public {
        // vm.prank(alice); // alice is msg.sender for the next call
        vm.startPrank(alice);
        console.log("Contract balance BEFORE funding:", address(fundMe).balance);
        console.log("msg.sender", msg.sender);
        console.log("fundMe.i_owner", fundMe.i_owner());
        fundMe.fund{value: SEND_VALUE}();
        vm.stopPrank();
        console.log("Contract balance AFTER funding:", address(fundMe).balance);
        vm.prank(msg.sender); // msg.sender is the owner for the next call
        fundMe.withdraw();
    }

    function testOnlyOwnerCanWithdrawWithAlicePrank() public funded {
        vm.expectRevert();
        vm.prank(alice);
        fundMe.withdraw();
    }

    function testOnlyOwnerAlicePrankCanWithdraw() public funded {
        console.log("Contract balance BEFORE funding:", address(fundMe).balance);
        console.log("msg.sender", msg.sender);
        // vm.startPrank(alice);
        // console.log("fundMe.i_owner", fundMe.i_owner());
        // fundMe.fund{value: SEND_VALUE}();
        // vm.stopPrank();
        console.log("Contract balance AFTER funding:", address(fundMe).balance);
        vm.expectRevert();
        fundMe.withdraw();
    }

    function testAddsFunderToArrayOfFunders() public {
        vm.startPrank(alice);
        fundMe.fund{value: SEND_VALUE}();
        vm.stopPrank();

        address funder = fundMe.getFunder(0);
        assertEq(funder, alice);
    }

    // function testWithdrawFromASingleFunder() public funded {
    //     // Arrange
    //     uint256 startingFundMeBalance = address(fundMe).balance;
    //     uint256 startingOwnerBalance = fundMe.getOwner().balance;

    //     // Act
    //     vm.startPrank(fundMe.getOwner());
    //     fundMe.withdraw();
    //     vm.stopPrank();

    //     // Assert
    //     uint256 endingFundMeBalance = address(fundMe).balance;
    //     uint256 endingOwnerBalance = fundMe.getOwner().balance;
    //     assertEq(endingFundMeBalance, 0);
    //     assertEq(startingFundMeBalance + startingOwnerBalance, endingOwnerBalance);
    // }

    function testWithdrawWithaSingleFunder() public funded {
        // Test the withdraw function with a single funder
        uint256 initialOnwerBalance = fundMe.getOwner().balance;
        uint256 initialFundMeBalance = address(fundMe).balance;

        uint256 gasStart = gasleft();
        console.log("Gas price: ", tx.gasprice);
        console.log("Gas start: ", gasStart);
        vm.txGasPrice(GAS_PRICE); // Set gas price to 0 for testing
        vm.prank(fundMe.getOwner()); // Start a prank as the owner
        fundMe.withdraw(); // Withdraw funds
        uint256 gasEnd = gasleft();
        console.log("Gas end: ", gasEnd);
        uint256 gasUsed = (gasStart - gasEnd) * tx.gasprice;

        console.log("Gas used for withdraw: %s", gasUsed);
        console.log("Initial Owner Balance: %s", initialOnwerBalance);
        console.log("Initial FundMe Balance: %s", initialFundMeBalance);
        // Check the final balances
        uint256 finalOnwerBalance = fundMe.getOwner().balance;
        uint256 finalFundMeBalance = address(fundMe).balance;
        assertEq(finalFundMeBalance, 0); // Check that the contract balance is 0
        assertEq(initialFundMeBalance + initialOnwerBalance, finalOnwerBalance); // Check that the owner's balance is updated correctly
        assertEq(fundMe.getAddressToAmountFunded(alice), 0); // Check that the amount funded is reset to 0
    }

    function testWithdrawFromMultipleFunders() public funded {
        // Arrange
        uint160 numberOfFunders = 10;
        uint160 startingFunderIndex = 1; // avoid address(0)
        for (uint160 i = startingFunderIndex; i < numberOfFunders + startingFunderIndex; i++) {
            // we get hoax from stdcheats which is a combination of prank and deal, it sets the msg.sender to the address we want and also gives that address some ether to work with
            hoax(address(i), SEND_VALUE); // prank + deal
            fundMe.fund{value: SEND_VALUE}();
        }

        uint256 startingFundMeBalance = address(fundMe).balance;
        uint256 startingOwnerBalance = fundMe.getOwner().balance;
        console.log("Starting FundMe balance: ", startingFundMeBalance); // this is the balance of the contract before the withdrawal
        console.log("Starting Owner balance: ", startingOwnerBalance); // this is the owner balance before the withdrawal
        // Act
        vm.startPrank(fundMe.getOwner());
        fundMe.withdraw();
        vm.stopPrank();

        // Assert
        assert(address(fundMe).balance == 0);
        assert(startingFundMeBalance + startingOwnerBalance == fundMe.getOwner().balance);
        assert((numberOfFunders + 1) * SEND_VALUE == fundMe.getOwner().balance - startingOwnerBalance);
    }

    function testWithdrawFromMultipleFundersCheaper() public funded {
        uint160 numberOfFunders = 10;
        uint160 startingFunderIndex = 1;

        for (uint160 i = startingFunderIndex; i < numberOfFunders + startingFunderIndex; i++) {
            hoax(address(i), SEND_VALUE);

            fundMe.fund{value: SEND_VALUE}();
        }

        uint256 startingFundMeBalance = address(fundMe).balance;

        uint256 startingOwnerBalance = fundMe.getOwner().balance;

        vm.startPrank(fundMe.getOwner());

        fundMe.cheaperWithdraw();

        vm.stopPrank();

        assert(address(fundMe).balance == 0);

        assert(startingFundMeBalance + startingOwnerBalance == fundMe.getOwner().balance);

        assert((numberOfFunders + 1) * SEND_VALUE == fundMe.getOwner().balance - startingOwnerBalance);
    }

    receive() external payable {
        console.log("Receive function called with value: ", msg.value);
    }

    fallback() external payable {
        console.log("Fallback function called with value: ", msg.value);
    }
}
