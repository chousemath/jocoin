```bash
$ mkdir jocoin
$ cd jocoin
$ truffle init
```

`Add the following files to your contracts directory`

```solidity
// contracts/ConvertLib.sol

pragma solidity ^0.4.4;

library ConvertLib{
	function convert(uint amount,uint conversionRate) public pure returns (uint convertedAmount)
	{
		return amount * conversionRate;
	}
}
```

```solidity
// contracts/Metacoin.sol

pragma solidity ^0.4.18;

import "./ConvertLib.sol";

// This is just a simple example of a coin-like contract.
// It is not standards compatible and cannot be expected to talk to other
// coin/token contracts. If you want to create a standards-compliant
// token, see: https://github.com/ConsenSys/Tokens. Cheers!

contract MetaCoin {
	mapping (address => uint) balances;

	event Transfer(address indexed _from, address indexed _to, uint256 _value);

	function MetaCoin() public {
		balances[tx.origin] = 10000;
	}

	function sendCoin(address receiver, uint amount) public returns(bool sufficient) {
		if (balances[msg.sender] < amount) return false;
		balances[msg.sender] -= amount;
		balances[receiver] += amount;
		Transfer(msg.sender, receiver, amount);
		return true;
	}

	function getBalanceInEth(address addr) public view returns(uint){
		return ConvertLib.convert(getBalance(addr),2);
	}

	function getBalance(address addr) public view returns(uint) {
		return balances[addr];
	}
}
```

> Create the contract for your token

```solidity
// contracts/JoCoin.sol

pragma solidity ^0.4.18;

contract JoCoin {
    // public store of all balances
    mapping (address => uint256) public balanceOf;
    string public name;
    string public symbol;
    uint public decimals;

    function getName() public view returns (string) {
        return name;
    }

    // define initial supply tokens to the creator of the contract
    function JoCoin(uint256 initialSupply) public {
        // give the creator all of the initial supply
        balanceOf[msg.sender] = initialSupply;
        name = "JoCoin";
        symbol = "JCN";
        decimals = 2;
    }
}
```

> Add the necessary migration file (e.g. `migrations/2_deploy_contracts.js`)

```javascript
var ConvertLib = artifacts.require('./ConvertLib.sol');
var Metacoin = artifacts.require('./Metacoin.sol');
var JoCoin = artifacts.require('./JoCoin.sol');

module.exports = function(deployer) {
  deployer.deploy(ConvertLib);
  deployer.link(ConvertLib, Metacoin);
  deployer.deploy(Metacoin);
  // total amount of coins
  deployer.deploy(JoCoin, 10000000000000000000000).then(function() {
    // you will need the address to add your token to metamask
    console.log('\n\n\naddress:', JoCoin.address);
  });
};
```

```bash
# make sure Ganache GUI is started
# make sure you are logged into metamask
$ truffle compile
$ truffle migrate --reset
$ truffle deploy
```

> Final steps...

* 1. go to the TOKENS tab in metamask
* 2. select "ADD TOKEN" button
* 3. insert the token address from the migration callback
* 4. add the token to get the entire initial supply