const Realities = artifacts.require("Realities");
const Reciever = artifacts.require("RealityReward");

module.exports = async function (deployer) {
  await deployer.deploy(Realities);
  const realityAddress = await Realities.deployed()
  await deployer.deploy(Reciever, realityAddress.address)
};
