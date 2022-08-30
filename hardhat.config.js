require('@openzeppelin/hardhat-upgrades');
require("@nomiclabs/hardhat-waffle");
require('hardhat-docgen');
require('dotenv').config();


// console.log(process.env.ALCHEMY_RPC_URL);
// console.log(process.env.SIGNER_PRIV_KEY);

// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity:{
    version:"0.8.4",
    settings: {
      optimizer: {
        enabled: true,
        runs: 1000,
      },
    },
  },
  networks: {
    rinkeby: {
      url: process.env.ALCHEMY_RPC_URL,
      accounts: [process.env.SIGNER_PRIV_KEY],
      timeout: 15000000
    }
  },
  mocha: {
    timeout: 21000000,
  },
  etherscan: {
    apiKey: {
      rinkeby: process.env.ETHERSCAN_API_KEY
    }
  }
};