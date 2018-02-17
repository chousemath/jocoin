pragma solidity ^0.4.17;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/JoCoin.sol";

contract TestJoCoin {

    JoCoin jocoin = JoCoin(DeployedAddresses.JoCoin());
    
    function testCreatorGetsInitialSupply() public {
        uint expectedInitialSupply = 10000000000000000000000;
        uint initialSupply = jocoin.getBalance(msg.sender);
        Assert.equal(initialSupply, expectedInitialSupply, "Creator should get entirety of initial supply");
    }
}