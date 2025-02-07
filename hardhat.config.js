require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.20",
  networks: {
    ganache: {
      url: "http://127.0.0.1:8545", 
      accounts: [
        "0xe4ea3369aef9cd226e7507a0a007744b50e324fc60bc8d980aa190d95b1903b9",
        "0xc2769f1a354b1833168a5eaa0075ae0d07fa3fbf3884e8a940454d666784bbcd"
      ],
      ens: { enabled: false },
    },
  },
};
