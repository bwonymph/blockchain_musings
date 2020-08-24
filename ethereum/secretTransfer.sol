pragma solidity ^0.5.1;

//This code has not been profesionally audited, I do not make any
//Promises of safety or correctness. Use at own risk. 


//Objective of this contract is to create a two contract escrow 
//mechanism. This would allow token escrow between blockchains.

//Example: Alice and Bob exchange 500 tokens each.
// Alice creates contract with 0 ETH and Hash.
// Bob copies contract 
// Alice loads Bob's contract with 500 ETH
// Bob loads Alice's with 500 ETH
// Alice calls her contract using her key, pre-image of hash
// Alice receives Bob's funds in her contract
// Bob sees key in transaction and sends to his contract
// Bob recieves Alice's funds in his contract


contract secretTransfer{
    
	string ownersHash;
	address payable owner;

	constructor() public payable{
		ownersHash = "1c8aff950685c2ed4bc3174f3472287b56d9517b9c948127319a09a7a36deac8";
		owner = msg.sender;
	}
	
	//Load contract with funds
	function load() public payable{}
	
	//Check contract balance
	function balanceOfSC() public returns(uint256){
	    return address(this).balance;
	}
	
	//Get locked funds
	function receive(string memory _key) public payable{ //key is pre-image of ownersHash
		if (keccak256(abi.encodePacked(keccak256(abi.encodePacked(_key)))) == keccak256(abi.encodePacked(ownersHash))){
			owner.transfer(address(this).balance);
		}
	}
}