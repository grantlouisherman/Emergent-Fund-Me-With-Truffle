const Organization = artifacts.require("./Organization.sol");
const Chat = artifacts.require("./Chat.sol");


module.exports = function(deployer) {
  deployer.deploy(Organization,["Raising Money for Housing Project", "Want to buy a motorcycle!", "Help I need money!!!"]);
  deployer.deploy(Chat,["Lorem ipsum dolor sit amet, consectetuer adipiscing elit.", 
  "Lorem ipsum dolor sit amet, consectetuer adipiscing elit.", 
  "Lorem ipsum dolor sit amet, consectetuer adipiscing elit."]);
};
