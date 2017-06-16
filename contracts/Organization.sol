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
  
  bytes32[] public proposalList; 
  


  event ProposalAdded(uint code, uint amount, string description, int numberOfVotes , string name);
  
  function addProposal(uint amount, string description , string name) {
    proposals.push(Proposal(numberOfProposals,amount,description,0,name));
    ProposalAdded(numberOfProposals,amount,description, 0, name);
    numberOfProposals++;
    
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

    function getProposalAmount(uint index) returns (uint){
        return proposals[index].amount;
    }

    function getProposal(uint index) returns (uint , string, string){
        uint amount = proposals[index].amount;
        string name = proposals[index].name;
        string description = proposals[index].description;
        return (amount, name, description);
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
    
    function voteForProposal(uint index) returns (uint) {
        proposals[index].numberOfVotes++;
        return proposals[index].numberOfVotes;
      }

    function getProposalVotesIndex(uint index) returns (uint) {
        return proposals[index].numberOfVotes;
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
  
  function Organization(bytes32[] names) {
      proposalList = names;
      for(uint i =0;i<names.length;i++){
        addProposal(100, 
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur dui nisi, laoreet ut auctor sed, sodales ut justo. Sed vitae mi nec eros luctus rhoncus in vitae augue.",
        bytes32ToString(names[i]));
      }
    }

}









