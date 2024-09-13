// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Voting {
    // State variables
    address public owner; // Owner of the contract
    mapping(address => bool) public voters; // Keeps track of registered voters
    mapping(string => uint256) public votes; // Stores vote count for each candidate
    string[] public candidates; // Array of candidates

    // Event emitted whenever a vote is cast
    event VoteCasted(address indexed voter, string candidate);

    // Modifier to restrict access to the contract owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    // Modifier to ensure only registered voters can vote
    modifier onlyVoter() {
        require(voters[msg.sender], "You are not registered to vote");
        _;
    }

    // Constructor to initialize contract owner and candidates
    constructor(string[] memory _candidates) {
        owner = msg.sender; // Set the contract deployer as the owner
        candidates = _candidates; // List of candidates
    }

    // Function to register a voter (Only owner can register)
    function registerVoter(address _voter) public onlyOwner {
        voters[_voter] = true; // Add voter to the mapping
    }

    // Function to cast a vote (Only registered voters can vote)
    function vote(string memory _candidate) public onlyVoter {
        require(isValidCandidate(_candidate), "Candidate does not exist");
        votes[_candidate]++; // Increase the vote count for the candidate
        emit VoteCasted(msg.sender, _candidate); // Emit an event for transparency
    }

    // Function to get the vote count of a specific candidate
    function getVotes(string memory _candidate) public view returns (uint256) {
        require(isValidCandidate(_candidate), "Candidate does not exist");
        return votes[_candidate]; // Return the vote count for the candidate
    }

    // Private function to check if the candidate is valid
    function isValidCandidate(string memory _candidate) private view returns (bool) {
        for (uint i = 0; i < candidates.length; i++) {
            if (keccak256(abi.encodePacked(candidates[i])) == keccak256(abi.encodePacked(_candidate))) {
                return true;
            }
        }
        return false;
    }
}