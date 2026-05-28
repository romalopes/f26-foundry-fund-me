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

Run a single test by name to save time:

```bash
forge test --mt testPriceFeedVersionIsAccurate
```

---

## The Fix: Fork Testing

Fork Sepolia so Anvil copies its live state — including the deployed `AggregatorV3` contract.

### 1. Add to `.env`

```bash
SEPOLIA_RPC_URL=https://eth-sepolia.g.alchemy.com/v2/YOUR_API_KEY
```

Make sure `.env` is in your `.gitignore`.

### 2. Load the variable

```bash
source .env
```

### 3. Run the test with `--fork-url`

```bash
forge test --mt testPriceFeedVersionIsAccurate --fork-url $SEPOLIA_RPC_URL
```

Output:

```
[PASS] testPriceFeedVersionIsAccurate() (gas: 14118)
Suite result: ok. 1 passed; 0 failed; 0 skipped
```

> **Note:** Forking makes API calls to Alchemy on every run — avoid running your entire test suite on a fork unless necessary.

---

## Checking Coverage

Use `forge coverage` to see which parts of your code are covered by tests:

```bash
forge coverage --fork-url $SEPOLIA_RPC_URL
```

Example output:

```
| File                      | % Lines       | % Statements  | % Branches  | % Funcs      |
| ------------------------- | ------------- | ------------- | ----------- | ------------ |
| script/DeployFundMe.s.sol | 0.00% (0/3)   | 0.00% (0/3)   | 100% (0/0)  | 0.00% (0/1)  |
| src/FundMe.sol            | 21.43% (3/14) | 25.00% (5/20) | 0.00% (0/6) | 33.33% (2/6) |
| src/PriceConverter.sol    | 0.00% (0/6)   | 0.00% (0/11)  | 100% (0/0)  | 0.00% (0/2)  |
| Total                     | 13.04% (3/23) | 14.71% (5/34) | 0.00% (0/6) | 22.22% (2/9) |
```

13% total coverage is far too low — the goal in upcoming lessons is to dramatically increase this. See the [forge coverage docs](https://book.getfoundry.sh/reference/forge/forge-coverage) for all options.

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

# ------------------------------------------------

```

```

# --#############################################
