# Foundry FUND ME

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

- **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
- **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
- **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
- **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```

# ------------------------------------------------

```

```

# ---#############################################

```shell
// create the project
$ forge init
$ forget test
// To install the chainlink kit. //Add in the mappings and link in the file.
$ forge install smartcontractkit/chainlink-brownie-contracts@0.6.1
$ forge clear
$ forge build
$ forge test -vv
$ forge script script/DeployFundMe.s.sol
// Pretends it is going to alchemy sepolia
$ forge test --match-test test_isPriceFeedVersionAccurate -vvv --fork-url $ALCHEMY_RPC_URL
$ forge test -vvv --fork-url $ALCHEMY_RPC_URL
$ forge coverage -vvv --fork-url $ALCHEMY_RPC_URL
$ forge test -vvv --fork-url $LOCAL_RPC_URL
$ forge test --match-test testFundUpdatesFundedDataStructure -vvv
$ forge test --match-test testWithdrawWithaSingleFunder -vvv
// Shows the amount of gas used. It usually should much righer because it involves the test of test.
$ forge snapshot
// Shows the storage variables.
$ forge inspect FundMe storageLayout --json -vvv -s
$ cast storage
$ forge script script/DeployFundMe.s.sol --rpc-url http://localhost:8545 --private-key $ANVIL_PRIVATE_KEY --broadcast
$ cast storage 0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512 1

$ forge install ChainAccelOrg/foundry-devops
$ forge script script/Interactions.s.sol:FundFundMe --rpc-url http://localhost:8545 --private-key $ANVIL_PRIVATE_KEY --broadcast
$ forge test --match-test testUserCanFundAndOwnerWithdraw -vvv
$ forge test --match-test testUserCanWithdrawInteractions -vvv
$ forge test --rpc-url $METAMASK_RPC_URL
$ forge test --fork-url $METAMASK_RPC_URL
```

The smart contract....
0xe02843FfD59142aefDA413C267148b0E23002195

# ------------------------------------------------

```

```

# ---#############################################

# FundMe Project Setup

## Creating the Project

Navigate to your `foundry-f26` folder, then run:

```bash
mkdir f26-foundry-fund-me
cd f26-foundry-fund-me
code .
```

This creates a new folder, moves into it, and opens a new VS Code instance with it as the root.

---

## Initialising with Foundry

Inside the new folder, initialise a fresh Foundry project:

```bash
forge init
```

If the folder is not empty:

```bash
forge init --force
```

Foundry will scaffold the project with the standard structure:

```text
f26-foundry-fund-me/
│
├── src/        # Smart contracts
├── test/       # Solidity tests
├── script/     # Deployment and interaction scripts
├── lib/        # Dependencies
├── foundry.toml
└── README.md
```

It also generates three default Counter example files:

- `src/Counter.sol`
- `script/Counter.s.sol`
- `test/Counter.t.sol`

Take a moment to look through these before deleting them — they demonstrate the basic structure of a Foundry contract, script, and test.

Once reviewed, delete them and you're ready to start building FundMe from scratch.

## Important Project Folders

### `src/`

Contains the Solidity smart contracts.

Example:

```solidity
// src/FundMe.sol
pragma solidity ^0.8.18;

contract FundMe {

}
```

---

### `test/`

Contains Solidity-based tests.

Example:

```solidity
// test/FundMeTest.t.sol
pragma solidity ^0.8.18;
```

---

### `script/`

Contains deployment and interaction scripts.

Example:

```solidity
// script/DeployFundMe.s.sol
pragma solidity ^0.8.18;
```

---

## Foundry Commands Reference

### Compile Contracts

```bash
forge build
```

---

### Run Tests

```bash
forge test
```

---

### Format Solidity Code

```bash
forge fmt
```

---

### Deploy Scripts

```bash
forge script
```

---

## Key Concepts Learned

- Creating a new Foundry project
- Initializing the standard Foundry structure
- Understanding:
  - `src`
  - `test`
  - `script`
  - `lib`

- Using `forge init`
- Basic Foundry workflow commands

---

# Quick Start

```bash
# Create project
mkdir foundry-fund-me-f23

# Enter project
cd foundry-fund-me-f23

# Open in VS Code
code .

# Initialize Foundry
forge init

# Compile
forge build

# Run tests
forge test
```

# ------------------------------------------------

```

```

# ---###########################################

# Finishing the Setup

This section covers the final setup steps for the `FundMe` Foundry project, including:

- Removing default example contracts
- Importing Solidity files from Remix
- Installing dependencies
- Fixing import paths with remappings
- Successfully compiling the project

---

# 1. Remove Default Counter Files

Foundry initializes the project with example `Counter` contracts and tests.

Delete them before starting the `FundMe` project.

```bash
rm src/Counter.sol
rm test/Counter.t.sol
rm script/Counter.s.sol
```

---

# 2. Create FundMe Contracts

Inside the `src/` folder create two new files:

```bash
touch src/FundMe.sol
touch src/PriceConverter.sol
```

Project structure:

```text
foundry-fund-me-f23/
│
├── src/
│   ├── FundMe.sol
│   └── PriceConverter.sol
│
├── test/
├── script/
├── lib/
└── foundry.toml
```

---

# 3. Copy the Remix Contracts

Go to the Remix Fund Me repository and copy the contents of:

- `FundMe.sol`
- `PriceConverter.sol`

Paste them into the newly created files.

---

# 4. Try Compiling

Run:

```bash
forge compile
```

or

```bash
forge build
```

You will get compilation errors.

---

# 5. Understanding the Problem

Inside both contracts there is an import like this:

```solidity
import {AggregatorV3Interface}
from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
```

In Remix this works automatically because Remix handles dependencies behind the scenes.

In Foundry, dependencies must be installed manually.

---

# 6. Install Chainlink Contracts

Use `forge install` to install dependencies.

Run:

```bash
forge install smartcontractkit/chainlink-brownie-contracts@0.6.1 --no-commit
```

Wait for the installation to finish.

---

# 7. Understanding forge install

The command:

```bash
forge install <repository>@<version>
```

installs external libraries directly from GitHub repositories.

The version can be:

- A branch
- A tag
- A commit hash

Examples:

```bash
# Branch
forge install smartcontractkit/chainlink-brownie-contracts@master

# Tag
forge install smartcontractkit/chainlink-brownie-contracts@0.6.1

# Commit
forge install smartcontractkit/chainlink-brownie-contracts@8e8128
```

prevents Foundry from automatically creating a Git commit after installation.

This is useful when:

- You are still configuring the project
- You want manual control over commits

---

# 9. Installed Libraries

After installation, the `lib/` folder will contain:

```text
lib/
├── forge-std/
└── chainlink-brownie-contracts/
```

### forge-std

Installed automatically with:

```bash
forge init
```

Contains:

- Testing utilities
- Cheatcodes
- Console logging
- Standard Foundry helpers

---

### chainlink-brownie-contracts

Contains Chainlink smart contracts and interfaces.

Important path:

```text
lib/chainlink-brownie-contracts/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol
```

This is the interface imported by `FundMe.sol`.

---

# 10. Fixing Import Paths with Remappings

Even after installing the dependency, Foundry still needs to understand what:

```solidity
@chainlink/contracts/
```

means.

Open `foundry.toml` and add:

```toml
remappings = [
    '@chainlink/contracts/=lib/chainlink-brownie-contracts/contracts/'
]
```

Example:

```toml
[profile.default]
src = "src"
out = "out"
libs = ["lib"]

remappings = [
    '@chainlink/contracts/=lib/chainlink-brownie-contracts/contracts/'
]
```

---

# 11. Why Remappings Matter

This line tells Foundry:

```text
@chainlink/contracts/
```

should point to:

```text
lib/chainlink-brownie-contracts/contracts/
```

So this import:

```solidity
import {AggregatorV3Interface}
from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
```

becomes equivalent to:

```text
lib/chainlink-brownie-contracts/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol
```

---

# 12. Compile Again

Now run:

```bash
forge build
```

or:

```bash
forge compile
```

The project should compile successfully.

---

# 13. Key Concepts Learned

## Dependencies

External smart contract libraries installed into the project.

---

## forge install

Installs dependencies directly from GitHub repositories.

---

## Remappings

Maps import aliases to actual filesystem paths.

Example:

```toml
@chainlink/contracts/=lib/chainlink-brownie-contracts/contracts/
```

---

## Chainlink Aggregator Interface

Provides access to price feeds.

Example usage:

```solidity
AggregatorV3Interface priceFeed;
```

---

# 14. Common Smart Contract Development Challenges

Dependency management is one of the most common pain points in Solidity development and auditing.

Always verify:

- Correct repository path
- Correct dependency version
- Correct remappings
- Matching import statements

Small mismatches can cause compilation failures.

---

# 15. Quick Setup Recap

```bash
# Remove example contracts
rm src/Counter.sol
rm test/Counter.t.sol
rm script/Counter.s.sol

# Create new files
touch src/FundMe.sol
touch src/PriceConverter.sol

# Install Chainlink contracts
forge install smartcontractkit/chainlink-brownie-contracts@0.6.1 --no-commit

# Compile
forge build
```

---

# Final Result

You now have:

- A clean Foundry project
- Imported Remix contracts
- Installed Chainlink dependencies
- Working remappings
- A successfully compiling `FundMe` project

# ------------------------------------------------

```

```

# --#############################################

# Writing Tests for the FundMe Contract with Foundry

Testing is a critical part of smart contract development. Well-written tests help prevent deployment issues and are essential during security audits.

## 1. Create the Test File

Inside the `test/` folder, create:

```bash
test/FundMeTest.t.sol
```

> `.t.sol` is the Foundry naming convention for test files.

---

## 2. Basic Test Contract Structure

Import Foundry's testing library and inherit from `Test`.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";

contract FundMeTest is Test {

    function setUp() external { }

    function testDemo() public { }

}
```

Run tests:

```bash
forge test
```

---

- `import {Test} from "forge-std/Test.sol"` — gives access to Foundry's built-in test helpers and assertions
- `is Test` — the contract must inherit `Test` to use those helpers
- `setUp()` — always runs **first** before each test function. Use it for deployments, setting balances, approvals, etc.
- Any `public` function prefixed with `test` is automatically picked up and run by `forge test`

## 3. Understanding `setUp()`

`setUp()` runs **before every test function**.

Typical use cases:

- Deploy contracts
- Create test users
- Fund accounts
- Set approvals
- Initialize state

Example:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";

contract FundMeTest is Test {

    uint256 favNumber = 0;
    bool greatCourse = false;

    function setUp() external {
        favNumber = 1337;
        greatCourse = true;
    }

    function testDemo() public {
        assertEq(favNumber, 1337);
        assertEq(greatCourse, true);
    }
}
```

### Key Learning

Execution order:

1. State variables initialized
2. `setUp()` executes
3. All `test...()` functions run

---

## 4. Using `console.log` for Debugging

Import `console` alongside `Test`.

```solidity
import {Test, console} from "forge-std/Test.sol";
```

Example:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";

contract FundMeTest is Test {

    uint256 favNumber = 0;
    bool greatCourse = false;

    function setUp() external {
        favNumber = 1337;
        greatCourse = true;

        console.log("This will get printed first!");
    }

    function testDemo() public {
        assertEq(favNumber, 1337);
        assertEq(greatCourse, true);

        console.log("This will get printed second!");
        console.log("Updraft is changing lives!");
        console.log(
            "You can print multiple things:",
            favNumber,
            greatCourse
        );
    }
}
```

---

## 5. Test Verbosity

By default, `forge test` uses verbosity level `1`.

To see logs:

```bash
forge test -vv
```

Verbosity levels:

| Level    | Description                        |
| -------- | ---------------------------------- |
| `-v`     | Basic output                       |
| `-vv`    | Print logs for all tests           |
| `-vvv`   | Execution traces for failing tests |
| `-vvvv`  | Execution traces for all tests     |
| `-vvvvv` | Full execution and setup traces    |

Example output:

```text
Ran 1 test for test/FundMe.t.sol:FundMeTest
[PASS] testDemo()

Logs:
  This will get printed first!
  This will get printed second!
  Updraft is changing lives!
  You can print multiple things: 1337 true
```

---

## 6. Testing the FundMe Contract

Import and deploy `FundMe` inside `setUp()`.

```solidity
import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";

contract FundMeTest is Test {
    FundMe fundMe;

    function setUp() external {
        fundMe = new FundMe();
    }

    function testMinimumDollarIsFive() public {
        assertEq(fundMe.MINIMUM_USD(), 5e18);
    }
}
```

Run:

```bash
forge test
```

Expected result:

```text
[PASS] testMinimumDollarIsFive()
```

---

## 8. Testing Failures

To understand failed tests, intentionally change the expected value:

```solidity
assertEq(fundMe.MINIMUM_USD(), 6e18);
```

Running:

```bash
forge test
```

will show Foundry's failure output and assertion details.

---

## Important Testing Concepts

### `Test`

Provides helper functions such as:

```solidity
assertEq(...)
assertTrue(...)
assertFalse(...)
vm.*
console.log(...)
```

---

### `setUp()`

Runs before every test and is used to:

- Deploy contracts
- Configure users
- Initialize balances
- Prepare test state

---

### Test Naming Convention

All test functions should begin with:

```solidity
test...
```

Examples:

```solidity
testMinimumDollarIsFive()
testOwnerIsMsgSender()
testFundFailsWithoutEnoughETH()
```

Foundry automatically discovers and runs them.

---

## Useful Commands

Run tests:

```bash
forge test
```

Run with logs:

```bash
forge test -vv
```

Run a specific test:

```bash
forge test --match-test testMinimumDollarIsFive
```

Run tests with maximum verbosity:

```bash
forge test -vvvvv
```

---

## Summary

This section introduced the fundamentals of Foundry testing:

- Creating `.t.sol` test files
- Using `forge-std/Test.sol`
- Understanding the `setUp()` lifecycle
- Using `assertEq()` assertions
- Debugging with `console.log`
- Running tests with different verbosity levels
- Deploying contracts inside tests
- Writing your first meaningful test for `FundMe`

These fundamentals form the foundation for more advanced testing topics such as user impersonation (`vm.prank`), fuzz testing, invariant testing, and deployment script integration.

# ------------------------------------------------

```

```

# --#############################################

# Debugging a Failed Test — `msg.sender` vs `address(this)` - Understanding `msg.sender` and Contract Ownership

## Objective

Verify that the owner of the `FundMe` contract is set correctly during deployment.

---

## Initial Test

Add the following test:

```solidity
function testOwnerIsMsgSender() public {
    assertEq(fundMe.i_owner(), msg.sender);
}
```

Run:

```bash
forge test
```

Output:

```text
Ran 2 tests for test/FundMe.t.sol:FundMeTest

[PASS] testMinimumDollarIsFive()
[FAIL. Reason: assertion failed] testOwnerIsMsgSender()

Suite result: FAILED. 1 passed; 1 failed
```

The test fails even though `FundMe` was deployed in `setUp()`.

---

## Debugging with `console.log`

To investigate, print both addresses:

```solidity
function testOwnerIsMsgSender() public {
    console.log(fundMe.i_owner());
    console.log(msg.sender);

    assertEq(fundMe.i_owner(), msg.sender);
}
```

Run with verbosity:

```bash
forge test -vv
```

Output:

```text
Logs:

0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496
0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38

Error: a == b not satisfied [address]

Left:  0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496
Right: 0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38
```

The addresses are different.

---

## Why Does the Test Fail?

The key concept is understanding who actually deploys the contract.

In `setUp()`:

```solidity
function setUp() external {
    fundMe = new FundMe();
}
```

Although we run `forge test`, the deployment is executed by the **FundMeTest contract itself**.

Therefore:

- `FundMeTest` is the deployer.
- `FundMeTest` becomes the owner.
- `msg.sender` inside the test function is **not** the deployer.

### Deployment Flow

```text
forge test
    │
    ▼
FundMeTest.setUp()
    │
    ▼
new FundMe()
    │
    ▼
FundMe owner = FundMeTest contract
```

---

## Correct Test

Instead of comparing against `msg.sender`, compare against the testing contract address:

```solidity
function testOwnerIsMsgSender() public {
    assertEq(fundMe.i_owner(), address(this));
}
```

Run:

```bash
forge test
```

Output:

```text
[PASS] testOwnerIsMsgSender()
```

The test now passes.

---

## Key Concepts Learned

### `msg.sender` Depends on Context

`msg.sender` is the immediate caller of a function.

Examples:

```solidity
new FundMe();
```

Inside the `FundMe` constructor:

```solidity
msg.sender == address(FundMeTest)
```

Inside a test function:

```solidity
msg.sender != address(FundMeTest)
```

---

### `address(this)`

Represents the address of the current contract.

```solidity
address(this)
```

Inside `FundMeTest`, this returns the address of the testing contract itself.

Since `FundMeTest` deployed `FundMe`, the owner is:

```solidity
fundMe.i_owner() == address(this)
```

| Context                            | `msg.sender` refers to                                      |
| ---------------------------------- | ----------------------------------------------------------- |
| Inside `setUp()`                   | The test contract (`FundMeTest`)                            |
| Inside a `test*` function          | The test contract (`FundMeTest`)                            |
| Your terminal running `forge test` | Your EOA — but this is **not** propagated into the contract |

---

## Useful Debugging Techniques

### Print Values

```solidity
console.log(value);
```

### Print Addresses

```solidity
console.log(addressValue);
```

### Run Tests with Logs

```bash
forge test -vv
```

### Run a Specific Test

```bash
forge test --match-test testOwnerIsMsgSender
```

---

## Summary

This exercise demonstrates one of the most important Foundry testing concepts:

- Contracts deployed inside `setUp()` are deployed by the test contract.
- The deployer becomes the owner.
- `msg.sender` may not be what you initially expect during testing.
- `console.log` is a powerful debugging tool.
- `address(this)` often represents the correct owner when contracts are deployed directly from the test contract.

Understanding the distinction between `msg.sender` and `address(this)` is fundamental for writing accurate Foundry tests and debugging ownership-related issues.

When a contract deploys another contract, the **deploying contract** becomes `msg.sender` — not the external account that triggered the chain of calls.

# ------------------------------------------------

```

```

# --#############################################

# Advanced Deploy Scripts in Foundry

## Why Deploy Scripts Matter

Both `FundMe.sol` and `PriceConverter.sol` have the `AggregatorV3Interface` address hardcoded:

```solidity
AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306)
```

This address works on the Sepolia testnet, but creates a major limitation:

- ❌ Won't work on Anvil
- ❌ Won't work on Ethereum Mainnet
- ❌ Won't work on Arbitrum
- ❌ Won't work on other EVM chains

A deployment script is the first step toward making deployments configurable across multiple networks.

---

## Create the Deployment Script

Create a new file:

```text
script/DeployFundMe.s.sol
```

> `.s.sol` is the Foundry naming convention for deployment scripts.

---

## Basic Structure

### SPDX and Pragma

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
```

---

### Import Foundry's Script Library

Deployment scripts use `Script.sol`.

```solidity
import {Script} from "forge-std/Script.sol";
```

`Script.sol` provides access to Foundry cheatcodes such as:

```solidity
vm.startBroadcast();
vm.stopBroadcast();
```

---

### Import the Contract to Deploy

```solidity
import {FundMe} from "../src/FundMe.sol";
```

---

## Complete Deployment Script

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";

contract DeployFundMe is Script {
    function run() external {
        vm.startBroadcast();
        new FundMe();
        vm.stopBroadcast();
    }
}
```

Key components:

| Element               | Purpose                                      |
| --------------------- | -------------------------------------------- |
| `import {Script}`     | Gives access to Foundry scripting features   |
| `is Script`           | Makes this a Foundry script                  |
| `run()`               | Entry point called by `forge script`         |
| `vm.startBroadcast()` | Marks the start of transactions to broadcast |
| `vm.stopBroadcast()`  | Marks the end of transactions to broadcast   |
| `new FundMe()`        | Deploys the FundMe contract                  |

---

would only execute locally.

With broadcasting:

```solidity
vm.startBroadcast();
new FundMe();
vm.stopBroadcast();
```

Foundry signs and sends the transaction using the configured private key.

---

### Deploying the Contract

```solidity
new FundMe();
```

Creates a new instance of the contract and deploys it to the target network.

Equivalent conceptually to:

```solidity
FundMe fundMe = new FundMe();
```

The returned contract reference isn't needed in this simple example.

---

### `vm.stopBroadcast()`

```solidity
vm.stopBroadcast();
```

Stops transaction broadcasting.

Any code after this point executes locally again.

---

## Running the Script

Execute:

```bash
forge script script/DeployFundMe.s.sol
```

If compilation succeeds, Foundry will:

1. Compile contracts
2. Execute the script
3. Simulate deployment locally

Output should indicate successful execution.

---

## Deployment Flow

```text
forge script
      │
      ▼
DeployFundMe.run()
      │
      ▼
vm.startBroadcast()
      │
      ▼
new FundMe()
      │
      ▼
Contract deployed
      │
      ▼
vm.stopBroadcast()
```

---

## Why This Is Called "Advanced"

The script itself is simple, but it unlocks much more advanced deployment patterns:

### Future Improvements

Instead of:

```solidity
new FundMe();
```

we will eventually use:

```solidity
new FundMe(priceFeedAddress);
```

where `priceFeedAddress` changes depending on:

- Anvil
- Sepolia
- Ethereum Mainnet
- Arbitrum
- Polygon
- Base

This eliminates hardcoded addresses and makes contracts portable across networks.

---

## Useful Commands

### Run Script Locally

```bash
forge script script/DeployFundMe.s.sol
```

### Simulate with Verbose Logs

```bash
forge script script/DeployFundMe.s.sol -vvvv
```

### Broadcast to a Network

```bash
forge script script/DeployFundMe.s.sol \
--rpc-url <RPC_URL> \
--private-key <PRIVATE_KEY> \
--broadcast
```

---

## Key Concepts Learned

### Script Naming Convention

```text
DeployFundMe.s.sol
```

---

### Import Script Utilities

```solidity
import {Script} from "forge-std/Script.sol";
```

---

### Entry Point

```solidity
function run() external
```

---

### Start Broadcasting Transactions

```solidity
vm.startBroadcast();
```

---

### Deploy Contract

```solidity
new FundMe();
```

---

### Stop Broadcasting

```solidity
vm.stopBroadcast();
```

---

## Summary

Deployment scripts are a core part of professional Foundry development. They provide a repeatable and automated way to deploy contracts while preparing the project for multiple blockchain networks.

In this lesson you learned:

- How to create a `.s.sol` deployment script
- How to use `Script.sol`
- How `run()` acts as the script entry point
- How `vm.startBroadcast()` and `vm.stopBroadcast()` work
- How to deploy a contract using `new FundMe()`
- Why deployment scripts are essential for supporting multiple networks and avoiding hardcoded addresses

This foundation will be expanded later to support dynamic network configurations, mock contracts, and production-ready deployments.

# ------------------------------------------------

```

```

# --#############################################

# Running Tests on Chain Forks (Foundry Forking Tests)

## Types of Tests

| Type            | Description                                                              |
| --------------- | ------------------------------------------------------------------------ |
| **Unit**        | Test individual functions in isolation                                   |
| **Integration** | Test how a contract interacts with other contracts or external systems   |
| **Forking**     | Copy a live blockchain state at a point in time and test against it      |
| **Staging**     | Test against a deployed contract on a staging environment before mainnet |

---

## Problem: Testing External Dependencies

In the `FundMe` contract, The `testPriceFeedVersionIsAccurate` test fails on Anvil because the `AggregatorV3Interface` address (`0x694AA1769357215DE4FAC081bf1f309aDC325306`) only exists on Sepolia — not on a local Anvil chain.
Example test:

```solidity id="u8m3qf"
function testPriceFeedVersionIsAccurate() public {
    uint256 version = fundMe.getVersion();
    assertEq(version, 4);
}
```

---

## Why the Test Fails Locally

The contract uses a hardcoded price feed address:

```solidity id="b2p9kx"
0x694AA1769357215DE4FAC081bf1f309aDC325306
```

This is valid on **Sepolia**, but:

- ❌ Does not exist on local Anvil fork (without state)
- ❌ Causes test failures when run locally

---

## Improving Test Execution

Instead of running all tests repeatedly, use:

```bash id="p3v8qa"
forge test --mt testPriceFeedVersionIsAccurate
```

> `--mt` filters tests by name.

---

## Solution: Forking Tests

Forking allows Foundry to:

- Clone a real blockchain state (e.g., Sepolia)
- Run tests as if interacting with real deployed contracts
- Maintain deterministic local testing

Fork Sepolia so Anvil copies its live state — including the deployed `AggregatorV3` contract.

---

## Setup: Environment Variables

Create a `.env` file:

```bash id="e7r1nx"
# ALCHEMY_ETH_SEPOLIA_RPC_URL=https://eth-sepolia.g.alchemy.com/v2/YOURAPIKEYWILLGOHERE
ALCHEMY_ETH_SEPOLIA_RPC_URL=https://eth-sepolia.g.alchemy.com/v2/kNMFiW9R4tkjKmi5kQu6y
```

Make sure `.env` is in your `.gitignore`.

Load environment variables:

```bash id="m1q7sd"
source .env
```

---

## Running Forking Tests

Execute tests against a forked Sepolia state:

```bash id="c9xwpa"
forge test --mt testPriceFeedVersionIsAccurate --fork-url $ALCHEMY_ETH_SEPOLIA_RPC_URL
```

### Expected Output

```text id="f8m2zd"
[PASS] testPriceFeedVersionIsAccurate()

Suite result: ok. 1 passed; 0 failed
```

---

## Why This Works

When using `--fork-url`:

- Foundry connects to Sepolia via RPC (e.g., Alchemy)
- It copies blockchain state at a specific block
- The Chainlink contract **actually exists at that address**
- The `getVersion()` call returns real on-chain data (4)

---

## Important Note

Forking tests:

- ✔ Very realistic
- ✔ Useful for external dependencies (Chainlink, Uniswap, etc.)
- ❌ Slower than local tests
- ❌ Should not be used for every test run

---

## Code Coverage Analysis

Foundry provides test coverage tools:

```bash id="r4n8yt"
forge coverage --fork-url $SEPOLIA_RPC_URL
```

### Example Output

```text id="t2q6mv"
Ran 3 tests:
[PASS] testMinimumDollarIsFive()
[PASS] testOwnerIsMsgSender()
[PASS] testPriceFeedVersionIsAccurate()
```

### Coverage Report

| File                      | % Lines | % Statements | % Branches | % Funcs |
| ------------------------- | ------- | ------------ | ---------- | ------- |
| script/DeployFundMe.s.sol | 0.00%   | 0.00%        | 100%       | 0.00%   |
| src/FundMe.sol            | 21.43%  | 25.00%       | 0.00%      | 33.33%  |
| src/PriceConverter.sol    | 0.00%   | 0.00%        | 100%       | 0.00%   |
| **Total**                 | 13.04%  | 14.71%       | 0.00%      | 22.22%  |

---

## Key Takeaway

Coverage is still low:

> ~13% total coverage = insufficient for production-grade contracts

Improving coverage is essential for:

- Security
- Audit readiness
- Production reliability

---

## Key Concepts Learned

### Forking Concept

```text id="k8xq2v"
Local Anvil + Forked Sepolia State = Realistic Testing Environment
```

---

### Running Specific Tests

```bash id="u1n9qp"
forge test --mt <testName>
```

---

### Running Fork Tests

```bash id="z6m4qd"
forge test --fork-url $SEPOLIA_RPC_URL
```

---

### Coverage Analysis

```bash id="x7p2ae"
forge coverage --fork-url $SEPOLIA_RPC_URL
```

---

## Summary

Forking tests bridge the gap between local testing and real blockchain behavior.

In this lesson you learned:

- Why local tests fail when interacting with external contracts
- How Chainlink price feeds require real blockchain state
- How to use `forge test --fork-url` to simulate mainnet/testnet
- How to configure `.env` for RPC access
- How to run targeted tests with `--mt`
- How to measure test coverage with `forge coverage`

Forking is a critical tool for building production-grade smart contracts that interact with real-world infrastructure.

# ------------------------------------------------

```

```

# --#############################################

# Refactoring FundMe for Modularity and Better Testing

## Why Refactoring Is Needed

The original `FundMe` implementation uses **hardcoded Chainlink price feed address**:

```solidity id="a8d2kq"
0x694AA1769357215DE4FAC081bf1f309aDC325306
```

This creates major issues:

- ❌ Not portable across chains (Anvil, Sepolia, Mainnet, Arbitrum)
- ❌ Requires manual edits in multiple places
- ❌ High risk of human error in large codebases
- ❌ Poor maintainability

### Goal of Refactoring

Make the contract:

- Modular
- Chain-agnostic
- Easier to test
- Easier to deploy

---

## Key Concept: Refactoring

> Refactoring = changing code structure without changing functionality

## The solution is to **refactor**: move the hardcoded address into the constructor so it's provided once at deployment time. This is a change in structure, not functionality.

# 1. Refactor `FundMe.sol`

## Step 1: Add Storage Variable

```solidity id="v7m2qk"
AggregatorV3Interface private s_priceFeed;
```

---

## Step 2: Inject Dependency via Constructor

```solidity id="k3x9dp"
constructor(address priceFeed) {
    i_owner = msg.sender;
    s_priceFeed = AggregatorV3Interface(priceFeed);
}
```

---

## Step 3: Replace Hardcoded Address in `getVersion`

```solidity id="m9q2we"
function getVersion() public view returns (uint256) {
    AggregatorV3Interface priceFeed =
        AggregatorV3Interface(s_priceFeed);

    return priceFeed.version();
}
```

---

## Step 4: Use Price Feed in Funding Logic

Later used inside:

```solidity id="z8p4la"
fund()
```

via:

```solidity id="t6wq9n"
getConversionRate(msg.value, s_priceFeed);
```

---

# 2. Refactor `PriceConverter.sol`

## Step 1: Remove Hardcoded Address

❌ Remove this:

```solidity id="c1r8xv"
AggregatorV3Interface priceFeed =
    AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
```

---

## Step 2: Make `getPrice` Generic

```solidity id="h4k8sp"
function getPrice(
    AggregatorV3Interface priceFeed
) internal view returns (uint256) {
    // implementation
}
```

---

## Step 3: Update `getConversionRate`

```solidity id="p2v7zn"
function getConversionRate(
    uint256 ethAmount,
    AggregatorV3Interface priceFeed
) internal view returns (uint256) {

    uint256 ethPrice = getPrice(priceFeed);
    uint256 ethAmountInUsd =
        (ethPrice * ethAmount) / 1000000000000000000;

    return ethAmountInUsd;
}
```

---

# 3. Update `FundMe.sol` Usage

Pass the stored price feed:

```solidity id="r7k2ax"
getConversionRate(msg.value, s_priceFeed);
```

---

# 4. Fix Missing Constructor Arguments

After refactoring, multiple places break:

### Problem Areas

- `DeployFundMe.s.sol`
- `FundMe.t.sol`

Both now need a `priceFeed` argument.

---

## Temporary Fix (Hardcoded Address)

```solidity id="u9k3we"
0x694AA1769357215DE4FAC081bf1f309aDC325306
```

---

# 5. Improve Deployment Script

## Updated `DeployFundMe.s.sol`

```solidity id="d8p1qz"
function run() external returns (FundMe) {
    vm.startBroadcast();

    FundMe fundMe =
        new FundMe(0x694AA1769357215DE4FAC081bf1f309aDC325306);

    vm.stopBroadcast();

    return fundMe;
}
```

### Key Improvement

- Deployment now returns the deployed contract instance

---

# 6. Refactor Tests for Consistency

## Step 1: Import Deploy Script

```solidity id="x3n9qp"
import {DeployFundMe} from "../script/DeployFundMe.s.sol";
```

---

## Step 2: Add State Variable

```solidity id="l2m8we"
DeployFundMe deployFundMe;
FundMe fundMe;
```

---

## Step 3: Use Deployment Script in `setUp`

```solidity id="k8q1pa"
function setUp() external {
    deployFundMe = new DeployFundMe();
    fundMe = deployFundMe.run();
}
```

> **Note:** `vm.startBroadcast` uses the address that calls the test contract, or a provided address/private key, as the sender. Read more [here](https://book.getfoundry.sh/cheatcodes/start-broadcast).

---

# 7. Test Failure After Refactor

After refactoring, this test fails:

```solidity id="n4p2xz"
function testOwnerIsMsgSender() public {
    assertEq(fundMe.i_owner(), msg.sender);
}
```

---

## Why It Fails

Because deployment now happens via:

```solidity id="v1x7qa"
deployFundMe.run()
```

And inside scripts:

```solidity id="b6k3zp"
vm.startBroadcast();
```

### Important Rule:

- `vm.startBroadcast()` changes the `msg.sender`
- It becomes either:
  - The broadcaster private key address
  - Or the calling context of the script

So ownership is no longer tied to the test contract.

---

# 8. Fix the Ownership Test

Correct assertion:

```solidity id="t9k1lm"
function testOwnerIsMsgSender() public {
    assertEq(fundMe.i_owner(), msg.sender);
}
```

---

# 9. Verify Everything with Forked Tests

Run:

```bash id="q7v3zn"
forge test --fork-url $SEPOLIA_RPC_URL
```

Expected:

```text id="m2x8qp"
[PASS] all tests
```

---

# Key Takeaways

## 1. Hardcoding Is Bad Design

Avoid:

```solidity id="h1q9we"
address constant = ...
```

Use:

```solidity id="c7v2la"
constructor(address priceFeed)
```

---

## 2. Dependency Injection Pattern

Contracts become:

- Flexible
- Reusable
- Chain-independent

---

## 3. Scripts Must Match Contract Interface

If constructor changes:

```solidity id="z2p8qa"
new FundMe(priceFeed);
```

must be updated everywhere.

---

## 4. Tests Should Mirror Deployment Flow

- Tests now reuse deployment script
- Ensures real-world consistency

---

## 5. `vm.startBroadcast()` Changes Ownership Context

- Script execution ≠ test execution
- `msg.sender` changes depending on broadcast context

---

# Final Summary

This refactor transforms `FundMe` from a rigid, chain-specific contract into a **modular and production-ready system** by:

- Removing hardcoded addresses
- Injecting dependencies via constructor
- Aligning scripts, tests, and deployment logic
- Ensuring compatibility with multiple chains
- Improving maintainability and test reliability

This is a key step toward writing professional-grade smart contracts using Foundry.

# ------------------------------------------------

```

```

# --#############################################

# Deploy a Mock Price Feed - Testing Locally

## Overview

In the previous refactoring, we removed the need to hardcode the Chainlink price feed address throughout the codebase. However, the project still depended on Sepolia for testing.

A better approach is to make the project fully testable on a local blockchain such as Anvil.

To achieve this, we introduce:

- A `HelperConfig` contract
- Chain-specific configurations
- Mock deployments for local testing
- Dynamic network detection using `block.chainid`

This pattern removes hardcoded addresses and enables seamless deployment and testing across multiple networks.

---

# Why Use Mocks?

Testing against live networks has several drawbacks:

- Requires RPC access
- Slower execution
- External dependency failures
- Hardcoded addresses
- Forking requirements

Mock contracts solve these issues by simulating real contract behavior locally.

Benefits:

- Fast local tests
- No RPC dependency
- No blockchain forking required
- Easier refactoring
- Better CI/CD compatibility

---

# Creating HelperConfig

Create a new file:

```text
script/
└── HelperConfig.s.sol
```

Initial structure:

```solidity
// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {Script} from "forge-std/Script.sol";

contract HelperConfig {
    // If we are on a local Anvil, deploy mocks
    // Otherwise use existing network addresses
}
```

---

# Network Configuration Pattern

Instead of storing individual variables for each network, use a struct.

```solidity
struct NetworkConfig {
    address priceFeed;
}
```

### Why use a struct?

Today we only need:

```solidity
address priceFeed;
```

Later we might need:

```solidity
address priceFeed;
address vrfCoordinator;
bytes32 gasLane;
uint64 subscriptionId;
```

Using a struct makes the configuration scalable.

---

# Sepolia Configuration

```solidity
function getSepoliaEthConfig()
    public
    pure
    returns (NetworkConfig memory)
{
    NetworkConfig memory sepoliaConfig = NetworkConfig({
        priceFeed: 0x694AA1769357215DE4FAC081bf1f309aDC325306
    });

    return sepoliaConfig;
}
```

This returns the Chainlink ETH/USD Price Feed address on Sepolia.

---

# Anvil Configuration

Placeholder for local testing:

```solidity
function getAnvilEthConfig()
    public
    pure
    returns (NetworkConfig memory)
{

}
```

Later this function will deploy or return a mock price feed.

---

# Active Network Configuration

Add a state variable:

```solidity
NetworkConfig public activeNetworkConfig;
```

Complete setup:

```solidity
NetworkConfig public activeNetworkConfig;

struct NetworkConfig {
    address priceFeed;
}

constructor() {
    if (block.chainid == 11155111) {
        activeNetworkConfig = getSepoliaEthConfig();
    } else {
        activeNetworkConfig = getAnvilEthConfig();
    }
}
```

---

# Understanding block.chainid

`block.chainid` returns the current blockchain's unique identifier.

Examples:

| Network          | Chain ID |
| ---------------- | -------- |
| Ethereum Mainnet | 1        |
| Sepolia          | 11155111 |
| Polygon          | 137      |
| Arbitrum One     | 42161    |
| Optimism         | 10       |
| Local Anvil      | 31337    |

Useful resources:

- chainlist.org
- Chainlink Price Feed Contract Addresses

---

# Updating DeployFundMe

Import HelperConfig:

```solidity
import {HelperConfig} from "./HelperConfig.s.sol";
```

Inside `run()` add:

```solidity
HelperConfig helperConfig = new HelperConfig();

address ethUsdPriceFeed =
    helperConfig.activeNetworkConfig();
```

Full flow:

```solidity
function run() external {

    HelperConfig helperConfig = new HelperConfig();

    address ethUsdPriceFeed =
        helperConfig.activeNetworkConfig();

    vm.startBroadcast();

    // Deploy contracts here

    vm.stopBroadcast();
}
```

---

# Important Deployment Detail

The HelperConfig contract is instantiated **before**:

```solidity
vm.startBroadcast();
```

This means:

```solidity
HelperConfig helperConfig = new HelperConfig();
```

is not actually deployed on-chain.

Only transactions executed between:

```solidity
vm.startBroadcast();
```

and

```solidity
vm.stopBroadcast();
```

become real blockchain transactions.

This keeps deployment scripts lightweight and efficient.

---

# Running Tests

Verify everything still works:

```bash
forge test --fork-url $SEPOLIA_RPC_URL
```

Expected result:

```text
All tests passing
```

---

# Supporting Additional Chains

Adding another blockchain is straightforward.

Copy:

```solidity
function getSepoliaEthConfig()
```

Create a new version:

```solidity
function getPolygonConfig()
```

or

```solidity
function getArbitrumConfig()
```

Example:

```solidity
function getArbitrumConfig()
    public
    pure
    returns (NetworkConfig memory)
{
    NetworkConfig memory config = NetworkConfig({
        priceFeed: ARBITRUM_PRICE_FEED_ADDRESS
    });

    return config;
}
```

Then update the constructor:

```solidity
constructor() {
    if (block.chainid == 11155111) {
        activeNetworkConfig = getSepoliaEthConfig();
    } else if (block.chainid == 42161) {
        activeNetworkConfig = getArbitrumConfig();
    } else {
        activeNetworkConfig = getAnvilEthConfig();
    }
}
```

---

# Benefits of the HelperConfig Pattern

Before:

```solidity
address constant PRICE_FEED =
    0x694AA1769357215DE4FAC081bf1f309aDC325306;
```

Problems:

- Hardcoded addresses
- Difficult migrations
- Poor portability
- Test complexity

After:

```solidity
activeNetworkConfig.priceFeed
```

Benefits:

- Multi-chain deployments
- Cleaner code
- Easier testing
- Easier maintenance
- Better scalability

---

# Mainnet Price Feed Version Change

Chainlink upgraded the Mainnet ETH/USD price feed.

Tests that assume a fixed version may fail.

Update your test:

```solidity
function testPriceFeedVersionIsAccurate() public {
    if (block.chainid == 11155111) {
        uint256 version = fundMe.getVersion();
        assertEq(version, 4);
    } else if (block.chainid == 1) {
        uint256 version = fundMe.getVersion();
        assertEq(version, 6);
    }
}
```

Expected versions:

| Network | Version |
| ------- | ------- |
| Sepolia | 4       |
| Mainnet | 6       |

---

# Key Concepts Learned

## Mock Contracts

Contracts that simulate external dependencies for testing.

---

## HelperConfig Pattern

Centralizes chain-specific configuration.

---

## block.chainid

Allows runtime detection of the current blockchain.

---

## Multi-Chain Deployments

Same codebase can deploy across:

- Ethereum
- Sepolia
- Polygon
- Arbitrum
- Optimism
- Local Anvil

---

## Configuration Management

Store network-specific settings in structs instead of hardcoded constants.

---

# Quick Reference

### Create HelperConfig

```solidity
contract HelperConfig {
    NetworkConfig public activeNetworkConfig;
}
```

### Select Network

```solidity
if (block.chainid == 11155111)
```

### Access Price Feed

```solidity
activeNetworkConfig.priceFeed
```

### Run Tests

```bash
forge test --fork-url $SEPOLIA_RPC_URL
```

---

# Takeaway

The HelperConfig pattern is a foundational Solidity development technique that eliminates hardcoded addresses and enables truly portable deployments.

By combining:

- `block.chainid`
- network-specific configs
- mocks
- deployment scripts

you can run the same codebase across local, testnet, and mainnet environments with minimal changes, greatly improving maintainability and testing reliability.

# ------------------------------------------------

```

```

# --#############################################

# Refactoring the Mock Smart Contract - Solving the Anvil Problem

## Overview

When deploying to Sepolia, we can directly use a real Chainlink price feed address.

On Anvil, the Chainlink `AggregatorV3` contract doesn't exist. The solution is to deploy a **mock contract** — a simplified contract that simulates the behavior of the real one — and point `HelperConfig` to it.

This allows:

- Fully local testing
- No dependency on testnets
- Deterministic behavior
- Faster development cycles

---

# What is a Mock Contract?

A **mock contract** is a simplified version of a real contract used for testing purposes.

It:

- Simulates external dependencies
- Returns predictable values
- Replaces live blockchain services locally

In this case, we mock:

```text
Chainlink AggregatorV3Interface (Price Feed)
```

---

# Project Structure Update

Create the mock contract:

```bash id="q9d2xa"
mkdir test/mocks
touch test/mocks/MockV3Aggregator.sol
```

Create `test/mocks/MockV3Aggregator.sol` and copy the contents from the [Cyfrin repository](https://github.com/Cyfrin/foundry-fund-me-f23/blob/main/test/mock/MockV3Aggregator.sol).

---

# MockV3Aggregator Contract

Copy the full Chainlink mock implementation into:

```text id="m0v8pq"
test/mocks/MockV3Aggregator.sol
```

This contract simulates:

- ETH/USD price feed
- Decimals
- Latest round data

---

# Update HelperConfig

## 1. Import Required Dependencies

```solidity id="a71kq2"
import {Script} from "forge-std/Script.sol";
import {MockV3Aggregator} from "../test/mocks/MockV3Aggregator.sol";

contract HelperConfig is Script {
```

---

## 2. Inherit from Script

This gives access to:

- `vm.startBroadcast()`
- `vm.stopBroadcast()`

```solidity id="c8m2xz"
contract HelperConfig is Script {
}
```

---

## 3. Add Mock State Variable

```solidity id="z91p0v"
MockV3Aggregator mockPriceFeed;
```

---

# 4. Implement getAnvilEthConfig

This function deploys a mock price feed locally and returns its address.

```solidity id="v3n8qs"
function getAnvilEthConfig()
    public
    returns (NetworkConfig memory)
{
    vm.startBroadcast();

    mockPriceFeed = new MockV3Aggregator(
        8,        // decimals
        2000e8    // initial ETH/USD price
    );

    vm.stopBroadcast();

    NetworkConfig memory anvilConfig = NetworkConfig({
        priceFeed: address(mockPriceFeed)
    });

    return anvilConfig;
}
```

`MockV3Aggregator` takes two constructor arguments:

- `8` — decimals (matching Chainlink's ETH/USD feed)
- `2000e8` — initial price ($2000 with 8 decimal places)

---

# 5. How It Works

When running on Anvil:

```solidity id="k3p8lm"
if (block.chainid != 11155111) {
    activeNetworkConfig = getAnvilEthConfig();
}
```

Flow:

1. Detect local chain (Anvil)
2. Deploy MockV3Aggregator
3. Capture deployed address
4. Return it as priceFeed
5. Use it in FundMe contract

forge test (no --fork-url)
└── setUp() calls DeployFundMe.run()
└── HelperConfig constructor checks block.chainid
└── chainid == 31337 (Anvil) → getAnvilEthConfig()
└── Deploys MockV3Aggregator → returns its address
└── FundMe deployed with mock address ✅

---

# 6. Why vm.startBroadcast is Needed

Mock deployment must simulate real transactions.

```solidity id="h1q9we"
vm.startBroadcast();
```

This ensures:

- The mock contract is actually deployed
- It behaves like a real blockchain deployment
- The address is valid for subsequent calls

---

# 7. Final HelperConfig Flow

```solidity id="f7k2as"
constructor() {
    if (block.chainid == 11155111) {
        activeNetworkConfig = getSepoliaEthConfig();
    } else {
        activeNetworkConfig = getAnvilEthConfig();
    }
}
```

---

# 8. Resulting Behavior

| Network | Behavior                       |
| ------- | ------------------------------ |
| Sepolia | Uses real Chainlink price feed |
| Anvil   | Deploys MockV3Aggregator       |

---

# 9. Mock Configuration Values

```solidity id="p2m8nx"
new MockV3Aggregator(8, 2000e8);
```

| Parameter | Meaning              |
| --------- | -------------------- |
| 8         | Decimals             |
| 2000e8    | ETH/USD price = 2000 |

---

# 10. Key Benefits

## Before

- External dependency required
- No local testing
- Hardcoded addresses
- Network coupling

## After

- Fully local testing
- No external APIs needed
- Deterministic price feed
- Easy CI integration

---

# 11. Architecture Pattern

This introduces a standard Solidity testing pattern:

### HelperConfig + Mocks

- HelperConfig → selects network config
- MockV3Aggregator → simulates external oracle
- block.chainid → runtime switching

---

# 12. Testing Flow

### Local (Anvil)

```bash id="t8q3mn"
forge test
```

Steps:

1. Detect Anvil chain
2. Deploy mock
3. Use mock price feed
4. Run tests locally

---

### Testnet (Sepolia)

```bash id="r5v9kd"
forge test --fork-url $SEPOLIA_RPC_URL
```

Steps:

1. Detect Sepolia
2. Use real Chainlink feed
3. Run tests against forked chain

---

# 13. Key Concepts Learned

## Mock Contract

Simulates external dependencies for controlled testing.

---

## HelperConfig Extension

Now includes deployment logic, not just configuration.

---

## Local Blockchain Testing

Anvil enables full blockchain simulation without external dependencies.

---

## Dynamic Deployment Logic

Contracts can adapt based on:

```solidity id="c9p1zl"
block.chainid
```

---

# 14. Summary

By introducing mock contracts into HelperConfig:

- We eliminated dependency on real networks for testing
- We enabled deterministic local development
- We improved reliability of tests
- We established a scalable multi-chain testing architecture

This pattern is essential for professional Solidity development workflows.

# ------------------------------------------------

```

```

# --#############################################

# Refactoring Magic Numbers

## What are Magic Numbers?

Magic numbers are literal values hardcoded directly in the code without explanation. They cause:

- **Reduced readability** — readers don't know what the number means
- **Maintenance difficulty** — if the value appears in 10 places, you must update all 10
- **Debugging challenges** — easy to miss one instance and introduce subtle bugs

---

## The Fix: Named Constants

Open `HelperConfig.s.sol` and replace the magic numbers in `getAnvilEthConfig()` with named constants at the top of the contract:

```solidity
uint8 public constant DECIMALS = 8;
int256 public constant INITIAL_PRICE = 2000e8;
```

> **Convention:** constants are always declared in `ALL_CAPS`.

Then update `getAnvilEthConfig()` to use them:

```solidity
function getAnvilEthConfig() public returns (NetworkConfig memory) {
    vm.startBroadcast();
    mockPriceFeed = new MockV3Aggregator(DECIMALS, INITIAL_PRICE);
    vm.stopBroadcast();

    NetworkConfig memory anvilConfig = NetworkConfig({
        priceFeed: address(mockPriceFeed)
    });
    return anvilConfig;
}
```

Now the intent of each value is self-documenting, and any future change only needs to happen in one place.

# Benefits of Refactoring Magic Numbers

| Before                | After            |
| --------------------- | ---------------- |
| Hardcoded values      | Named constants  |
| Difficult maintenance | Easy updates     |
| Less readable         | Self-documenting |
| Error-prone           | Safer            |
| Harder audits         | Easier audits    |

# ------------------------------------------------

```

```

# --#############################################

# Refactoring the Mock — Idempotent Deployment

## The Problem

Every time `getAnvilEthConfig()` is called it deploys a new `MockV3Aggregator`, even if one already exists. This wastes gas and can cause inconsistencies across tests.

---

## The Fix: Check Before Deploying

Unassigned `address` state variables default to `address(0)`. Use this to skip deployment if a mock is already deployed:

```solidity
function getOrCreateAnvilEthConfig() public returns (NetworkConfig memory) {
    // If priceFeed is already set, return the existing config
    if (activeNetworkConfig.priceFeed != address(0)) {
        return activeNetworkConfig;
    }

    vm.startBroadcast();
    mockPriceFeed = new MockV3Aggregator(DECIMALS, INITIAL_PRICE);
    vm.stopBroadcast();

    NetworkConfig memory anvilConfig = NetworkConfig({
        priceFeed: address(mockPriceFeed)
    });
    return anvilConfig;
}
```

Also update the constructor to call the renamed function:

```solidity
constructor() {
    if (block.chainid == 11155111) {
        activeNetworkConfig = getSepoliaEthConfig();
    } else {
        activeNetworkConfig = getOrCreateAnvilEthConfig();
    }
}
```

---

## The Rename

`getAnvilEthConfig` → `getOrCreateAnvilEthConfig` better describes what the function actually does: it either retrieves the existing config or creates a new mock if none exists yet.

---

## Result: Network-Agnostic Tests

```bash
forge test                            # runs on Anvil with mock ✅
forge test --fork-url $SEPOLIA_RPC_URL  # runs on Sepolia fork ✅
```

Both pass — no hardcoded addresses, no forced forking required.

# ------------------------------------------------

```

```

# --#############################################

# Foundry Cheatcodes - Improving Test Coverage

## Overview

Cheatcodes are Foundry's superpower for testing — they let you alter EVM state, mock callers, set balances, and assert reverts. Read more in the [Foundry Book on cheatcodes](https://book.getfoundry.sh/forge/cheatcodes).

After refactoring deployment scripts and making tests network-agnostic, the next goal is to improve test coverage.

Check your current coverage:

```bash
forge coverage
```

Low coverage (e.g. 10–15%) means many contract behaviors remain untested.

The `FundMe` contract's `fund()` function contains critical logic that should be verified through unit tests.

This lesson introduces some of Foundry's most important testing tools:

- `vm.expectRevert()`
- `vm.prank()`
- `vm.startPrank()`
- `vm.stopPrank()`
- `makeAddr()`
- `vm.deal()`

These are called **Cheatcodes**.

---

# What Are Foundry Cheatcodes?

According to the Foundry Book:

> "Cheatcodes give you powerful assertions, the ability to alter the state of the EVM, mock data, and more."

Cheatcodes allow you to:

- Simulate users
- Assign balances
- Expect failures
- Modify blockchain state
- Test edge cases

They are essential for professional Solidity testing.

---

# Testing the fund() Function

The `fund()` function should:

### 1. Reject insufficient ETH

```solidity
require(
    msg.value.getConversionRate(s_priceFeed) >= MINIMUM_USD
);
```

If insufficient ETH is sent:

```text
Transaction should revert
```

---

### 2. Update funded amount

```solidity
s_addressToAmountFunded[msg.sender] += msg.value;
```

---

### 3. Add sender to funders array

```solidity
s_funders.push(msg.sender);
```

---

# Cheatcode: expectRevert()

Used to verify that a transaction fails.

Example:

```solidity
function testFundFailsWithoutEnoughETH() public {
    vm.expectRevert(); // Fund reverts without enough ETH
    fundMe.fund();
}
```

Explanation:

```solidity
vm.expectRevert();
```

or

```solidity
vm.expectRevert(bytes("didn't send enough eht"));
```

tells Foundry:

> "The next transaction must revert."

If it doesn't revert:

```text
Test fails
```

If it reverts:

```text
Test passes
```

---

# User Simulation in Tests

Real smart contracts interact with multiple users:

- Owner
- Admin
- Minter
- Investor
- End User

Testing requires simulating different callers.

Foundry provides cheatcodes for this.

---

# Cheatcode: makeAddr()

Creates a deterministic test address.

```solidity
address alice = makeAddr("alice");
```

Now we have:

```text
alice
```

as a reusable test user.

---

# Cheatcode: prank() - Fund updates the data structures

Temporarily changes `msg.sender`.

```solidity
vm.prank(alice);
```

The next transaction executes as:

```solidity
alice
```

Example:

```solidity
uint256 constant SEND_VALUE = 0.1 ether;
function testFundUpdatesFundDataStructure() public {
    vm.prank(alice);                        // alice is msg.sender for the next call
    fundMe.fund{value: SEND_VALUE}();
    uint256 amountFunded = fundMe.getAddressToAmountFunded(alice);
    assertEq(amountFunded, SEND_VALUE);
}
```

Equivalent to:

```text
alice sends ETH
```

---

# Cheatcodes: startPrank() / stopPrank()

Apply a sender across multiple calls.

```solidity
vm.startPrank(alice);

// multiple calls

vm.stopPrank();
```

Everything between:

```solidity
startPrank()
```

and

```solidity
stopPrank()
```

uses the specified sender.

Similar to:

```solidity
vm.startBroadcast()
vm.stopBroadcast()
```

used in deployment scripts.

---

# Updated Test

```solidity
function testFundUpdatesFundDataStructure() public {
    vm.prank(alice);

    fundMe.fund{value: SEND_VALUE}();

    uint256 amountFunded =
        fundMe.getAddressToAmountFunded(alice);

    assertEq(amountFunded, SEND_VALUE);
}
```

---

# Why It Still Fails

Running:

```bash
forge test --mt testFundUpdatesFundDataStructure -vvv
```

produces:

```text
EvmError: OutOfFunds
```

Trace:

```text
FundMe::fund{value: 100000000000000000}()
└─ ← [OutOfFunds]
```

Problem:

```text
alice has zero ETH
```

A user cannot fund a contract without a balance.

---

# Cheatcode: deal()

Assigns ETH to an address.

Example:

```solidity
vm.deal(alice, STARTING_BALANCE);
```

---

# Create Starting Balance Constant

```solidity
uint256 constant STARTING_BALANCE = 10 ether;
```

---

# Setup Function

```solidity
function setUp() external {
    vm.deal(alice, STARTING_BALANCE);
}
```

Now:

```text
alice owns 10 ETH
```

during tests.

---

# Final Working Test

```solidity
function testFundUpdatesFundDataStructure() public {
    vm.prank(alice);

    fundMe.fund{value: SEND_VALUE}();

    uint256 amountFunded =
        fundMe.getAddressToAmountFunded(alice);

    assertEq(amountFunded, SEND_VALUE);
}
```

This test now passes.

---

# Common Testing Workflow

A very common pattern in Solidity testing:

```solidity
address alice = makeAddr("alice");

vm.deal(alice, 10 ether);

vm.prank(alice);

contract.call();
```

Steps:

1. Create user
2. Fund user
3. Impersonate user
4. Execute transaction
5. Verify state

You will use this pattern constantly.

---

# Most Important Cheatcodes

## expectRevert

Expect next transaction to fail.

```solidity
vm.expectRevert();
```

---

## prank

Change sender for next call.

```solidity
vm.prank(alice);
```

---

## startPrank

Change sender for multiple calls.

```solidity
vm.startPrank(alice);
```

---

## stopPrank

End sender impersonation.

```solidity
vm.stopPrank();
```

---

## makeAddr

Create test addresses.

```solidity
address alice = makeAddr("alice");
```

---

## deal

Assign ETH balance.

```solidity
vm.deal(alice, 10 ether);
```

---

# Useful Commands

Run all tests:

```bash
forge test
```

Run a specific test:

```bash
forge test --mt testFundUpdatesFundDataStructure
```

Verbose traces:

```bash
forge test --mt testFundUpdatesFundDataStructure -vvv
```

Coverage report:

```bash
forge coverage
```

---

# Key Concepts Learned

## Cheatcodes

Powerful Foundry testing utilities that manipulate EVM state.

---

## User Simulation

Testing should represent real users interacting with contracts.

---

## Balance Management

Users must possess ETH before sending transactions.

---

## State Verification

Tests should verify:

- Reverts
- Storage updates
- Array updates
- Balance changes

---

## Test Readability

Use constants instead of magic numbers:

```solidity
SEND_VALUE
STARTING_BALANCE
```

---

# Takeaway

Foundry Cheatcodes are one of the framework's most powerful features. By combining:

- `makeAddr()`
- `deal()`
- `prank()`
- `expectRevert()`

you can accurately simulate real-world user interactions, test failure scenarios, verify state changes, and dramatically increase your smart contract test coverage.

These cheatcodes form the foundation of nearly every professional Solidity testing suite.

# ------------------------------------------------

```

```

# --#############################################

# ------------------------------------------------

```

```

# --#############################################

# ------------------------------------------------

```

```

# --#############################################

# ------------------------------------------------

```

```

# --#############################################

# ------------------------------------------------

```

```

# --#############################################

# ------------------------------------------------

```

```

# --#############################################
