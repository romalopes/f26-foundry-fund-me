// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {Script} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";

contract FundMeScript is Script {
    FundMe public fundMe;

    function setUp() public {
        fundMe = new FundMe();
    }

    function run() public {
        vm.startBroadcast();

        fundMe = new FundMe();

        vm.stopBroadcast();
    }
}
