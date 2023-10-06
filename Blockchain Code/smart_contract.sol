// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GovernmentBlockchain {
    // Structure to represent a block
    struct GovernmentBlock {
        uint256 index;
        uint256 timestamp;
        string data;
        string location;
        string name;
        string previousHash;
        string hash;
    }

    // Mapping to store blocks for land registry updates
    mapping(uint256 => GovernmentBlock) public landRegistryBlocks;

    // Mapping to store blocks for new identity additions
    mapping(uint256 => GovernmentBlock) public identityBlocks;

    // Counter for the number of blocks
    uint256 public landRegistryBlockCount;
    uint256 public identityBlockCount;

    // Event to log block addition
    event BlockAdded(
        uint256 indexed index,
        uint256 timestamp,
        string data,
        string location,
        string name,
        string previousHash,
        string hash
    );

    // Function to add a land registry update block
    function addLandRegistryUpdate(string memory _location) public {
        landRegistryBlockCount++;
        GovernmentBlock memory newBlock = GovernmentBlock({
            index: landRegistryBlockCount,
            timestamp: block.timestamp,
            data: "Land Registry Update",
            location: _location,
            name: "",
            previousHash: landRegistryBlockCount == 1 ? "" : landRegistryBlocks[landRegistryBlockCount - 1].hash,
            hash: ""
        });
        newBlock.hash = calculateHash(newBlock);
        landRegistryBlocks[landRegistryBlockCount] = newBlock;
        emit BlockAdded(
            newBlock.index,
            newBlock.timestamp,
            newBlock.data,
            newBlock.location,
            newBlock.name,
            newBlock.previousHash,
            newBlock.hash
        );
    }

    // Function to add a new identity block
    function addNewIdentity(string memory _name) public {
        identityBlockCount++;
        GovernmentBlock memory newBlock = GovernmentBlock({
            index: identityBlockCount,
            timestamp: block.timestamp,
            data: "New Identity Added",
            location: "",
            name: _name,
            previousHash: identityBlockCount == 1 ? "" : identityBlocks[identityBlockCount - 1].hash,
            hash: ""
        });
        newBlock.hash = calculateHash(newBlock);
        identityBlocks[identityBlockCount] = newBlock;
        emit BlockAdded(
            newBlock.index,
            newBlock.timestamp,
            newBlock.data,
            newBlock.location,
            newBlock.name,
            newBlock.previousHash,
            newBlock.hash
        );
    }

    // Function to calculate the hash of a block
    function calculateHash(GovernmentBlock memory _block) private pure returns (string memory) {
        return string(abi.encodePacked(
            _block.index,
            _block.timestamp,
            _block.data,
            _block.location,
            _block.name,
            _block.previousHash
        ));
    }
}