// - Get funds from users
// - Withdraw funds
// - Set a minimum fund value in USD
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

// imports
import {PriceConverter} from "./PriceConverter.sol";

// errors
error FundMeNotOwner();

/**
 * @title A contract for crowd funding
 * @author Romalopes
 * @notice This contract is to demo a sample funding contract
 * @dev This implements price feeds as our library
 */
contract FundMe {
    // Functions Order:
    //// constructor
    //// receive
    //// fallback
    //// external
    //// public
    //// internal
    //// private
    //// view / pure

    /**
     * Network: Sepolia
     * Aggregator: BTC/USD
     * Address: 0x694AA1769357215DE4FAC081bf1f309aDC325306
     */
    constructor() {
        i_owner = msg.sender;
    }

    // Type Declarations
    using PriceConverter for uint256;

    uint256 public unlockTime = block.timestamp + 1 days;
    uint256 public constant MINIMUM_USD = 5e18;
    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;
    mapping(address => uint256) public addressToContributionCount;
    address public immutable i_owner;

    event FundReceived(address indexed funder, uint256 amount);
    event Withdrawn(address indexed owner, uint256 amount);

    function getMinimumUSD() public pure returns (uint256) {
        return MINIMUM_USD;
    }

    function getOwner() public view returns (address) {
        return i_owner;
    }

    function fund() public payable {
        // Allow users to send money
        // set minimum $ sent
        // require(msg.value >= 1e18, "didn't send enough eht"); // 1 eth
        // require(PriceConverter.getConversionRate(msg.value) >= minimumUSD, "didn't send enough eht"); // 1 eth
        require(msg.value.getConversionRate() >= MINIMUM_USD, "didn't send enough eht"); // 1 eth
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
        addressToContributionCount[msg.sender] += 1;
        emit FundReceived(msg.sender, msg.value);
    }

    function withdraw() public onlyOwner {
        // require(msg.sender == owner, "Only owner can withdraw the money.");
        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }

        funders = new address[](0);

        // Transfer
        // payable(msg.sender).transfer(address(this).balance);
        // Send
        // bool success = payable(msg.sender).send(address(this).balance);
        // require(success, "Send failed");
        // Call
        (bool success2,) = payable(msg.sender).call{value: address(this).balance}("");
        require(success2, "Call failed");

        emit Withdrawn(i_owner, address(this).balance);
    }

    function timedWithdraw() public onlyOwner onlyAfter(unlockTime) {
        withdraw();
    }

    function getConversionRate(uint256 amountEth) public view returns (uint256) {
        uint256 ethPrice = PriceConverter.getPrice();
        uint256 amountUsd = (amountEth * ethPrice) / 1e18;
        return amountUsd;
    }

    function contributionCount(address funder) public view returns (uint256) {
        return addressToContributionCount[funder];
    }

    function callAmountTo(address payable receiver) public payable {
        (bool success,) = receiver.call{value: msg.value}("");
        require(success, "Call failed");
    }

    function callAmountTo(address payable recipient, uint256 amount) public {
        (bool success,) = recipient.call{value: amount}("");
        require(success, "Call failed");
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    //Modifiers
    modifier onlyOwner() {
        // require(msg.sender == i_owner, "Sender is not owner");
        if (msg.sender == i_owner) {
            revert FundMeNotOwner();
        }
        _;
    }

    modifier onlyAfter(uint256 _time) {
        require(block.timestamp >= _time, "Too early");
        _;
    }

    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }
}

