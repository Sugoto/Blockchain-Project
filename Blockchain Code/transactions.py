from web3 import Web3

# Ethereum node (Rinkeby testnet) and contract details
infura_url = "https://rinkeby.infura.io/v3/YOUR_INFURA_PROJECT_ID"
contract_address = "0xYourContractAddress"
contract_abi = [
    # Sample contract ABI
]

# Connect to the Ethereum node
w3 = Web3(Web3.HTTPProvider(infura_url))

# Check if connected to the Ethereum node
if w3.isConnected():
    print("Connected to Ethereum node")
else:
    print("Failed to connect to Ethereum node")
    exit(1)

# Create a contract instance
contract = w3.eth.contract(address=contract_address, abi=contract_abi)

# Example transaction parameters
location = "Kolkata"


# Example of sending a transaction to the contract
def send_transaction():
    try:
        # Account that sends the transaction (replace with your own account)
        sender_address = "0xYourSenderAddress"
        sender_private_key = "YourPrivateKey"

        # Create a transaction
        transaction = contract.functions.addLandRegistryUpdate(
            location
        ).buildTransaction(
            {
                "chainId": 8,  # Rinkeby chain ID
                "gas": 20000,  # Adjust gas limit as needed
                "gasPrice": w3.toWei("42", "gwei"),  # Adjust gas price as needed
                "nonce": w3.eth.getTransactionCount(sender_address),
            }
        )

        # Sign the transaction
        signed_transaction = w3.eth.account.signTransaction(
            transaction, sender_private_key
        )

        # Send the transaction
        txn_hash = w3.eth.sendRawTransaction(signed_transaction.rawTransaction)

        # Wait for the transaction to be mined
        receipt = w3.eth.waitForTransactionReceipt(txn_hash)
        print(f"Transaction Hash: {txn_hash}")
        print(f"Transaction Receipt: {receipt}")

    except Exception as e:
        print(f"Transaction failed: {str(e)}")


# Call the send_transaction function to send a transaction to the smart contract
send_transaction()
