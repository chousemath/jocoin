pragma solidity ^0.4.18;

contract JoCoin {
    // public store of all balances
    mapping (address => uint) balances;
    string public name;
    string public symbol;
    uint public decimals;

    // define initial supply tokens to the creator of the contract
    // after following all the steps in the README file
    // 1. go to the TOKENS tab in metamask
    // 2. select "ADD TOKEN" button
    // 3. insert the token address from the migration callback
    // 4. add the token to get the entire initial supply
    function JoCoin(uint256 initialSupply) public {
        // give the creator all of the initial supply
        balances[msg.sender] = initialSupply;
        name = "JoCoin";
        symbol = "JCN";
        decimals = 2;
    }

	event Transfer(address indexed _from, address indexed _to, uint256 _value);

	function sendCoin(address receiver, uint amount) public returns(bool sufficient) {
		if (balances[msg.sender] < amount) {
            return false;
        }
		balances[msg.sender] -= amount;
		balances[receiver] += amount;
		Transfer(msg.sender, receiver, amount);
		return true;
	}

	function getBalance(address addr) public view returns(uint) {
		return balances[addr];
	}
}