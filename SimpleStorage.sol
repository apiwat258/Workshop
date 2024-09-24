// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// Step 1: Basic Simple Storage
contract SimpleStorage {
    uint256 public storedData;

    // Set the stored data globally
    function setGlobal(uint256 _data) public {
        storedData = _data;
    }

    // Get the stored data globally
    function getGlobal() public view returns (uint256) {
        return storedData;
    }
}

// Step 2: Adding Event Logging for Data Changes
/*contract SimpleStorageWithEvent {
    uint256 public storedData;

    // Event for logging data updates
    event DataUpdated(uint256 newData);

    // Set the stored data and emit event
    function setGlobal(uint256 _data) public {
        storedData = _data;
        emit DataUpdated(_data); // Emit the event when data changes
    }

    // Get the stored data globally
    function getGlobal() public view returns (uint256) {
        return storedData;
    }
}*/

// Step 3: Restricting Access with Modifiers (onlyOwner)
/*contract SimpleStorageWithAccessControl {
    uint256 public storedData;
    address public owner; // Store the contract owner address

    // Event for logging data updates
    event DataUpdated(uint256 newData);

    // Modifier to allow only the contract owner to set data
    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    // Constructor to set the contract deployer as the owner
    constructor() {
        owner = msg.sender;
    }

    // Set the stored data and emit event (restricted to owner)
    function setGlobal(uint256 _data) public onlyOwner {
        storedData = _data;
        emit DataUpdated(_data); // Emit the event when data changes
    }

    // Get the stored data globally
    function getGlobal() public view returns (uint256) {
        return storedData;
    }
}*/

// Step 4: Storing Data for Multiple Users with Mappings
/*contract SimpleStorageWithMapping {
    // Mapping to store data for each user
    mapping(address => uint256) public userStoredData;

    // Event for logging data updates
    event DataUpdated(uint256 newData);

    // Store data for each user
    function set(uint256 _data) public {
        userStoredData[msg.sender] = _data;
        emit DataUpdated(_data); // Emit the event when data changes
    }

    // Get the stored data for a specific user
    function get(address _user) public view returns (uint256) {
        return userStoredData[_user];
    }
}*/
