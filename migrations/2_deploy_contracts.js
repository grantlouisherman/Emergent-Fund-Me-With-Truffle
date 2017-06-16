var Organization = artifacts.require("./Organization.sol");


module.exports = function(deployer) {
  deployer.deploy(Organization, {gas: 40000005});
};
