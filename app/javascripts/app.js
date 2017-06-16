// Import the page's CSS. Webpack will know what to do with it.
import "../stylesheets/app.css";

// Import libraries we need.
import { default as Web3} from 'web3';
import { default as contract } from 'truffle-contract'

// Import our contract artifacts and turn them into usable abstractions.
import organization_artifacts from '../../build/contracts/Organization.json'

// MetaCoin is our usable abstraction, which we'll use through the code below.
var Organization = contract(organization_artifacts);

// The following code is simple to show off interacting with your contracts.
// As your needs grow you will likely need to change its form and structure.
// For application bootstrapping, check out window.addEventListener below.
var accounts;
var account;
var numberOfProposals=0;

window.App = {
  start: () =>  {
    var self = this;
    
    // Bootstrap the MetaCoin abstraction for Use.
    Organization.setProvider(web3.currentProvider);
    // Get the initial account balance so it can be displayed.
  
    web3.eth.getAccounts(function(err, accs) {
      if (err != null) {
        alert("There was an error fetching your accounts.");
        return;
      }

      if (accs.length == 0) {
        alert("Couldn't get any accounts! Make sure your Ethereum client is configured correctly.");
        return;
      }

      accounts = accs;
      account = accounts[9];
      document.getElementById('accountInfo').innerHTML = account;
      
    });
  },
 
  addProposal: function() {
    var self = this;
    var meta;

    Organization.deployed().then(function(instance) {
      meta = instance;
      const name = document.getElementById('propName').value;
      const amount = document.getElementById('startingFunds').value;  
      const description = document.getElementById('propDescription').value;

      return meta.addProposal(amount,description,name,{data: Organization.code, 
        from: web3.eth.accounts[0], gas: 4700000})
    }).then(function(value) {
        console.log("WORKS!!!")
        console.log(value)
    }).catch(function(e) {
      console.log(e);
    });
  },

  voteForProposal:function(index){
         var self = this;
          var meta;

    Organization.deployed().then(function(instance) {
      meta = instance;
      return meta.voteForProposal(index,{data: Organization.code, 
        from: web3.eth.accounts[0], gas: 4700000 })
    })
    .then(updatedVotes => {
      console.log(updatedVotes);
    })
    .catch(function(e) {
      console.log(e);
    });
  },

  getVotes: function(){
    var self = this;
    var meta;
    Organization.deployed().then(function(instance) {
      meta= instance;
      let votesArray = []
      for(let i=0;i<3;i++){
        votesArray.push(meta.getProposalVotesIndex.call(i))
      }
      return Promise.all(votesArray);
    })
    .then(votes => {
      document.getElementById("zero").innerHTML = votes[0];
      document.getElementById("one").innerHTML = votes[1];
      document.getElementById("two").innerHTML = votes[2];
    })
  }


};

window.addEventListener('load', function() {
  // Checking if Web3 has been injected by the browser (Mist/MetaMask)
  if (typeof web3 !== 'undefined') {
    console.warn("Using web3 detected from external source. If you find that your accounts don't appear or you have 0 MetaCoin, ensure you've configured that source properly. If using MetaMask, see the following link. Feel free to delete this warning. :) http://truffleframework.com/tutorials/truffle-and-metamask")
    // Use Mist/MetaMask's provider
    window.web3 = new Web3(web3.currentProvider);
  } else {
    console.warn("No web3 detected. Falling back to http://localhost:8545. You should remove this fallback when you deploy live, as it's inherently insecure. Consider switching to Metamask for development. More info here: http://truffleframework.com/tutorials/truffle-and-metamask");
    // fallback - use your fallback strategy (local node / hosted node + in-dapp id mgmt / fail)
    window.web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));
  }
  
  App.start();
  App.getVotes();
});


