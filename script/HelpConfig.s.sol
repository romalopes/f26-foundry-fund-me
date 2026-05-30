// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/Test.sol";
import {MockV3Aggregator} from "../test/mocks/MockV3Aggregator.sol";

error NetworkNotSupported(uint256 chainId);

contract HelpConfig is Script {
    struct NetworkConfig {
        address priceFeedAddress; // ETH/USD price feed address
    }

    NetworkConfig public s_activeNetworkConfig;
    uint8 public constant DECIMALS = 8;
    int256 public constant INITIAL_PRICE = 2000e8;
    mapping(uint256 => address) public s_priceFeedAddress;
    MockV3Aggregator mockPriceFeed;

    constructor() {
        s_priceFeedAddress[11155111] = 0x694AA1769357215DE4FAC081bf1f309aDC325306; // Sepolia ETH/USD
        s_priceFeedAddress[1] = 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419; // Mainnet ETH/USD
        s_priceFeedAddress[421614] = 0xd30e2101a97dcbAeBCBC04F14C3f624E67A35165; // Arbitrum Sepolia ETH/USD
        s_priceFeedAddress[80002] = 0xF0d50568e3A7e8259E16663972b11910F89BD8e7; // Polygon Amoy ETH/USD
        s_priceFeedAddress[11155420] = 0x61Ec26aA57019C486B10502285c5A3D4A4750AD7; // Optimism Sepolia ETH/USD
        s_priceFeedAddress[84532] = 0xE2E1CECaF186D44A4B01f46D6A7EcaE2B89c8076; // Base Sepolia ETH/USD
        s_priceFeedAddress[300] = 0xfEefF7c3fB57d18C5C6Cdd71e45D2D0b4F9377bF; // ZkSync Sepolia ETH/USD

        s_activeNetworkConfig = getActiveNetworkConfigWithMapping();
        // i_activeNetworkConfig = getActiveNetworkConfig();
    }

    function getMainnetEthConfig() private pure returns (NetworkConfig memory) {
        NetworkConfig memory mainnetConfig =
            NetworkConfig({priceFeedAddress: 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419});
        return mainnetConfig;
    }

    function getSepoliaEthConfig() private pure returns (NetworkConfig memory) {
        NetworkConfig memory sepoliaConfig =
            NetworkConfig({priceFeedAddress: 0x694AA1769357215DE4FAC081bf1f309aDC325306});
        return sepoliaConfig;
    }

    function getOrCreateAnvilEthConfig() private returns (NetworkConfig memory) {
        vm.startBroadcast();

        mockPriceFeed = new MockV3Aggregator(
            DECIMALS, // decimals
            INITIAL_PRICE // initial ETH/USD price
        );

        vm.stopBroadcast();

        NetworkConfig memory anvilConfig = NetworkConfig({priceFeedAddress: address(mockPriceFeed)});

        return anvilConfig;

        // if (anvilConfig.priceFeedAddress != address(0)) {
        //     return anvilConfig;
        // }

        // // Deploy mocks
        // vm.startBroadcast();
        // MockV3Aggregator mocks_priceFeedAddress = new MockV3Aggregator(18, 2000e8);
        // vm.stopBroadcast();

        // anvilConfig = NetworkConfig({priceFeedAddress: address(mocks_priceFeedAddress)});
        // return anvilConfig;
    }

    function getActiveNetworkConfigWithMapping() public returns (NetworkConfig memory) {
        if (s_activeNetworkConfig.priceFeedAddress != address(0)) return s_activeNetworkConfig;

        console.log("Using chainid: ", block.chainid);

        if (block.chainid == 31337) {
            s_activeNetworkConfig = getOrCreateAnvilEthConfig();
            return s_activeNetworkConfig;
        }

        if (s_priceFeedAddress[block.chainid] == address(0)) {
            revert NetworkNotSupported(block.chainid);
        }

        console.log("Using price feed address: ", s_priceFeedAddress[block.chainid]);
        s_activeNetworkConfig = NetworkConfig({priceFeedAddress: s_priceFeedAddress[block.chainid]});
        return s_activeNetworkConfig;
    }

    function getArbitrumSepoliaEthConfig() private pure returns (NetworkConfig memory) {
        NetworkConfig memory sepoliaConfig =
            NetworkConfig({priceFeedAddress: 0xd30e2101a97dcbAeBCBC04F14C3f624E67A35165});
        return sepoliaConfig;
    }

    function getOptimismSepoliaEthConfig() private pure returns (NetworkConfig memory) {
        NetworkConfig memory sepoliaConfig =
            NetworkConfig({priceFeedAddress: 0x61Ec26aA57019C486B10502285c5A3D4A4750AD7});
        return sepoliaConfig;
    }

    function getBaseSepoliaEthConfig() private pure returns (NetworkConfig memory) {
        NetworkConfig memory sepoliaConfig =
            NetworkConfig({priceFeedAddress: 0xE2E1CECaF186D44A4B01f46D6A7EcaE2B89c8076});
        return sepoliaConfig;
    }

    function getPolygonAmoyEthConfig() private pure returns (NetworkConfig memory) {
        NetworkConfig memory sepoliaConfig =
            NetworkConfig({priceFeedAddress: 0xF0d50568e3A7e8259E16663972b11910F89BD8e7});
        return sepoliaConfig;
    }

    function getZkSyncSepoliaEthConfig() private pure returns (NetworkConfig memory) {
        NetworkConfig memory sepoliaConfig =
            NetworkConfig({priceFeedAddress: 0xfEefF7c3fB57d18C5C6Cdd71e45D2D0b4F9377bF});
        return sepoliaConfig;
    }

    function getActiveNetworkConfig() public returns (NetworkConfig memory) {
        if (block.chainid == 11155111) {
            s_activeNetworkConfig = getSepoliaEthConfig();
        } else if (block.chainid == 31337) {
            s_activeNetworkConfig = getOrCreateAnvilEthConfig();
        } else if (block.chainid == 1) {
            s_activeNetworkConfig = getMainnetEthConfig();
        } else if (block.chainid == 421614) {
            s_activeNetworkConfig = getArbitrumSepoliaEthConfig();
        } else if (block.chainid == 11155420) {
            s_activeNetworkConfig = getOptimismSepoliaEthConfig();
        } else if (block.chainid == 84532) {
            s_activeNetworkConfig = getBaseSepoliaEthConfig();
        } else if (block.chainid == 80002) {
            s_activeNetworkConfig = getPolygonAmoyEthConfig();
        } else if (block.chainid == 300) {
            s_activeNetworkConfig = getZkSyncSepoliaEthConfig();
        } else {
            revert NetworkNotSupported(block.chainid);
        }
        return s_activeNetworkConfig;
    }
}
