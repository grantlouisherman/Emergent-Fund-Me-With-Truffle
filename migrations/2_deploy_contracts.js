var Organization = artifacts.require("./Organization.sol");


module.exports = function(deployer) {
  deployer.deploy(Organization,["Raising Money for Housing Project", "Want to buy a motorcycle!", "Help I need money!!!"]);
};
