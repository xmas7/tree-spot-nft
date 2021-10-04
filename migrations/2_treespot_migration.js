const TreeSpotNFT = artifacts.require("TreeSpotNFT");

module.exports = async function (deployer) {
  deployer.deploy(TreeSpotNFT);

  const treeSpotNFT = await TreeSpotNFT.deployed();

  for (let i = 0; i< 15; i ++) {
    await treeSpotNFT.mint("token" + i);
  }
};
