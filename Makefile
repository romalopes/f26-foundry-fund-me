include .env

PRIVATE_KEY ?= BRAVE_METAMASK_PRIVATE_KEY_1

build:
	forge build

test:
	forge test -vvv



# GENERAL
deploy-general:
	forge script script/DeploySimpleStorage.s.sol \
		--rpc-url $($(NETWORK)_RPC_URL) \
		--private-key $($(PRIVATE_KEY)) \
		--broadcast
send-general:
	cast send $($(NETWORK)_SIMPLE_STORAGE_CONTRACT_ADDRESS) \
    	"store(uint256)" \
    	$(VALUE) \
    --rpc-url $($(NETWORK)_RPC_URL) \
    --private-key $($(PRIVATE_KEY))
read-general:
	cast call $($(NETWORK)_SIMPLE_STORAGE_CONTRACT_ADDRESS) "retrieve()" \
	--rpc-url $($(NETWORK)_RPC_URL) \
	--private-key $($(PRIVATE_KEY))
verify-general:
	forge verify-contract \
		$($(NETWORK)_SIMPLE_STORAGE_CONTRACT_ADDRESS) \
		SimpleStorage.sol



# ANVIL
deploy-anvil:
	forge script script/DeploySimpleStorage.s.sol \
		--rpc-url ${ANVIL_RPC_URL} \
		--private-key ${ANVIL_PRIVATE_KEY_1} \
		--broadcast
send-anvil:
	cast send $(ANVIL_SIMPLE_STORAGE_CONTRACT_ADDRESS) \
    	"store(uint256)" \
    	$(VALUE) \
    --rpc-url ${ANVIL_RPC_URL} \
    --private-key ${ANVIL_PRIVATE_KEY_1}
read-anvil:
	cast call $(ANVIL_SIMPLE_STORAGE_CONTRACT_ADDRESS) "retrieve()" \
	--rpc-url ${ANVIL_RPC_URL} \
	--private-key ${ANVIL_PRIVATE_KEY_1}
verify-anvil:
	forge verify-contract \
		$(ANVIL_SIMPLE_STORAGE_CONTRACT_ADDRESS) \
		SimpleStorage.sol

# ANVIL ZKSYNC
deploy-anvil-zksync:
	forge script script/DeploySimpleStorage.s.sol \
		--zksync \
		--rpc-url ${ANVIL_ZKSYNC_RPC_URL} \
		--private-key ${ANVIL_ZKSYNC_PRIVATE_KEY_1} \
		--broadcast
send-anvil-zksync:
	cast send $(ANVIL_ZKSYNC_SIMPLE_STORAGE_CONTRACT_ADDRESS) \
		--zksync \
    	"store(uint256)" \
    	$(VALUE) \
    --rpc-url ${ANVIL_ZKSYNC_RPC_URL} \
    --private-key ${ANVIL_ZKSYNC_PRIVATE_KEY_1}
read-anvil-zksync:
	cast call $(ANVIL_ZKSYNC_SIMPLE_STORAGE_CONTRACT_ADDRESS) "retrieve()" \
	--zksync \
	--rpc-url ${ANVIL_ZKSYNC_RPC_URL} \
	--private-key ${ANVIL_ZKSYNC_PRIVATE_KEY_1}
verify-anvil-zksync:
	forge verify-contract \
		$(ANVIL_ZKSYNC_SIMPLE_STORAGE_CONTRACT_ADDRESS) \
		SimpleStorage.sol


	# ALCHEMY SEPOLIA
deploy-alchemy-eth-sepolia:
	forge script script/DeploySimpleStorage.s.sol \
		--rpc-url ${ALCHEMY_ETH_SEPOLIA_RPC_URL} \
		--private-key ${BRAVE_METAMASK_PRIVATE_KEY_1} \
		--broadcast
verify-alchemy-eth-sepolia:
	forge verify-contract \
		$(ALCHEMY_ETH_SEPOLIA_SIMPLE_STORAGE_CONTRACT_ADDRESS) \
		src/DeploySimpleStorage.s.sol \
		$(ETHERSCAN_API_KEY)

verify-2-alchemy-eth-sepolia:
	forge create SimpleStorage \
	--rpc-url ${ALCHEMY_ETH_SEPOLIA_RPC_URL} \
	--private-key ${BRAVE_METAMASK_PRIVATE_KEY_1} \
	--optimize \
	--optimizer-runs 2000 \
	--out ./build \
  	--verifier etherscan

send-alchemy-eth-sepolia:
	cast send $(ALCHEMY_ETH_SEPOLIA_SIMPLE_STORAGE_CONTRACT_ADDRESS) \
    	"store(uint256)" \
    	9999 \
    --rpc-url ${ALCHEMY_ETH_SEPOLIA_RPC_URL} \
    --private-key ${BRAVE_METAMASK_PRIVATE_KEY_1}
read-alchemy-eth-sepolia:
	cast call $(ALCHEMY_ETH_SEPOLIA_SIMPLE_STORAGE_CONTRACT_ADDRESS) "retrieve()" \
	--rpc-url ${ALCHEMY_ETH_SEPOLIA_RPC_URL} \


# INFURA SEPOLIA
deploy-infura-eth-sepolia:
	forge script script/DeploySimpleStorage.s.sol \
		--rpc-url ${INFURA_ETH_SEPOLIA_RPC_URL} \
		--private-key ${BRAVE_METAMASK_PRIVATE_KEY_1} \
		--broadcast
send-infura-eth-sepolia:
	cast send $(INFURA_ETH_SEPOLIA_SIMPLE_STORAGE_CONTRACT_ADDRESS) \
    	"store(uint256)" \
    	2222 \
    --rpc-url ${INFURA_ETH_SEPOLIA_RPC_URL} \
    --private-key ${BRAVE_METAMASK_PRIVATE_KEY_1}
read-infura-eth-sepolia:
	cast call $(INFURA_ETH_SEPOLIA_SIMPLE_STORAGE_CONTRACT_ADDRESS) "retrieve()" \
	--rpc-url ${INFURA_ETH_SEPOLIA_RPC_URL} \
	--private-key ${BRAVE_METAMASK_PRIVATE_KEY_1}
verify-infura-eth-sepolia:
	forge verify-contract \
		$(INFURA_ETH_SEPOLIA_SIMPLE_STORAGE_CONTRACT_ADDRESS) \
		SimpleStorage.sol

# TENDERLY SEPOLIA
deploy-tenderly-eth-sepolia:
	forge script script/DeploySimpleStorage.s.sol \
		--rpc-url ${TENDERLY_ETH_SEPOLIA_RPC_URL} \
		--private-key ${BRAVE_METAMASK_PRIVATE_KEY_1} \
		--broadcast
deploy-tenderly-eth-sepolia-verify:
	forge script script/Counter.s.sol:CounterScript \
	--rpc-url ${TENDERLY_ETH_SEPOLIA_RPC_URL} \
	--private-key ${BRAVE_METAMASK_PRIVATE_KEY_1}  \
	--broadcast \
	--verify \
	--verifier custom \
	--verifier-url ${TENDERLY_ETH_SEPOLIA_VERIFIER_URL} \
	--slow

send-tenderly-eth-sepolia:
	cast send $(TENDERLY_ETH_SEPOLIA_SIMPLE_STORAGE_CONTRACT_ADDRESS) \
    	"store(uint256)" \
    	3333 \
    --rpc-url ${TENDERLY_ETH_SEPOLIA_RPC_URL} \
    --private-key ${BRAVE_METAMASK_PRIVATE_KEY_1}
read-tenderly-eth-sepolia:
	cast call $(TENDERLY_ETH_SEPOLIA_SIMPLE_STORAGE_CONTRACT_ADDRESS) "retrieve()" \
	--rpc-url ${TENDERLY_ETH_SEPOLIA_RPC_URL} \
	--private-key ${BRAVE_METAMASK_PRIVATE_KEY_1}
verify-tenderly-eth-sepolia:
	forge verify-contract \
		$(TENDERLY_ETH_SEPOLIA_SIMPLE_STORAGE_CONTRACT_ADDRESS) \
		SimpleStorage.sol

# CHAINSTACK SEPOLIA
deploy-chainstack-sepolia:
	forge script script/DeploySimpleStorage.s.sol \
		--rpc-url ${CHAINSTACK_SEPOLIA_RPC_URL} \
		--private-key ${BRAVE_METAMASK_PRIVATE_KEY_1} \
		--broadcast
send-chainstack-sepolia:
	cast send $(CHAINSTACK_SIMPLE_STORAGE_CONTRACT_ADDRESS) \
		"store(uint256)" \
		4444 \
	--rpc-url ${CHAINSTACK_SEPOLIA_RPC_URL} \
	--private-key ${BRAVE_METAMASK_PRIVATE_KEY_1}
read-chainstack-sepolia:
	cast call $(CHAINSTACK_SIMPLE_STORAGE_CONTRACT_ADDRESS) "retrieve()" \
	--rpc-url ${CHAINSTACK_SEPOLIA_RPC_URL} \
	--private-key ${BRAVE_METAMASK_PRIVATE_KEY_1}
verify-chainstack-sepolia:
	forge verify-contract \
		$(CHAINSTACK_SIMPLE_STORAGE_CONTRACT_ADDRESS) \
		SimpleStorage.sol

# NODIES SEPOLIA
deploy-nodies-sepolia:
	forge script script/DeploySimpleStorage.s.sol \
		--rpc-url ${NODIES_SEPOLIA_RPC_URL} \
		--private-key ${BRAVE_METAMASK_PRIVATE_KEY_1} \
		--broadcast
send-nodies-sepolia:
	cast send $(NODIES_SIMPLE_STORAGE_CONTRACT_ADDRESS) \
		"store(uint256)" \
		5555 \
	--rpc-url ${NODIES_SEPOLIA_RPC_URL} \
	--private-key ${BRAVE_METAMASK_PRIVATE_KEY_1}
read-nodies-sepolia:
	cast call $(NODIES_SIMPLE_STORAGE_CONTRACT_ADDRESS) "retrieve()" \
	--rpc-url ${NODIES_SEPOLIA_RPC_URL} \
	--private-key ${BRAVE_METAMASK_PRIVATE_KEY_1}
verify-nodies-sepolia:
	forge verify-contract \
		$(NODIES_SIMPLE_STORAGE_CONTRACT_ADDRESS) \
		SimpleStorage.sol

# POLYGON AMOY ALCHEMY
deploy-polygon-amoy-alchemy:
	forge script script/DeploySimpleStorage.s.sol \
		--rpc-url ${POLYGON_AMOY_ALCHEMY_RPC_URL} \
		--private-key ${BRAVE_METAMASK_PRIVATE_KEY_1} \
		--broadcast
send-polygon-amoy-alchemy:
	cast send $(POLYGON_AMOY_ALCHEMY_SIMPLE_STORAGE_CONTRACT_ADDRESS) \
		"store(uint256)" \
		666 \
	--rpc-url ${POLYGON_AMOY_ALCHEMY_RPC_URL} \
	--private-key ${BRAVE_METAMASK_PRIVATE_KEY_1}
read-polygon-amoy-alchemy:
	cast call $(POLYGON_AMOY_ALCHEMY_SIMPLE_STORAGE_CONTRACT_ADDRESS) "retrieve()" \
	--rpc-url ${POLYGON_AMOY_ALCHEMY_RPC_URL} \
	--private-key ${BRAVE_METAMASK_PRIVATE_KEY_1}
verify-polygon-amoy-alchemy:
	forge verify-contract \
		$(POLYGON_AMOY_ALCHEMY_SIMPLE_STORAGE_CONTRACT_ADDRESS) \
		SimpleStorage.sol

# ZKSYNC SEPOLIA ALCHEMY
deploy-zksync-sepolia-alchemy:
	forge script script/DeploySimpleStorage.s.sol \
		--rpc-url ${ZKSYNC_ALCHEMY_SEPOLIA_RPC_URL} \
		--private-key ${BRAVE_METAMASK_PRIVATE_KEY_1} \
		--broadcast

send-zksync-sepolia-alchemy:
	cast send $(ZKSYNC_ALCHEMY_SEPOLIA_SIMPLE_STORAGE_CONTRACT_ADDRESS) \
		"store(uint256)" \
		666 \
	--rpc-url ${ZKSYNC_ALCHEMY_SEPOLIA_RPC_URL} \
	--private-key ${BRAVE_METAMASK_PRIVATE_KEY_1}
read-zksync-sepolia-alchemy:
	cast call $(ZKSYNC_ALCHEMY_SEPOLIA_SIMPLE_STORAGE_CONTRACT_ADDRESS) "retrieve()" \
	--rpc-url ${ZKSYNC_ALCHEMY_SEPOLIA_RPC_URL} \
	--private-key ${BRAVE_METAMASK_PRIVATE_KEY_1}
verify-zksync-sepolia-alchemy:
	forge verify-contract \
		$(ZKSYNC_ALCHEMY_SEPOLIA_SIMPLE_STORAGE_CONTRACT_ADDRESS) \
		--zksync \
		--legacy \
		SimpleStorage.sol

# OPTIMISM SEPOLIA ALCHEMY
deploy-optimism-sepolia-alchemy:
	forge script script/DeploySimpleStorage.s.sol \
		--rpc-url ${OPTIMISM_ALCHEMY_SEPOLIA_RPC_URL} \
		--private-key ${BRAVE_METAMASK_PRIVATE_KEY_1} \
		--broadcast
send-optimism-sepolia-alchemy:
	cast send $(OPTIMISM_ALCHEMY_SEPOLIA_SIMPLE_STORAGE_CONTRACT_ADDRESS) \
		"store(uint256)" \
		666 \
	--rpc-url ${OPTIMISM_ALCHEMY_SEPOLIA_RPC_URL} \
	--private-key ${BRAVE_METAMASK_PRIVATE_KEY_1}
read-optimism-sepolia-alchemy:
	cast call $(OPTIMISM_ALCHEMY_SEPOLIA_SIMPLE_STORAGE_CONTRACT_ADDRESS) "retrieve()" \
	--rpc-url ${OPTIMISM_ALCHEMY_SEPOLIA_RPC_URL} \
	--private-key ${BRAVE_METAMASK_PRIVATE_KEY_1}
verify-optimism-sepolia-alchemy:
	forge verify-contract \
		$(OPTIMISM_ALCHEMY_SEPOLIA_SIMPLE_STORAGE_CONTRACT_ADDRESS) \
		SimpleStorage.sol

# ARBITRUM SEPOLIA ALCHEMY
deploy-arbitrum-sepolia-alchemy:
	forge script script/DeploySimpleStorage.s.sol \
		--rpc-url ${ARBITRUM_ALCHEMY_SEPOLIA_RPC_URL} \
		--private-key ${BRAVE_METAMASK_PRIVATE_KEY_1} \
		--broadcast
send-arbitrum-sepolia-alchemy:
	cast send $(ARBITRUM_ALCHEMY_SEPOLIA_SIMPLE_STORAGE_CONTRACT_ADDRESS) \
		"store(uint256)" \
		777 \
	--rpc-url ${ARBITRUM_ALCHEMY_SEPOLIA_RPC_URL} \
	--private-key ${BRAVE_METAMASK_PRIVATE_KEY_1}
read-arbitrum-sepolia-alchemy:
	cast call $(ARBITRUM_ALCHEMY_SEPOLIA_SIMPLE_STORAGE_CONTRACT_ADDRESS) "retrieve()" \
	--rpc-url ${ARBITRUM_ALCHEMY_SEPOLIA_RPC_URL} \
	--private-key ${BRAVE_METAMASK_PRIVATE_KEY_1}
verify-arbitrum-sepolia-alchemy:
	forge verify-contract \
		$(ARBITRUM_ALCHEMY_SEPOLIA_SIMPLE_STORAGE_CONTRACT_ADDRESS) \
		SimpleStorage.sol

# BASE SEPOLIA ALCHEMY
deploy-base-sepolia-alchemy:
	forge script script/DeploySimpleStorage.s.sol \
		--rpc-url ${BASE_ALCHEMY_SEPOLIA_RPC_URL} \
		--private-key ${BRAVE_METAMASK_PRIVATE_KEY_1} \
		--broadcast
send-base-sepolia-alchemy:
	cast send $(BASE_ALCHEMY_SEPOLIA_SIMPLE_STORAGE_CONTRACT_ADDRESS) \
		"store(uint256)" \
		888 \
	--rpc-url ${BASE_ALCHEMY_SEPOLIA_RPC_URL} \
	--private-key ${BRAVE_METAMASK_PRIVATE_KEY_1}
read-base-sepolia-alchemy:
	cast call $(BASE_ALCHEMY_SEPOLIA_SIMPLE_STORAGE_CONTRACT_ADDRESS) "retrieve()" \
	--rpc-url ${BASE_ALCHEMY_SEPOLIA_RPC_URL} \
	--private-key ${BRAVE_METAMASK_PRIVATE_KEY_1}
verify-base-sepolia-alchemy:
	forge verify-contract \
		$(ARBITRUM_ALCHEMY_SEPOLIA_SIMPLE_STORAGE_CONTRACT_ADDRESS) \
		SimpleStorage.sol

format:
	forge fmt

cast:
	cast --to-base $(hex) dec