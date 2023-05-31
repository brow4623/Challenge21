pragma solidity ^0.5.0;

import "./KaseiCoin.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/Crowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/emission/MintedCrowdsale.sol";


// Have the KaseiCoinCrowdsale contract inherit the following OpenZeppelin:
// * Crowdsale
// * MintedCrowdsale

/*contract KaseiCoinCrowdsale { // UPDATE THE CONTRACT SIGNATURE TO ADD INHERITANCE
    
    // Provide parameters for all of the features of your crowdsale, such as the `rate`, `wallet` for fundraising, and `token`.
    constructor(
        // YOUR CODE HERE!
    ) public Crowdsale(rate, wallet, token) {
        // constructor can stay empty
    }
}
*/



contract KaseiCoinCrowdsale is Crowdsale, MintedCrowdsale {
    constructor(
        uint256 rate,    // Rate of tokens per wei
        address payable wallet,    // Address where the funds are collected
        ERC20 token    // The token being sold
    ) public Crowdsale(rate, wallet, token) {
        // constructor can stay empty
    }
}




/*
contract KaseiCoinCrowdsaleDeployer {
    // Create an `address public` variable called `kasei_token_address`.
    // YOUR CODE HERE!
    // Create an `address public` variable called `kasei_crowdsale_address`.
    // YOUR CODE HERE!

    // Add the constructor.
    constructor(
       // YOUR CODE HERE!
    ) public {
        // Create a new instance of the KaseiCoin contract.
        // YOUR CODE HERE!
        
        // Assign the token contract’s address to the `kasei_token_address` variable.
        // YOUR CODE HERE!

        // Create a new instance of the `KaseiCoinCrowdsale` contract
        // YOUR CODE HERE!
            
        // Aassign the `KaseiCoinCrowdsale` contract’s address to the `kasei_crowdsale_address` variable.
        // YOUR CODE HERE!

        // Set the `KaseiCoinCrowdsale` contract as a minter
        // YOUR CODE HERE!
        
        // Have the `KaseiCoinCrowdsaleDeployer` renounce its minter role.
        // YOUR CODE HERE!
    }
}
*/


contract KaseiCoinCrowdsaleDeployer {
    address public kasei_token_address;
    address public kasei_crowdsale_address;

    constructor(
        string memory name,
        string memory symbol,
        uint256 initial_supply,
        uint256 rate,
        address payable wallet
    ) public {
        // Create a new instance of the KaseiCoin contract.
        KaseiCoin kaseiToken = new KaseiCoin(name, symbol, initial_supply);
        
        // Assign the token contract’s address to the `kasei_token_address` variable.
        kasei_token_address = address(kaseiToken);

        // Create a new instance of the `KaseiCoinCrowdsale` contract
        KaseiCoinCrowdsale kaseiCrowdsale = new KaseiCoinCrowdsale(rate, wallet, kaseiToken);
            
        // Assign the `KaseiCoinCrowdsale` contract’s address to the `kasei_crowdsale_address` variable.
        kasei_crowdsale_address = address(kaseiCrowdsale);

        // Set the `KaseiCoinCrowdsale` contract as a minter
        kaseiToken.addMinter(kasei_crowdsale_address);
        
        // Have the `KaseiCoinCrowdsaleDeployer` renounce its minter role.
        kaseiToken.renounceMinter();
    }
}