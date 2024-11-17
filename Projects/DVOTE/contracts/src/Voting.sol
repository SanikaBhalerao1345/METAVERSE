// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

contract Voting{

struct Candidate{
 string name;
 uint voteCount;
}

address public owner;
string public electionName;

mapping(address => bool) public voted;
Candidate[] public candidates;
uint public totalVotes;


constructor(string memory _name) {
  owner = msg.sender;
  electionName = _name;
}

error Voting__NotOwner();
error Voting__AlreadyVoted();
error Voting__IncorrectVoteIndex();


modifier ownerOnly(){
 require(msg.sender == owner, Voting__NotOwner());
 _;
}

function addCandidate(string memory _name) public ownerOnly{
  candidates.push(Candidate(_name, 0));
}

function vote(uint _voteIndex) public {
  require(!voted[msg.sender], Voting__AlreadyVoted());
  require(_voteIndex<candidates.length, Voting__IncorrectVoteIndex());
  voted[msg.sender] = true;
  candidates[_voteIndex].voteCount += 1;
  totalVotes +=1;
}

function getCandidates() public view returns (Candidate[] memory) {
  return candidates;
}

function getTotalVotes() public view returns (uint) {
  return totalVotes;
}

}
  