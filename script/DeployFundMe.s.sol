// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {Script} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";
import {HelpConfig} from "./HelpConfig.s.sol";
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract DeployFundMe is Script {
    FundMe private fundMe;

    function setUp() public {
        // fundMe = new FundMe(i_priceFeed);
    }

    function run() public returns (FundMe) {
        HelpConfig helpConfig = new HelpConfig();
        HelpConfig.NetworkConfig memory networkConfig = helpConfig.getActiveNetworkConfigWithMapping();
        address priceFeedAddress = networkConfig.priceFeedAddress;
        vm.startBroadcast();
        fundMe = new FundMe(AggregatorV3Interface(priceFeedAddress));
        vm.stopBroadcast();
        return fundMe;
    }
}
