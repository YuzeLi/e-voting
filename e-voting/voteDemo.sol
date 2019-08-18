pragma solidity ^0.4.24;

// Smart Contract Voting: Voters and Candidates, by default, each person can
// only vote once, and cannot vote repeatedly. Candidates cannot vote
// (including not being able to vote by themselves or other candidates)

contract VoteDemo{

// Create a voter structure
    struct Voter{
        address addr; // voter address
        bool vote;  // If true, the person has voted (restricted voting)
        uint amount; // The current number of votes defaults to 1
    }

    // Create a candidate structure
    struct Candidate{
        address addr;   // Candidate address
        uint get;   // The number of votes the current candidate receives
        bool win;   // win or false
    }

    // Store voters and candidates in the platform
    mapping (address => Voter) public voters;
    // Candidate mapping
    mapping (address => Candidate) public candidates;

    // Initialize candidate
    function initCandidate(address addr){
        candidates[addr] = Candidate(addr,0,false);
    }

    // Initialize voters
    function initVote(address addr){
        if(voters[addr].vote){
            return;  // This person has voted and can return
        }
   // This person has voted before and should not be added to this mapping.
        voters[addr].addr = addr;
        voters[addr].vote = false;
        voters[addr].amount = 1;
    }

    // Candidates cannot vote
    // (including not being able to vote by themselves or other candidates)
    function vote(address candidate){
        // The person calling this function is the voter
        Voter v =voters[msg.sender];
        // If the person has voted, or if the person is a candidate, they cannot vote.
        if(v.vote || v.addr == candidate)
           return;
        // Vote for the candidate
        candidates[candidate].get += v.amount;
        // Record that the current voter has voted
        v.vote = true;
    }

    // Judge the successful candidate
    function success(address addr1,address addr2) returns (address){
        // Judging the winning investor by the number of votes
        if(candidates[addr1].get > candidates[addr2].get){
            // addr1 wins
            candidates[addr1].win = true;
            return addr1;
        }else{
          // addr 2 wins
            candidates[addr2].win = true;
            return addr2;
        }
    }

}
