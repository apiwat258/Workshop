// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract SimpleStorage {
    uint256 public storedData;

    // Set the stored data
    function set(uint256 _data) public {
        storedData = _data;
    }

    // Get the stored data
    function get() public view returns (uint256) {
        return storedData;
    }
}