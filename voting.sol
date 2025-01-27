// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VotingSystem {
    // Struct to represent a candidate
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    // Struct to represent a voter
    struct Voter {
        bool authorized;
        bool voted;
        uint vote;
    }

    // Address of the contract owner (administrator)
    address public owner;
    string public electionName;
    uint public totalVotes;

    // Mapping to store voter information
    mapping(address => Voter) public voters;

    // Array to store candidates
    Candidate[] public candidates;

    // Events
    event ElectionStarted(string name);
    event VoterAuthorized(address voter);
    event VoteCasted(address voter, uint candidateId);

    // Modifier to allow only the owner to perform certain actions
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    // Constructor to initialize the election
    constructor(string memory _electionName) {
        owner = msg.sender;
        electionName = _electionName;
        emit ElectionStarted(electionName);
    }

    // Function to add a candidate
    function addCandidate(string memory _name) public onlyOwner {
        candidates.push(Candidate({
            id: candidates.length,
            name: _name,
            voteCount: 0
        }));
    }

    // Function to authorize a voter
    function authorizeVoter(address _voter) public onlyOwner {
        require(!voters[_voter].authorized, "Voter is already authorized");
        voters[_voter].authorized = true;
        emit VoterAuthorized(_voter);
    }

    // Function to vote
    function vote(uint _candidateId) public {
        require(voters[msg.sender].authorized, "You are not authorized to vote");
        require(!voters[msg.sender].voted, "You have already voted");
        require(_candidateId < candidates.length, "Invalid candidate ID");

        voters[msg.sender].voted = true;
        voters[msg.sender].vote = _candidateId;

        candidates[_candidateId].voteCount += 1;
        totalVotes += 1;

        emit VoteCasted(msg.sender, _candidateId);
    }

    // Function to get candidate details
    function getCandidate(uint _candidateId) public view returns (string memory, uint) {
        require(_candidateId < candidates.length, "Invalid candidate ID");
        Candidate memory candidate = candidates[_candidateId];
        return (candidate.name, candidate.voteCount);
    }

    // Function to get the total number of candidates
    function getTotalCandidates() public view returns (uint) {
        return candidates.length;
    }

    // Function to end the election and declare the winner
    function endElection() public onlyOwner view returns (string memory winnerName, uint winnerVoteCount) {
        uint winnerIndex = 0;
        uint highestVoteCount = 0;

        for (uint i = 0; i < candidates.length; i++) {
            if (candidates[i].voteCount > highestVoteCount) {
                highestVoteCount = candidates[i].voteCount;
                winnerIndex = i;
            }
        }

        winnerName = candidates[winnerIndex].name;
        winnerVoteCount = candidates[winnerIndex].voteCount;
    }
}
