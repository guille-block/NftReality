const Realities = artifacts.require("Realities");

module.exports = async function (deployer) {
  await deployer.deploy(Realities);
};