var ConvertLib = artifacts.require('./ConvertLib.sol');
var Metacoin = artifacts.require('./Metacoin.sol');
var JoCoin = artifacts.require('./JoCoin.sol');

module.exports = function(deployer) {
  deployer.deploy(ConvertLib);
  deployer.link(ConvertLib, Metacoin);
  deployer.deploy(Metacoin);
  // total amount of coins
  deployer.deploy(JoCoin, 10000000000000000000000).then(function() {
    console.log('\n\n\naddress:', JoCoin.address);
  });
};