pragma solidity ^0.4.6;


contract Organization {
  


  struct Proposal {
    uint code;
    uint amount;
    string description;
    uint numberOfVotes;
    string name;
  }

  Proposal[] public proposals;
  uint public numberOfProposals;
 
  
  event ProposalAdded(uint code, uint amount, string description, int numberOfVotes , string name);


  function addProposal(uint amount, string description , string name) returns (uint) {
    proposals.push(Proposal(numberOfProposals,amount,description,0,name));
    ProposalAdded(numberOfProposals,amount,description, 0, name);
    numberOfProposals++;
    return numberOfProposals;
    
  }



  function proposalExists (uint code) returns (bool) {
    for(uint i = 0; i < proposals.length; i++) {
        if (proposals[i].code == code) {
            return true;
          }
        }
        return false;
    }

    function numOfProposals() returns (uint){
        return numberOfProposals;
      }

    function getProposalName(uint index) returns (string){
        return proposals[index].name;
    }

    function getProposalDescription(uint index) returns (string){
        return proposals[index].description;
    }

    function getProposalIndex(string name) returns (uint){
      for(uint i = 0; i < proposals.length; i++) {
          bytes memory a = bytes(proposals[i].name);
          bytes memory b = bytes(name);
        if (a.length == b.length) {
            return i;
        }
      }
      return 1000000;
    }
    
    function voteFotProposal(uint index) {
        proposals[index].numberOfVotes++;
      }

    function getProposalVotesIndex(uint index) {
        proposals[index].numberOfVotes;
      }



  function bytes32ToString(bytes32 x) constant returns (string) {
    bytes memory bytesString = new bytes(32);
    uint charCount = 0;
    for (uint j = 0; j < 32; j++) {
        byte char = byte(bytes32(uint(x) * 2 ** (8 * j)));
        if (char != 0) {
            bytesString[charCount] = char;
            charCount++;
        }
    }
    bytes memory bytesStringTrimmed = new bytes(charCount);
    for (j = 0; j < charCount; j++) {
        bytesStringTrimmed[j] = bytesString[j];
    }
    return string(bytesStringTrimmed);
  }


}









