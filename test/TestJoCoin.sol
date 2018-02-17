pragma solidity ^0.4.17;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/JoCoin.sol";

contract TestJoCoin {

    JoCoin jocoin = JoCoin(DeployedAddresses.JoCoin());
    address creator;
    address user2 = 0xf17f52151EbEF6C7334FAD080c5704D77216b732;

    function testCreatorGetsInitialSupply() public {
        uint expectedInitialSupply = 10000000000000000000000;
        uint initialSupply = jocoin.getBalance(msg.sender);
        creator = msg.sender;
        Assert.equal(initialSupply, expectedInitialSupply, "Creator should get entirety of initial supply");
    }

    function testOwnerAssignment() public {
        Assert.equal(jocoin.creator(), msg.sender, "Creator of the coin should be assigned as the owner");
    }

    function testUserCanSendCoin() public {
        uint initialSupply = 10000000000000000000000;
        uint value = 100;
        uint expectedSenderBalance = initialSupply - value;
        uint expectedReceiverBalance = value;
        // sendCoin(address receiver, uint amount)
        jocoin.sendCoin(user2, value);
        Assert.equal(jocoin.getBalance(msg.sender), expectedSenderBalance, "Correct amount should be deducted from sender's balance");
        Assert.equal(jocoin.getBalance(user2), expectedReceiverBalance, "Correct ammount should be added to receiver's balance"); 
    }

    function testCreatorCanSetOwner() public {
        jocoin.setOwner(user2);
        Assert.equal(jocoin.owner(), user2, "Creator of the coin should be able to set the owner of the coin");
    }
}