pragma solidity ^0.4.18;

contract JoCoin {
    // public store of all balances
    mapping (address => uint) balances;
    address public creator; // the exchange owner will be the one to create the coin
    address public owner; // the owner is the freelance worker for whom the coin was created
    string public name;
    string public symbol;
    uint public decimals;
    uint public price; // price that user wants to charge (KRW/coin)

    // define initial supply tokens to the creator of the contract
    // after following all the steps in the README file
    // 1. go to the TOKENS tab in metamask
    // 2. select "ADD TOKEN" button
    // 3. insert the token address from the migration callback
    // 4. add the token to get the entire initial supply
    function JoCoin(uint256 initialSupply) public {
        // give the creator all of the initial supply
        balances[msg.sender] = initialSupply;
        creator = msg.sender;
        name = "JoCoin";
        symbol = "JCN";
        decimals = 2;
    }

	event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event ErrorMessage(address currentUser, string errorType, string errorMessage);

    function setOwner(address coinOwner) public returns (bool success) {
        if (msg.sender == creator) {
            owner = coinOwner;
            return true;
        } else {
            ErrorMessage(msg.sender, "setOwner", "msg.sender is not contract creator");
            return false;
        }
    }

	function sendCoin(address receiver, uint amount) public returns(bool sufficient) {
		if (balances[msg.sender] < amount) {
            ErrorMessage(msg.sender, "sendCoin", "Not enough coin in balance");
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