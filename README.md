STAKING WITH UPGRADEABLE SMART CONTRACT with APR rewards

This Project is regarding the representation of the staking and it manages the data from two contracts and also stakes and calculates all the perks and rewards.

What we will achieve by this:
Create a Upgradeable Smart Contract with Following Details:
- Create a Staking Contract for Stable Coin Staking  for 1 month, 6months, and 12 months with 5,10, 15% APR rewards w.r.t (your token) ERC 20 respectively, After 1 year it will be stable at 15%
- Get the Price of Stable Coin using Chainlink Aggregator.
- Also create a logic for Perks if the USD value of stable coins staked is more than $100 user gets extra 2% APR, more than $500 gets extra 5%, more than $1000 get 10% extra APR.

Technology addons and Uses

- [Hardhat](https://github.com/nomiclabs/hardhat): compile and run the smart contracts on a local development network
- [Ethers](https://github.com/ethers-io/ethers.js/): renowned Ethereum library and wallet implementation
- [Waffle](https://github.com/EthWorks/Waffle): tooling for writing comprehensive smart contract tests
- [Solhint](https://github.com/protofire/solhint): linter

## Usage

### Pre Requisites

Before running any command, make sure to install dependencies:

```sh
$ npm install
```

### Compile

Compile the smart contracts with Hardhat:

```sh
$ npx hardhat compile
```

### Test

Run the Mocha tests on rinkeby:

```sh
$ npx hardhat test -- network rinkeby
```

### Deploy contract to netowrk (requires Mnemonic and infura API key)

```
npx hardhat run --network rinkeby ./scripts/deploy.js
```

### Validate a contract with etherscan (requires API ke)

```
npx hardhat verify --network <network> <DEPLOYED_CONTRACT_ADDRESS> "Constructor argument 1"
```


### Screenshots

Deploying the contracts in remix
<img width="1440" alt="Screenshot 2022-06-29 at 3 42 25 PM" src="https://user-images.githubusercontent.com/86094155/176412168-4fc306f9-ae6f-4a0d-8ac8-258b58b4ac95.png">

After Transfering the tokens in the staking contract
<img width="1440" alt="Screenshot 2022-06-29 at 4 26 43 PM" src="https://user-images.githubusercontent.com/86094155/176420508-8222c95b-3c5e-493b-a3e0-95e1b7c2773a.png">

Initialising the contract as upgradeable
<img width="1440" alt="Screenshot 2022-06-29 at 6 41 04 PM" src="https://user-images.githubusercontent.com/86094155/176444605-c6ba6694-13f8-4c46-88a9-88232aa0a429.png">

Showcasing the Upgrade function
<img width="1440" alt="Screenshot 2022-06-29 at 6 47 13 PM" src="https://user-images.githubusercontent.com/86094155/176445735-0d87b247-9014-4f7f-b6e0-3abefeeb7dff.png">

Deploying the Contract on a proxy address
<img width="1440" alt="Screenshot 2022-07-01 at 6 06 56 AM" src="https://user-images.githubusercontent.com/86094155/176800241-038bb4dd-e47b-4040-8d74-6dfbaf179b70.png">






### Transaction Hashes
 PerkToken is deployed on 0x005D243C654De3A2D4422A62347C46766086159F
 https://rinkeby.etherscan.io/address/0x005d243c654de3a2d4422a62347c46766086159f

 MyToken is deployed on 0x5c8708d0fe5B3e77226c71323AaB09d3E4FB575A
 https://rinkeby.etherscan.io/address/0x5c8708d0fe5B3e77226c71323AaB09d3E4FB575A

 Staking Contract is deployed on: 0x26362cBc969fde804b7f546731e0546B5FfF4D52
 https://rinkeby.etherscan.io/address/0x26362cbc969fde804b7f546731e0546b5fff4d52

 PriceAggregator is deployed on: 0x4335162bF28136838B2d16C55e93Ca92E1cc3c87
 https://rinkeby.etherscan.io/address/0x4335162bf28136838b2d16c55e93ca92e1cc3c87
 
 
 ### Functionality:

 Approving Mytoken To Staking Contract:
 https://rinkeby.etherscan.io/tx/0x56888368b0b98d75e28157cc58fde06a5db58786a8023814a70c4994222bcc23

 Initializing The Smart Contract:
 https://rinkeby.etherscan.io/tx/0xe231d3fb435d23cf6a2975fd2f96c8f88bb7dd56738e6e86b83ab0464fb6fd5b

 Claiming MyToken:
 https://rinkeby.etherscan.io/tx/0x7620350e794b364e65e18d96fe3f754878c5b5c20d6246e53b6c07f02ffbd1bd

 Transfering perk tokens to staking:
 https://rinkeby.etherscan.io/tx/0xe6762320ca6321a6869e273574fec382b808f8a437b4e7e71ce34f57fbbb9442

 Transfering MyTokens to staking:
 https://rinkeby.etherscan.io/tx/0x8e3564e35714c8c84769d2234f55878817838db50956cf3ef4ab774c14fc5329

Depositing MyTokens to staking:
https://rinkeby.etherscan.io/tx/0xa4527b21fae0bad52263e3a37f676f07ea7c56a829f1530091d03717304937c9

Unstaking Mytokens with rewards to from staking:
https://rinkeby.etherscan.io/tx/0xb1b790fb726b41cbafff4b2ddaaf8f361daa063d270ff37baea663efa9ee1c55



### Added plugins

- Gas reporter [hardhat-gas-reporter](https://hardhat.org/plugins/hardhat-gas-reporter.html)
- Etherscan [hardhat-etherscan](https://hardhat.org/plugins/nomiclabs-hardhat-etherscan.html)



## License

UNKNOWN
