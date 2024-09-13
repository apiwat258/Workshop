// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Voting {
    // State variables
    address public owner;
    mapping(address => bool) public voters;
    mapping(string => uint256) public votes;

    // Modifier to restrict access to the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    // Function to register a voter
    function registerVoter(address _voter) public onlyOwner {
        voters[_voter] = true;
    }

    // Function to cast a vote
    function vote(string memory candidate) public {
        require(voters[msg.sender], "Not registered to vote");
        votes[candidate]++;
    }

    // Function to get vote count
    function getVotes(string memory candidate) public view returns (uint256) {
        return votes[candidate];
    }
}